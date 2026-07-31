"use strict";

const state = {
  token: "",
  items: [],
  selected: new Set(),
  filter: "all",
  query: "",
  busy: false,
  activeTask: null,
  taskPollTimer: null,
  pendingConfirmation: null,
};

const elements = {
  root: document.documentElement,
  progress: document.querySelector("#progress"),
  connection: document.querySelector("#connection"),
  themeToggle: document.querySelector("#theme-toggle"),
  checkButton: document.querySelector("#check-button"),
  statTotal: document.querySelector("#stat-total"),
  statTracked: document.querySelector("#stat-tracked"),
  statUpdate: document.querySelector("#stat-update"),
  statSetup: document.querySelector("#stat-setup"),
  selectionSummary: document.querySelector("#selection-summary"),
  searchInput: document.querySelector("#search-input"),
  selectAll: document.querySelector("#select-all"),
  listFrame: document.querySelector("#list-frame"),
  modList: document.querySelector("#mod-list"),
  emptyState: document.querySelector("#empty-state"),
  filterButtons: [...document.querySelectorAll(".filter-chip")],
  addButton: document.querySelector("#add-button"),
  initButton: document.querySelector("#init-button"),
  acceptButton: document.querySelector("#accept-button"),
  acceptAllButton: document.querySelector("#accept-all-button"),
  refreshButton: document.querySelector("#refresh-button"),
  output: document.querySelector("#output"),
  outputMeta: document.querySelector("#output-meta"),
  clearOutput: document.querySelector("#clear-output"),
  cancelTask: document.querySelector("#cancel-task"),
  shutdownButton: document.querySelector("#shutdown-button"),
  addDialog: document.querySelector("#add-dialog"),
  addForm: document.querySelector("#add-form"),
  addError: document.querySelector("#add-error"),
  defaultPathsHelp: document.querySelector("#default-paths-help"),
  confirmDialog: document.querySelector("#confirm-dialog"),
  confirmForm: document.querySelector("#confirm-form"),
  confirmTitle: document.querySelector("#confirm-title"),
  confirmMessage: document.querySelector("#confirm-message"),
  confirmSubmit: document.querySelector("#confirm-submit"),
  forceOption: document.querySelector("#force-option"),
  confirmForce: document.querySelector("#confirm-force"),
  reportDialog: document.querySelector("#report-dialog"),
  reportTitle: document.querySelector("#report-title"),
  reportContent: document.querySelector("#report-content"),
  toastRegion: document.querySelector("#toast-region"),
};

const statusMeta = {
  tracked: { label: "基线正常", className: "status-tracked" },
  "needs-update": { label: "发现更新", className: "status-needs-update" },
  "no-baseline": { label: "尚无基线", className: "status-no-baseline" },
  unconfigured: { label: "尚未配置", className: "status-unconfigured" },
};

const svgReport = '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M6 3h9l3 3v15H6z"/><path d="M14 3v4h4M9 12h6m-6 4h4"/></svg>';

function setTheme(theme) {
  elements.root.dataset.theme = theme;
  localStorage.setItem("teocean-theme", theme);
}

function initializeTheme() {
  const saved = localStorage.getItem("teocean-theme");
  if (saved === "light" || saved === "dark") {
    setTheme(saved);
    return;
  }
  setTheme(window.matchMedia("(prefers-color-scheme: light)").matches ? "light" : "dark");
}

function setConnection(mode, text) {
  elements.connection.classList.toggle("is-online", mode === "online");
  elements.connection.classList.toggle("is-offline", mode === "offline");
  elements.connection.querySelector("span:last-child").textContent = text;
}

function setBusy(busy) {
  state.busy = busy;
  elements.progress.classList.toggle("is-active", busy);
  elements.progress.setAttribute("aria-hidden", String(!busy));
  document.body.setAttribute("aria-busy", String(busy));
  [elements.checkButton, elements.addButton, elements.initButton, elements.acceptAllButton, elements.refreshButton]
    .forEach((button) => { button.disabled = busy; });
  updateSelectionUi();
}

function setTaskRunning(running) {
  setBusy(running);
  elements.cancelTask.hidden = !running;
  elements.clearOutput.disabled = running;
  elements.shutdownButton.disabled = running;
}

function syncModalScrollLock() {
  const hasOpenModal = Boolean(document.querySelector("dialog[open]"));
  document.documentElement.classList.toggle("modal-open", hasOpenModal);
  document.body.classList.toggle("modal-open", hasOpenModal);
}

