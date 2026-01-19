-- DeepSeek API Demo for TEOcean Localization
-- 这个文件用于演示如何调用 DeepSeek API 进行文本翻译

-- !!! 请在此处填入您的 DeepSeek API Key !!!
TEO_DEEPSEEK_API_KEY = "YOUR_API_KEY_HERE"
if TEO_get_mod then
    local TEO = TEO_get_mod("TEOcean")
    if TEO and TEO.config and TEO.config.api_key then
        TEO_DEEPSEEK_API_KEY = TEO.config.api_key
    end
end

-- JSON 库引用，确保 SMODS 环境下可用
local json = JSON or require("json")

-- 首先尝试获取 https 模块
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
    TEO_dbg_print("[TEOcean Demo] 错误：无法加载 https 模块 (SMODS.https 或 require 'SMODS.https' / 'https' 均失败)")
end

local sys_prompt = TEO_ai_sys_prompt or [[]]

--- 测试 DeepSeek 翻译功能
--- @param text_to_translate string 需要翻译的英文文本
--- @param callback function 可选的回调函数，签名：callback(success, result, error_message)
function TEO_test_deepseek_translation(text_to_translate, callback)
    if not TEO_DEEPSEEK_API_KEY or TEO_DEEPSEEK_API_KEY == "YOUR_API_KEY_HERE" then
        local err = "[TEOcean Demo] 错误：未配置 API Key。请在 src/llm_demo.lua 中设置 TEO_DEEPSEEK_API_KEY。"
        print(err)
        if callback then callback(false, nil, err) end
        return
    end

    local url = "https://api.deepseek.com/chat/completions"

    -- 构造请求体
    local request_body = {
        model = "deepseek-chat",
        messages = {
            {
                role = "system",
                content =
                    "You are a professional game localization expert. Translate the following English text from the game 'Balatro' into Simplified Chinese. Keep game terminology consistent. Only output the translated text, no explanations." ..
                    sys_prompt
            },
            {
                role = "user",
                content = text_to_translate
            }
        },
        stream = false
    }

    -- 序列化 JSON
    local json_body = json.encode(request_body)

    local headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bearer " .. TEO_DEEPSEEK_API_KEY
    }

    print("[TEOcean Demo] 正在请求 DeepSeek 翻译: " .. text_to_translate)

    if not https then
        local err = "[TEOcean Demo] 错误：https 模块未加载，无法发送请求。"
        print(err)
        if callback then callback(false, nil, err) end
        return
    end

    -- 发送异步请求
    https.asyncRequest(
        url,
        {
            method = "POST",
            headers = headers,
            data = json_body
        },
        function(code, body, response_headers)
            if code == 200 then
                -- 解析响应
                local success, response_data = pcall(json.decode, body)
                if success and response_data and response_data.choices and response_data.choices[1] then
                    local translated_text = response_data.choices[1].message.content
                    print("[TEOcean Demo] 翻译成功！")
                    print("原文: " .. text_to_translate)
                    print("译文: " .. translated_text)
                    if callback then callback(true, translated_text, nil) end
                else
                    local err = "[TEOcean Demo] 响应解析失败: " .. tostring(body)
                    print(err)
                    if callback then callback(false, nil, err) end
                end
            else
                local err = "[TEOcean Demo] 请求失败，状态码: " .. tostring(code) .. ", 错误信息: " .. tostring(body)
                print(err)
                if callback then callback(false, nil, err) end
            end
        end
    )
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

print("[TEOcean Demo] DeepSeek 演示脚本加载完成。在控制台使用 TEO_test_deepseek_translation('Hello') 或 TEO_test_connectivity() 进行测试。")
