"use strict";

const http = require("node:http");
const fs = require("node:fs");
const path = require("node:path");
const os = require("node:os");
const crypto = require("node:crypto");
const { spawn } = require("node:child_process");

const webDir = __dirname;
const toolsDir = path.resolve(webDir, "..");
const repoRoot = path.resolve(toolsDir, "..");
const localizationScript = path.join(toolsDir, "upstream-localization.ps1");
const workerScript = path.join(webDir, "upstream-worker.ps1");
const sourcesPath = path.join(toolsDir, "upstream-sources.json");
const lockPath = path.join(toolsDir, "upstream-lock.json");
const implModsDir = path.join(repoRoot, "impl", "mods");
const implTodoDir = path.join(repoRoot, "impl", "todo");
const runtimeDir = path.join(os.tmpdir(), `teocean-upstream-web-${process.pid}`);
const token = crypto.randomBytes(24).toString("base64");
const host = "127.0.0.1";
const maxLogLength = 200_000;

class HttpError extends Error {
  constructor(statusCode, message) {
    super(message);
    this.statusCode = statusCode;
  }
}

function parseArguments(argv) {
  let port = 8732;
  let noBrowser = false;
  for (let index = 0; index < argv.length; index += 1) {
    const value = argv[index];
    const lower = value.toLowerCase();
    if (lower === "--no-browser" || lower === "-nobrowser") {
      noBrowser = true;
    } else if (lower === "--port" || lower === "-port") {
      port = Number(argv[index + 1]);
      index += 1;
    } else if (lower.startsWith("--port=")) {
      port = Number(value.slice(value.indexOf("=") + 1));
    } else {
      throw new Error(`Unknown argument: ${value}`);
    }
  }
  if (!Number.isInteger(port) || port < 1024 || port > 65535) {
    throw new Error("Port must be an integer between 1024 and 65535.");
  }
  return { port, noBrowser };
}

const options = parseArguments(process.argv.slice(2));
const baseUrl = `http://${host}:${options.port}/`;

for (const requiredFile of [localizationScript, workerScript, sourcesPath, lockPath]) {
  if (!fs.existsSync(requiredFile)) throw new Error(`Required file not found: ${requiredFile}`);
}
fs.mkdirSync(runtimeDir, { recursive: true });

const securityHeaders = {
  "X-Content-Type-Options": "nosniff",
  "Content-Security-Policy": "default-src 'self'; script-src 'self'; style-src 'self'; img-src 'self' data:; connect-src 'self'; base-uri 'none'; form-action 'self'; frame-ancestors 'none'",
};

const staticFiles = new Map([
  ["/", loadStaticFile("index.html", "text/html; charset=utf-8")],
  ["/index.html", loadStaticFile("index.html", "text/html; charset=utf-8")],
  ["/styles.css", loadStaticFile("styles.css", "text/css; charset=utf-8")],
  ["/app.js", loadStaticFile("app.js", "application/javascript; charset=utf-8")],
]);

function loadStaticFile(name, contentType) {
  const content = fs.readFileSync(path.join(webDir, name));
  return {
    content,
    contentType,
    etag: `"${crypto.createHash("sha256").update(content).digest("base64url")}"`,
  };
}

function sendJson(response, statusCode, value) {
  const body = Buffer.from(JSON.stringify(value));
  response.writeHead(statusCode, {
    ...securityHeaders,
    "Content-Type": "application/json; charset=utf-8",
    "Content-Length": body.length,
    "Cache-Control": "no-store",
  });
  response.end(body);
}

function sendStatic(request, response, file) {
  if (request.headers["if-none-match"] === file.etag) {
    response.writeHead(304, { ...securityHeaders, ETag: file.etag, "Cache-Control": "no-cache" });
    response.end();
    return;
  }
  response.writeHead(200, {
    ...securityHeaders,
    "Content-Type": file.contentType,
    "Content-Length": file.content.length,
    "Cache-Control": "no-cache",
    ETag: file.etag,
  });
  response.end(file.content);
}

async function readJsonBody(request) {
  const chunks = [];
  let length = 0;
  for await (const chunk of request) {
    length += chunk.length;
    if (length > 1_048_576) throw new HttpError(413, "请求内容不能超过 1 MB。");
    chunks.push(chunk);
  }
  if (length === 0) throw new HttpError(400, "请求内容为空。");
  try {
    return JSON.parse(Buffer.concat(chunks).toString("utf8"));
  } catch {
    throw new HttpError(400, "请求内容不是有效的 JSON。");
  }
}