function showModal(dialog) {
  dialog.showModal();
  syncModalScrollLock();
}

function showToast(message, isError = false) {
  const toast = document.createElement("div");
  toast.className = `toast${isError ? " is-error" : ""}`;
  toast.textContent = message;
  elements.toastRegion.append(toast);
  window.setTimeout(() => toast.remove(), 4200);
}

function getErrorMessage(error) {
  return error instanceof Error ? error.message : String(error);
}

async function requestJson(url, options = {}) {
  const response = await fetch(url, options);
  let data;
  try {
    data = await response.json();
  } catch {
    throw new Error(`服务返回了无法读取的内容（HTTP ${response.status}）。`);
  }
  if (!response.ok || data.ok === false) {
    throw new Error(data.error || `请求失败（HTTP ${response.status}）。`);
  }
  return data;
}

async function loadState({ quiet = false } = {}) {
  if (!quiet) elements.listFrame.setAttribute("aria-busy", "true");
  try {
    const data = await requestJson("/api/state", { cache: "no-store" });
    state.token = data.token;
    state.items = Array.isArray(data.items) ? data.items : [];
    const validIds = new Set(state.items.map((item) => item.id));
    state.selected = new Set([...state.selected].filter((id) => validIds.has(id)));
    elements.statTotal.textContent = data.stats.total;
    elements.statTracked.textContent = data.stats.tracked;
    elements.statUpdate.textContent = data.stats.needsUpdate;
    elements.statSetup.textContent = data.stats.needsSetup;
    const defaults = Array.isArray(data.defaultPaths) ? data.defaultPaths : [];
    elements.defaultPathsHelp.textContent = defaults.length
      ? `留空时依次检查：${defaults.join("、")}`
      : "留空时使用脚本内置的默认本地化路径。";
    renderList();
    setConnection("online", "本地服务已连接");
  } catch (error) {
    setConnection("offline", "连接失败");
    if (!quiet) {
      elements.modList.replaceChildren();
      elements.emptyState.hidden = false;
      elements.emptyState.querySelector("h3").textContent = "无法连接本地服务";
      elements.emptyState.querySelector("p").textContent = getErrorMessage(error);
      showToast(getErrorMessage(error), true);
    }
    throw error;
  } finally {
    elements.listFrame.setAttribute("aria-busy", "false");
  }
}

function getVisibleItems() {
  const query = state.query.trim().toLocaleLowerCase("zh-CN");
  return state.items.filter((item) => {
    const matchesFilter = state.filter === "all" || item.status === state.filter;
    const haystack = `${item.id} ${item.repo || ""} ${item.ref || ""}`.toLocaleLowerCase("zh-CN");
    return matchesFilter && (!query || haystack.includes(query));
  });
}

function addCellLabel(container, label) {
  const span = document.createElement("span");
  span.className = "cell-label";
  span.textContent = label;
  container.append(span);
}

