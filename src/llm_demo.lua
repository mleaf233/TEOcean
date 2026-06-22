-- Unified AI API Demo for TEOcean Localization
-- 测试页与调试调用统一走 OpenAI / Claude / Gemini 适配层

local json = JSON or require("json")

-- 尝试获取 https 模块
local https = SMODS.https
if not https then
    local status, mod = pcall(require, "SMODS.https")
    if status then
        https = mod
    else
        status, mod = pcall(require, "https")
        if status then
            https = mod
        end
    end
end

if not https then
    TEO_dbg_print("[TEOcean Demo] 错误：无法加载 https 模块")
end

local function get_test_config()
    local mod = TEO_get_mod and TEO_get_mod("TEOcean")
    local saved_cfg = (mod and mod.config) or {}
    local display_cfg = (TEO and TEO._api_key_display_config) or nil
    local source_cfg = type(display_cfg) == "table" and display_cfg or saved_cfg
    return {
        api_url = source_cfg.api_url or saved_cfg.api_url or "",
        api_model = source_cfg.api_model or saved_cfg.api_model or "",
        api_key = (type(display_cfg) == "table" and (display_cfg._original_api_key or display_cfg.api_key))
            or source_cfg.api_key
            or saved_cfg.api_key
            or "",
        api_format = source_cfg.api_format or saved_cfg.api_format or "auto",
    }
end

local function preview_text(value, max_len)
    local text
    if type(value) == "string" then
        text = value
    else
        local ok, encoded = pcall(function()
            return json.encode(value)
        end)
        text = ok and encoded or tostring(value)
    end

    max_len = max_len or 6000
    if #text > max_len then
        return text:sub(1, max_len) .. "\n...[truncated " .. tostring(#text - max_len) .. " chars]"
    end
    return text
end

local function run_translation_test(cfg, text_to_translate, callback, debug_label)
    if not https then
        local err = "[TEOcean Demo] 错误：https 模块未加载，无法发送请求。"
        print(err)
        if callback then callback(false, nil, err) end
        return
    end

    if not (TEO_has_required_ai_config and TEO_has_required_ai_config(cfg)) then
        local err = "[TEOcean Demo] 错误：AI 配置不完整（需要 API URL / Model / API Key）。"
        print(err)
        if callback then callback(false, nil, err) end
        return
    end

    local system_prompt =
        "You are a professional game localization expert. Translate the user's text into Simplified Chinese. " ..
        "Only output translated text without explanation."

    local request_spec, build_err = TEO_build_ai_request(cfg, system_prompt, text_to_translate)
    if not request_spec then
        local err = "[TEOcean Demo] 请求构建失败: " .. tostring(build_err)
        print(err)
        if callback then callback(false, nil, err) end
        return
    end

    TEO_dbg_print("[TEOcean Demo] 发起测试请求", debug_label or "default", request_spec.provider, request_spec.url)
    TEO_dbg_print("[TEOcean Demo] 测试请求负载:", preview_text(request_spec.body))

    https.asyncRequest(
        request_spec.url,
        {
            method = "POST",
            headers = request_spec.headers,
            data = json.encode(request_spec.body)
        },
        function(code, body, response_headers)
            local body_text = type(body) == "string" and body or tostring(body or "")
            TEO_dbg_print("[TEOcean Demo] 响应元信息:",
                "label=", tostring(debug_label or "default"),
                "provider=", request_spec.provider,
                "code=", tostring(code),
                "body_type=", type(body),
                "body_len=", tostring(#body_text))
            TEO_dbg_print("[TEOcean Demo] 响应原文:", preview_text(body_text))

            local ok, result_text, parse_err, raw = TEO_parse_ai_response(request_spec.provider, code, body)
            if ok then
                TEO_dbg_print("[TEOcean Demo] 翻译成功结果:", preview_text(result_text))
                if callback then callback(true, result_text, nil) end
            else
                local err = "[TEOcean Demo] 请求失败: " .. tostring(parse_err)
                print(err)
                if TEO_dbg_print and raw then
                    TEO_dbg_print("[TEOcean Demo] 原始错误响应", preview_text(raw))
                end
                if callback then callback(false, nil, err) end
            end
        end
    )
end

--- 通用测试翻译（单句）
--- @param text_to_translate string
--- @param callback function callback(success, result, error_message)
function TEO_test_translation(text_to_translate, callback)
    local cfg = get_test_config()
    return run_translation_test(cfg, text_to_translate, callback, "default")
end

-- 兼容旧函数名
function TEO_test_deepseek_translation(text_to_translate, callback)
    local cfg = get_test_config()
    cfg.api_url = "https://api.deepseek.com/chat/completions"
    cfg.api_format = "openai"
    return run_translation_test(cfg, text_to_translate, callback, "deepseek-temp")
end

function TEO_test_deepseek_translation_with_key(text_to_translate, api_key, callback)
    local cfg = get_test_config()
    cfg.api_url = "https://api.deepseek.com/chat/completions"
    cfg.api_format = "openai"
    if type(api_key) == "string" and api_key ~= "" then
        cfg.api_key = api_key
    end
    return run_translation_test(cfg, text_to_translate, callback, "deepseek-key")
end

--- 测试基础网络连接
function TEO_test_connectivity()
    if not https then
        print("[TEOcean Demo] 错误：https 模块未加载")
        return
    end

    print("[TEOcean Demo] 正在测试连接 baidu.com ...")
    https.asyncRequest("https://www.baidu.com", function(code, body, headers)
        print("[TEOcean Demo] baidu 连接测试结果: code=" .. tostring(code))
        if code == 200 then
            print("[TEOcean Demo] 网络连接正常")
        else
            print("[TEOcean Demo] 网络连接异常")
            if body then print("Body: " .. tostring(body)) end
        end
    end)
end

print("[TEOcean Demo] Unified AI demo loaded. Use TEO_test_translation('Hello') to verify API settings.")