function requireToken(request) {
  const supplied = request.headers["x-teocean-token"];
  const expected = Buffer.from(token);
  const actual = Buffer.from(typeof supplied === "string" ? supplied : "");
  if (actual.length !== expected.length || !crypto.timingSafeEqual(actual, expected)) {
    throw new HttpError(403, "请求令牌无效，请刷新页面后重试。");
  }
}

function readJsonFile(filePath, fallback) {
  try {
    const content = fs.readFileSync(filePath, "utf8").replace(/^\uFEFF/, "").trim();
    return content ? JSON.parse(content) : fallback;
  } catch (error) {
    if (error.code === "ENOENT") return fallback;
    throw error;
  }
}

function assertSafeModId(modId) {
  if (typeof modId !== "string" || modId.length > 128 || !/^[A-Za-z0-9][A-Za-z0-9._-]*$/.test(modId)) {
    throw new HttpError(400, "Mod ID 只能包含字母、数字、点、下划线和连字符，且必须以字母或数字开头。");
  }
}

function normalizePaths(values) {
  const result = [];
  for (const value of Array.isArray(values) ? values : []) {
    const rawPath = String(value).trim().replaceAll("\\", "/");
    if (path.isAbsolute(rawPath) || rawPath.startsWith("/")) {
      throw new HttpError(400, `本地化路径必须是仓库内的安全相对路径：${rawPath}`);
    }
    const normalized = rawPath.replace(/^\/+|\/+$/g, "");
    if (!normalized) continue;
    if (normalized.length > 512 || /(^|\/)\.\.(\/|$)/.test(normalized) || normalized.includes("\0")) {
      throw new HttpError(400, `本地化路径必须是仓库内的安全相对路径：${normalized}`);
    }
    if (!result.includes(normalized)) result.push(normalized);
  }
  return result;
}

let stateCache = null;
let stateCacheTime = 0;

function invalidateStateCache() {
  stateCache = null;
  stateCacheTime = 0;
}

function getReportLatestCommit(reportPath) {
  try {
    const match = fs.readFileSync(reportPath, "utf8").match(/^Latest:\s*([0-9a-f]+)\s*$/im);
    return match ? match[1] : null;
  } catch (error) {
    if (error.code === "ENOENT") return null;
    throw error;
  }
}

function getAppState() {
  const now = Date.now();
  if (stateCache && now - stateCacheTime < 300) return stateCache;

  const sources = readJsonFile(sourcesPath, { version: 1, defaultPaths: [], mods: {} });
  const locks = readJsonFile(lockPath, { version: 1, mods: {} });
  const sourceMods = sources.mods && typeof sources.mods === "object" ? sources.mods : {};
  const lockMods = locks.mods && typeof locks.mods === "object" ? locks.mods : {};
  const ids = new Set(Object.keys(sourceMods));
  if (fs.existsSync(implModsDir)) {
    for (const entry of fs.readdirSync(implModsDir, { withFileTypes: true })) {
      if (entry.isDirectory()) ids.add(entry.name);
    }
  }

  const items = [...ids].sort((a, b) => a.localeCompare(b, "en", { sensitivity: "base" })).map((id) => {
    const source = sourceMods[id] ?? null;
    const baseline = lockMods[id] ?? null;
    const baselineCommit = typeof baseline?.baselineCommit === "string" ? baseline.baselineCommit : "";
    const reportLatest = getReportLatestCommit(path.join(implTodoDir, id, "upstream_changed.md"));
    const hasReport = Boolean(reportLatest && reportLatest !== baselineCommit);
    let status = "tracked";
    if (!source) status = "unconfigured";
    else if (!baselineCommit) status = "no-baseline";
    else if (hasReport) status = "needs-update";
    return {
      id,
      status,
      configured: Boolean(source),
      tracked: Boolean(baselineCommit),
      repo: typeof source?.repo === "string" ? source.repo : "",
      ref: typeof source?.ref === "string" && source.ref.trim() ? source.ref : "HEAD",
      paths: Array.isArray(source?.paths) ? source.paths : [],
      baselineCommit,
      updatedAt: typeof baseline?.updatedAt === "string" ? baseline.updatedAt : "",
      hasReport,
    };
  });

  stateCache = {
    token,
    defaultPaths: Array.isArray(sources.defaultPaths) ? sources.defaultPaths : [],
    items,
    stats: {
      total: items.length,
      tracked: items.filter((item) => item.status === "tracked").length,
      needsUpdate: items.filter((item) => item.status === "needs-update").length,
      needsSetup: items.filter((item) => item.status === "unconfigured" || item.status === "no-baseline").length,
    },
    generatedAt: new Date().toISOString(),
  };
  stateCacheTime = now;
  return stateCache;
}

