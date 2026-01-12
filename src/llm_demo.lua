-- DeepSeek API Demo for TEOcean Localization
-- 这个文件用于演示如何调用 DeepSeek API 进行文本翻译

-- !!! 请在此处填入您的 DeepSeek API Key !!!
TEO_DEEPSEEK_API_KEY = "YOUR_API_KEY_HERE"


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
    print("[TEOcean Demo] 错误：无法加载 https 模块 (SMODS.https 或 require 'SMODS.https' / 'https' 均失败)")
end

local sys_prompt = [[对**接下来我给你的文本内容**进行翻译成中文，要求如下：
1. 遵循原版翻译的lua格式
2. 翻译中的游戏术语尽量还原
3. 遇到数字时，统一用阿拉伯数字
4. 遵循官方中文翻译风格
5. 如果可以，可以将部分中文替换成中国传统文化词汇，或者信达雅
6. 遇到“倍乘”“倍增”时，不需要翻译出来，只需要写数字表示（例如X3、+10)
8. 如果需要逗号，请改成另起一行文本，也就是不要出现逗号，句号同理
9. 可供参考的替换词汇表（每个词汇以|或换行分隔）：
Arcana -> 秘术 | Minor Arcana Packs -> 秘术包 | Jimbo Arcana Packs -> 巨型秘术包 | Clips -> 别针
手持的 -> 留在手中的 | 小丑 -> 小丑牌 | 提供 -> 给予 | 几率 -> 概率 | 有{C:green}#1#/#2#{}概率 -> 有{C:green}#1#/#2#{}几率 | 首次 -> 第一次 | 首张 -> 第一张
自毁 -> {S:1.1,C:red,E:2}自毁{} | 若 -> 如果 | 出售 -> 售出 | 赋予 -> 添加 | E.G.O. Gift -> E.G.O. 饰品
消耗槽位 -> 消耗牌槽位 | 吃完 ->  {S:1.1,C:red,E:2}自毁 | 增强包 -> 补充包 | 牌背 -> 牌套
标贴 -> 贴纸  | Ascension power -> 升阶强度 | Ascended hands -> 已升阶牌型 | Mythos Pack -> 神话包 | Mythos -> 神话
loteria_pack -> 乐透包 | zodiac -> 星座 | unique hand -> 不重复的牌型
最后一手牌 -> 最后一次出牌 | silly -> 滑稽]]

--- 测试 DeepSeek 翻译功能
--- @param text_to_translate string 需要翻译的英文文本
function TEO_test_deepseek_translation(text_to_translate)
    if not TEO_DEEPSEEK_API_KEY or TEO_DEEPSEEK_API_KEY == "YOUR_API_KEY_HERE" then
        print("[TEOcean Demo] 错误：未配置 API Key。请在 src/llm_demo.lua 中设置 TEO_DEEPSEEK_API_KEY。")
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
        print("[TEOcean Demo] 错误：https 模块未加载，无法发送请求。")
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
                else
                    print("[TEOcean Demo] 响应解析失败: " .. tostring(body))
                end
            else
                print("[TEOcean Demo] 请求失败，状态码: " .. tostring(code))
                print("错误信息: " .. tostring(body))
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