function renderList() {
  const items = getVisibleItems();
  const fragment = document.createDocumentFragment();

  for (const item of items) {
    const row = document.createElement("article");
    row.className = "mod-row";
    row.setAttribute("role", "listitem");

    const selectCell = document.createElement("div");
    selectCell.className = "select-cell";
    const checkbox = document.createElement("input");
    checkbox.type = "checkbox";
    checkbox.checked = state.selected.has(item.id);
    checkbox.disabled = state.busy;
    checkbox.setAttribute("aria-label", `选择 ${item.id}`);
    checkbox.addEventListener("change", () => {
      if (checkbox.checked) state.selected.add(item.id);
      else state.selected.delete(item.id);
      updateSelectionUi();
    });
    selectCell.append(checkbox);

    const nameCell = document.createElement("div");
    nameCell.className = "mod-name";
    const name = document.createElement("strong");
    name.textContent = item.id;
    name.title = item.id;
    const ref = document.createElement("span");
    ref.textContent = item.ref || "HEAD";
    nameCell.append(name, ref);

    const statusCell = document.createElement("div");
    addCellLabel(statusCell, "状态");
    const meta = statusMeta[item.status] || statusMeta.unconfigured;
    const badge = document.createElement("span");
    badge.className = `status-badge ${meta.className}`;
    badge.textContent = meta.label;
    statusCell.append(badge);
    if (item.hasReport) {
      const reportButton = document.createElement("button");
      reportButton.type = "button";
      reportButton.className = "report-button";
      reportButton.innerHTML = `${svgReport}<span>查看报告</span>`;
      reportButton.addEventListener("click", () => openReport(item.id));
      statusCell.append(reportButton);
    }

    const repoCell = document.createElement("div");
    repoCell.className = "repo-cell";
    addCellLabel(repoCell, "上游仓库");
    if (item.repo) {
      const link = document.createElement("a");
      link.className = "repo-link";
      link.href = item.repo;
      link.target = "_blank";
      link.rel = "noreferrer";
      link.textContent = item.repo.replace(/^https?:\/\//, "").replace(/\.git$/, "");
      link.title = item.repo;
      repoCell.append(link);
    } else {
      const empty = document.createElement("span");
      empty.className = "repo-empty";
      empty.textContent = "尚未填写";
      repoCell.append(empty);
    }

    const commitCell = document.createElement("div");
    commitCell.className = "mono-cell";
    addCellLabel(commitCell, "基线提交");
    const commit = document.createElement("span");
    commit.textContent = item.baselineCommit ? item.baselineCommit.slice(0, 10) : "—";
    commit.title = item.baselineCommit || "没有基线";
    commitCell.append(commit);

    const timeCell = document.createElement("div");
    timeCell.className = "mono-cell";
    addCellLabel(timeCell, "更新时间");
    const time = document.createElement("span");
    time.textContent = formatDate(item.updatedAt);
    timeCell.append(time);

    row.append(selectCell, nameCell, statusCell, repoCell, commitCell, timeCell);
    fragment.append(row);
  }

  elements.modList.replaceChildren(fragment);
  elements.emptyState.hidden = items.length > 0;
  if (items.length > 0) {
    elements.emptyState.querySelector("h3").textContent = "没有符合条件的 Mod";
    elements.emptyState.querySelector("p").textContent = "试试清除搜索词或切换筛选条件。";
  }
  updateSelectionUi();
}

function formatDate(value) {
  if (!value) return "—";
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return value;
  return new Intl.DateTimeFormat("zh-CN", {
    year: "numeric", month: "2-digit", day: "2-digit", hour: "2-digit", minute: "2-digit",
  }).format(date);
}

function updateSelectionUi() {
  const count = state.selected.size;
  const visibleItems = getVisibleItems();
  const visibleSelected = visibleItems.filter((item) => state.selected.has(item.id)).length;
  elements.selectionSummary.textContent = count
    ? `已选择 ${count} 个；批量操作将只处理所选项。`
    : `共 ${state.items.length} 个；未选择时“检查”和“初始化”会处理全部。`;
  elements.checkButton.querySelector("span").textContent = count ? `检查所选（${count}）` : "检查全部";
  elements.acceptButton.disabled = state.busy || count === 0;
  elements.selectAll.disabled = state.busy || visibleItems.length === 0;
  elements.selectAll.checked = visibleItems.length > 0 && visibleSelected === visibleItems.length;
  elements.selectAll.indeterminate = visibleSelected > 0 && visibleSelected < visibleItems.length;
}

function selectedIds() {
  return [...state.selected];
}

async function pollTask(label) {
  try {
    const data = await requestJson("/api/task", { cache: "no-store" });
    const task = data.task;
    if (!task) throw new Error("服务没有返回任务状态。");

    state.activeTask = task;
    elements.output.textContent = task.output || "后台任务正在运行，等待第一条日志……";
    elements.outputMeta.textContent = `${label}正在后台运行 · 开始于 ${formatDate(task.startedAt)}`;
    elements.output.scrollTop = elements.output.scrollHeight;

    if (task.status === "running") {
      state.taskPollTimer = window.setTimeout(() => pollTask(label), 800);
      return;
    }

    state.taskPollTimer = null;
    setTaskRunning(false);
    if (task.status === "completed") {
      elements.outputMeta.textContent = `${label}已完成 · ${task.durationSeconds ?? "—"} 秒 · ${formatDate(task.finishedAt)}`;
      showToast(`${label}已完成`);
      await loadState({ quiet: true });
    } else if (task.status === "cancelled") {
      elements.outputMeta.textContent = `${label}已取消 · ${formatDate(task.finishedAt)}`;
      elements.output.textContent = `${task.output || ""}\n\n任务已取消。`.trim();
      showToast("任务已取消");
    } else {
      const message = task.error || "后台任务执行失败。";
      elements.outputMeta.textContent = `${label}失败 · ${formatDate(task.finishedAt)}`;
      elements.output.textContent = `${task.output || ""}\n\n${message}`.trim();
      showToast(message, true);
    }
  } catch (error) {
    state.taskPollTimer = null;
    setTaskRunning(false);
    const message = getErrorMessage(error);
    elements.outputMeta.textContent = `${label}状态读取失败`;
    elements.output.textContent += `\n\n无法读取任务状态：${message}\n任务可能仍在后台运行，请刷新页面重试。`;
    showToast(message, true);
  }
}

async function runAction(payload, label) {
  setTaskRunning(true);
  elements.outputMeta.textContent = `${label}正在提交到后台…`;
  elements.output.textContent = "正在创建后台任务……";
  elements.output.scrollIntoView({ behavior: window.matchMedia("(prefers-reduced-motion: reduce)").matches ? "auto" : "smooth", block: "nearest" });
  try {
    const result = await requestJson("/api/action", {
      method: "POST",
      headers: { "Content-Type": "application/json", "X-TEOcean-Token": state.token },
      body: JSON.stringify(payload),
    });
    state.activeTask = result.task;
    elements.output.textContent = result.task.output || "后台任务已启动。";
    pollTask(label);
    return true;
  } catch (error) {
    const message = getErrorMessage(error);
    elements.output.textContent = `操作失败\n\n${message}`;
    elements.outputMeta.textContent = `${label}提交失败 · ${formatDate(new Date().toISOString())}`;
    showToast(message, true);
    setTaskRunning(false);
    return false;
  }
}

function askForConfirmation({ title, message, confirmText, danger = true, showForce = false, action }) {
  state.pendingConfirmation = action;
  elements.confirmTitle.textContent = title;
  elements.confirmMessage.textContent = message;
  elements.confirmSubmit.textContent = confirmText;
  elements.confirmSubmit.className = `button ${danger ? "button-danger" : "button-primary"}`;
  elements.forceOption.hidden = !showForce;
  elements.confirmForce.checked = false;
  showModal(elements.confirmDialog);
}

async function openReport(id) {
  elements.reportTitle.textContent = `${id} 更新报告`;
  elements.reportContent.textContent = "正在读取报告…";
  showModal(elements.reportDialog);
  try {
    const data = await requestJson(`/api/report?id=${encodeURIComponent(id)}`, { cache: "no-store" });
    elements.reportContent.textContent = data.content;
  } catch (error) {
    elements.reportContent.textContent = `读取失败：${getErrorMessage(error)}`;
  }
}

elements.themeToggle.addEventListener("click", () => {
  setTheme(elements.root.dataset.theme === "dark" ? "light" : "dark");
});

elements.searchInput.addEventListener("input", () => {
  state.query = elements.searchInput.value;
  renderList();
});

elements.filterButtons.forEach((button) => {
  button.addEventListener("click", () => {
    state.filter = button.dataset.filter;
    elements.filterButtons.forEach((item) => {
      const active = item === button;
      item.classList.toggle("is-active", active);
      item.setAttribute("aria-pressed", String(active));
    });
    renderList();
  });
});

elements.selectAll.addEventListener("change", () => {
  getVisibleItems().forEach((item) => {
    if (elements.selectAll.checked) state.selected.add(item.id);
    else state.selected.delete(item.id);
  });
  renderList();
});

elements.checkButton.addEventListener("click", () => {
  runAction({ command: "check", modIds: selectedIds() }, state.selected.size ? "检查所选" : "检查全部");
});

elements.initButton.addEventListener("click", () => {
  const ids = selectedIds();
  askForConfirmation({
    title: "初始化同步基线？",
    message: ids.length
      ? `将为所选的 ${ids.length} 个 Mod 拉取上游仓库并初始化基线。默认会跳过已有基线。`
      : "将为全部已配置 Mod 拉取上游仓库并初始化基线。默认会跳过已有基线。",
    confirmText: "开始初始化",
    danger: false,
    showForce: true,
    action: () => runAction({ command: "init", modIds: ids, force: elements.confirmForce.checked }, "初始化基线"),
  });
});

elements.acceptButton.addEventListener("click", () => {
  const ids = selectedIds();
  askForConfirmation({
    title: "接受所选上游版本？",
    message: `将把 ${ids.length} 个 Mod 的当前上游提交设为新基线。请确认相关翻译已经跟进。`,
    confirmText: "接受所选基线",
    action: () => runAction({ command: "accept", modIds: ids }, "接受所选基线"),
  });
});

elements.acceptAllButton.addEventListener("click", () => {
  askForConfirmation({
    title: "接受全部上游版本？",
    message: "这会更新所有已配置 Mod 的同步基线。只有在全部翻译都已跟进时才应继续。",
    confirmText: "接受全部基线",
    action: () => runAction({ command: "accept-all" }, "接受全部基线"),
  });
});

elements.refreshButton.addEventListener("click", async () => {
  setBusy(true);
  try {
    await loadState();
    showToast("列表已刷新");
  } catch {
    // loadState already displays the error.
  } finally {
    setBusy(false);
  }
});

elements.clearOutput.addEventListener("click", () => {
  elements.output.textContent = "尚未运行任何操作。";
  elements.outputMeta.textContent = "操作结果会显示在这里";
});

elements.cancelTask.addEventListener("click", () => {
  askForConfirmation({
    title: "取消当前任务？",
    message: "这会终止正在运行的 PowerShell 和 Git 子进程。本次操作可能只完成了一部分。",
    confirmText: "取消任务",
    action: async () => {
      elements.cancelTask.disabled = true;
      try {
        await requestJson("/api/task/cancel", {
          method: "POST",
          headers: { "X-TEOcean-Token": state.token },
        });
        if (state.taskPollTimer) window.clearTimeout(state.taskPollTimer);
        state.taskPollTimer = null;
        await pollTask("当前任务");
      } catch (error) {
        showToast(getErrorMessage(error), true);
      } finally {
        elements.cancelTask.disabled = false;
      }
    },
  });
});

elements.shutdownButton.addEventListener("click", () => {
  askForConfirmation({
    title: "关闭本地服务？",
    message: "服务关闭后网页将无法继续操作。需要再次使用时，重新双击“启动网页.cmd”。",
    confirmText: "关闭服务",
    action: async () => {
      elements.shutdownButton.disabled = true;
      try {
        await requestJson("/api/shutdown", {
          method: "POST",
          headers: { "X-TEOcean-Token": state.token },
        });
        setConnection("offline", "服务已关闭");
        elements.outputMeta.textContent = "本地服务已关闭";
        elements.output.textContent = "服务已安全关闭。需要继续使用时，请重新双击“启动网页.cmd”。";
        showToast("本地服务已关闭");
        setBusy(true);
      } catch (error) {
        elements.shutdownButton.disabled = false;
        showToast(getErrorMessage(error), true);
      }
    },
  });
});

elements.addButton.addEventListener("click", () => {
  elements.addError.hidden = true;
  showModal(elements.addDialog);
  window.setTimeout(() => document.querySelector("#mod-id").focus(), 0);
});

elements.addDialog.querySelector(".dialog-close").addEventListener("click", () => elements.addDialog.close());
elements.addDialog.querySelector(".dialog-cancel").addEventListener("click", () => elements.addDialog.close());
elements.reportDialog.querySelector(".report-close").addEventListener("click", () => elements.reportDialog.close());

elements.addForm.addEventListener("submit", async (event) => {
  event.preventDefault();
  elements.addError.hidden = true;
  if (!elements.addForm.reportValidity()) return;
  const form = new FormData(elements.addForm);
  const paths = String(form.get("paths") || "").split(/\r?\n/).map((path) => path.trim()).filter(Boolean);
  const payload = {
    command: "add",
    modIds: [String(form.get("modId") || "").trim()],
    repo: String(form.get("repo") || "").trim(),
    ref: String(form.get("ref") || "HEAD").trim() || "HEAD",
    paths,
    noInit: form.get("noInit") === "on",
    force: form.get("force") === "on",
  };
  elements.addDialog.close();
  const success = await runAction(payload, "添加 Mod");
  if (success) elements.addForm.reset();
});

elements.confirmForm.addEventListener("submit", (event) => {
  event.preventDefault();
  const submitter = event.submitter;
  elements.confirmDialog.close();
  if (submitter?.value === "confirm" && typeof state.pendingConfirmation === "function") {
    const action = state.pendingConfirmation;
    state.pendingConfirmation = null;
    action();
  } else {
    state.pendingConfirmation = null;
  }
});

[elements.addDialog, elements.confirmDialog, elements.reportDialog].forEach((dialog) => {
  dialog.addEventListener("close", syncModalScrollLock);
  dialog.addEventListener("click", (event) => {
    if (event.target === dialog) dialog.close();
  });
});

initializeTheme();
loadState()
  .then(async () => {
    try {
      const data = await requestJson("/api/task", { cache: "no-store" });
      if (data.task?.status === "running") {
        setTaskRunning(true);
        pollTask("当前任务");
      }
    } catch {
      // The normal state request already reports connectivity errors.
    }
  })
  .catch(() => {});