function getActionSpec(payload) {
  const command = typeof payload?.command === "string" ? payload.command : "";
  if (!["add", "init", "check", "accept", "accept-all"].includes(command)) {
    throw new HttpError(400, `不支持的操作：${command}`);
  }
  const modIds = [...new Set((Array.isArray(payload.modIds) ? payload.modIds : []).map((id) => String(id).trim()).filter(Boolean))];
  modIds.forEach(assertSafeModId);
  const spec = { command, modIds, repo: null, ref: null, paths: [], force: Boolean(payload.force), noInit: false };

  if (command === "add") {
    if (modIds.length !== 1) throw new HttpError(400, "添加 Mod 时必须填写一个 Mod ID。");
    const repo = typeof payload.repo === "string" ? payload.repo.trim() : "";
    if (!repo || repo.length > 2048 || /[\r\n]/.test(repo)) throw new HttpError(400, "请填写有效的上游仓库地址。");
    const ref = typeof payload.ref === "string" && payload.ref.trim() ? payload.ref.trim() : "HEAD";
    if (ref.length > 255 || /[\r\n]/.test(ref)) throw new HttpError(400, "Git 分支或引用无效。");
    spec.repo = repo;
    spec.ref = ref;
    spec.paths = normalizePaths(payload.paths);
    spec.noInit = Boolean(payload.noInit);
  } else if (command === "accept" && modIds.length === 0) {
    throw new HttpError(400, "接受基线前至少选择一个 Mod。");
  }
  return spec;
}

let currentTask = null;

function appendTaskOutput(task, chunk) {
  task.output += chunk.toString("utf8");
  if (task.output.length > maxLogLength) {
    task.output = `……前面的日志已省略……\n${task.output.slice(-maxLogLength)}`;
  }
}

function getPublicTask() {
  if (!currentTask) return null;
  return {
    id: currentTask.id,
    command: currentTask.command,
    status: currentTask.status,
    startedAt: currentTask.startedAt,
    finishedAt: currentTask.finishedAt,
    durationSeconds: currentTask.durationSeconds,
    error: currentTask.error,
    output: currentTask.output.trimEnd(),
  };
}

function finishTask(task, status, error = null) {
  if (task !== currentTask || task.status !== "running") return;
  task.status = status;
  task.error = error;
  task.finishedAt = new Date().toISOString();
  task.durationSeconds = Math.round((Date.now() - task.startedAtMs) / 10) / 100;
  fs.rm(task.specPath, { force: true }, () => {});
  invalidateStateCache();
}

function startTask(spec) {
  if (currentTask?.status === "running") throw new HttpError(409, "已有任务正在运行，请等待完成或先取消当前任务。");

  const id = crypto.randomUUID().replaceAll("-", "");
  const specPath = path.join(runtimeDir, `${id}-spec.json`);
  fs.writeFileSync(specPath, JSON.stringify(spec), "utf8");
  const startedAtMs = Date.now();
  const task = {
    id,
    command: spec.command,
    status: "running",
    startedAt: new Date(startedAtMs).toISOString(),
    startedAtMs,
    finishedAt: null,
    durationSeconds: null,
    error: null,
    output: "后台任务已启动，正在准备执行……\n",
    cancelRequested: false,
    specPath,
    child: null,
  };
  currentTask = task;

  const child = spawn("powershell.exe", [
    "-NoLogo", "-NoProfile", "-ExecutionPolicy", "Bypass",
    "-File", workerScript,
    "-ScriptPath", localizationScript,
    "-SpecPath", specPath,
  ], { cwd: repoRoot, windowsHide: true, stdio: ["ignore", "pipe", "pipe"] });
  task.child = child;
  child.stdout.on("data", (chunk) => appendTaskOutput(task, chunk));
  child.stderr.on("data", (chunk) => appendTaskOutput(task, chunk));
  child.on("error", (error) => finishTask(task, "failed", `无法启动后台任务：${error.message}`));
  child.on("close", (code) => {
    if (task.cancelRequested) finishTask(task, "cancelled", "任务已由用户取消。");
    else if (code === 0) finishTask(task, "completed");
    else finishTask(task, "failed", `后台任务异常结束，退出代码：${code ?? "未知"}`);
  });
  return getPublicTask();
}

