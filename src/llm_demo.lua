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
    local cfg = (mod and mod.config) or {}
    return {
        api_url = cfg.api_url or "",
        api_model = cfg.api_model or "",
        api_key = cfg.api_key or "",
        api_format = cfg.api_format or "auto",
    }
end

--- 通用测试翻译（单句）
--- @param text_to_translate string
--- @param callback function callback(success, result, error_message)
function TEO_test_translation(text_to_translate, callback)
    if not https then
        local err = "[TEOcean Demo] 错误：https 模块未加载，无法发送请求。"
        print(err)
        if callback then callback(false, nil, err) end
        return
    end

    local cfg = get_test_config()
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

    TEO_dbg_print("[TEOcean Demo] 发起测试请求", request_spec.provider, request_spec.url)

    https.asyncRequest(
        request_spec.url,
        {
            method = "POST",
            headers = request_spec.headers,
            data = json.encode(request_spec.body)
        },
        function(code, body, response_headers)
            local ok, result_text, parse_err, raw = TEO_parse_ai_response(request_spec.provider, code, body)
            if ok then
                if callback then callback(true, result_text, nil) end
            else
                local err = "[TEOcean Demo] 请求失败: " .. tostring(parse_err)
                print(err)
                if TEO_dbg_print and raw then
                    TEO_dbg_print("[TEOcean Demo] 原始错误响应", raw)
                end
                if callback then callback(false, nil, err) end
            end
        end
    )
end

-- 兼容旧函数名
function TEO_test_deepseek_translation(text_to_translate, callback)
    return TEO_test_translation(text_to_translate, callback)
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