function runProcess(file, args) {
  return new Promise((resolve) => {
    const child = spawn(file, args, { windowsHide: true, stdio: "ignore" });
    child.on("error", () => resolve(false));
    child.on("close", (code) => resolve(code === 0));
  });
}

async function cancelCurrentTask() {
  if (!currentTask || currentTask.status !== "running") throw new HttpError(409, "当前没有正在运行的任务。");
  const task = currentTask;
  task.cancelRequested = true;
  if (process.platform === "win32") await runProcess("taskkill.exe", ["/pid", String(task.child.pid), "/t", "/f"]);
  else task.child.kill("SIGTERM");
  finishTask(task, "cancelled", "任务已由用户取消。");
  return getPublicTask();
}

function getSafeReport(modId) {
  assertSafeModId(modId);
  const reportPath = path.join(implTodoDir, modId, "upstream_changed.md");
  try {
    return fs.readFileSync(reportPath, "utf8");
  } catch (error) {
    if (error.code === "ENOENT") throw new HttpError(404, "没有找到这个 Mod 的更新报告。");
    throw error;
  }
}

let shuttingDown = false;

async function handleRequest(request, response) {
  const requestUrl = new URL(request.url, baseUrl);
  const pathname = requestUrl.pathname;

  if (request.method === "GET" && pathname === "/api/state") {
    sendJson(response, 200, getAppState());
    return;
  }
  if (request.method === "GET" && pathname === "/api/report") {
    sendJson(response, 200, { ok: true, content: getSafeReport(requestUrl.searchParams.get("id") ?? "") });
    return;
  }
  if (request.method === "GET" && pathname === "/api/task") {
    sendJson(response, 200, { ok: true, task: getPublicTask() });
    return;
  }
  if (request.method === "POST" && pathname === "/api/action") {
    requireToken(request);
    const task = startTask(getActionSpec(await readJsonBody(request)));
    sendJson(response, 202, { ok: true, task });
    return;
  }
  if (request.method === "POST" && pathname === "/api/task/cancel") {
    requireToken(request);
    sendJson(response, 200, { ok: true, task: await cancelCurrentTask() });
    return;
  }
  if (request.method === "POST" && pathname === "/api/shutdown") {
    requireToken(request);
    if (currentTask?.status === "running") throw new HttpError(409, "请先取消或等待当前任务完成，再关闭服务。");
    sendJson(response, 200, { ok: true, message: "服务正在关闭。" });
    setTimeout(() => shutdown(false), 25);
    return;
  }
  if (request.method === "GET" && staticFiles.has(pathname)) {
    sendStatic(request, response, staticFiles.get(pathname));
    return;
  }
  throw new HttpError(404, "页面不存在。");
}

const server = http.createServer((request, response) => {
  handleRequest(request, response).catch((error) => {
    if (response.headersSent) {
      response.destroy();
      return;
    }
    sendJson(response, error.statusCode ?? 500, { ok: false, error: error.message || "服务器内部错误。" });
  });
});

async function shutdown(cancelTask) {
  if (shuttingDown) return;
  shuttingDown = true;
  if (cancelTask && currentTask?.status === "running") {
    try { await cancelCurrentTask(); } catch { }
  }
  server.close(() => {
    fs.rmSync(runtimeDir, { recursive: true, force: true });
    process.exit(0);
  });
  setTimeout(() => process.exit(0), 3000).unref();
}

function openBrowser() {
  if (process.platform === "win32") {
    const child = spawn("explorer.exe", [baseUrl], { detached: true, windowsHide: true, stdio: "ignore" });
    child.unref();
  }
}

server.on("error", (error) => {
  console.error(`Failed to start ${baseUrl}: ${error.message}`);
  process.exit(1);
});

process.on("SIGINT", () => {
  console.log("\nStopping local web service...");
  shutdown(true);
});
process.on("SIGTERM", () => shutdown(true));

server.listen(options.port, host, () => {
  console.log("");
  console.log("TEOcean upstream localization manager started");
  console.log(`URL: ${baseUrl}`);
  console.log("Stop: use the web page button, press Ctrl+C, or close this window");
  console.log("");
  if (!options.noBrowser) openBrowser();
});
