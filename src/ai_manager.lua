-- AI Manager: 负责处理 DeepSeek API 请求、缓存和直接Override

local API_KEY = ""
local API_URL = "https://api.deepseek.com/chat/completions"

local TEO = SMODS.current_mod
local AI_CACHE = {}              -- 内存缓存：{ [text_hash] = "Translated Text" }
local AI_CARD_CACHE = {}         -- 卡牌级缓存：{ [mod_id] = { [set_key] = { [card_key] = content } } }
local PENDING_REQUESTS = {}      -- 正在请求中的文本哈希集合
local PENDING_CARD_REQUESTS = {} -- 卡牌级请求跟踪：{ [mod_id.set_key.card_key] = true }

local json = JSON or require("json")

-- 获取 HTTPS 模块
local https = SMODS.https
if not https then
    local status, mod = pcall(require, "SMODS.https")
    if status then
        https = mod
    else
        status, mod = pcall(require, "https")
        if status then https = mod end
    end
end

if not https then
    print("[TEOcean AI] 错误：无法加载 HTTPS 模块，AI 翻译功能不可用！")
end

-- 系统提示词 (保持不变)
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

--- 计算简单哈希
local function get_text_hash(text)
    if not text then return "nil" end
    local hash = 5381
    local len = string.len(text)
    for i = 1, len do
        hash = math.fmod(((hash * 33) + string.byte(text, i)), 4294967296)
    end
    return string.format("%08x", hash)
end

--- 持久化缓存管理（卡牌级别）
local function load_ai_card_cache(mod_id)
    if not TEO or not TEO.path or not mod_id then return end
    if AI_CARD_CACHE[mod_id] then return end -- 已加载

    AI_CARD_CACHE[mod_id] = {}
    local cache_base = TEO.path .. 'impl/ai/' .. mod_id .. '/'

    if not NFS.getInfo(cache_base) then return end

    -- 遍历 set 目录
    local sets = NFS.getDirectoryItems(cache_base) or {}
    for _, set_name in ipairs(sets) do
        local set_dir = cache_base .. set_name .. '/'
        if NFS.getInfo(set_dir) and NFS.getInfo(set_dir).type == 'directory' then
            AI_CARD_CACHE[mod_id][set_name] = {}

            -- 遍历 card 文件
            local cards = NFS.getDirectoryItems(set_dir) or {}
            for _, file_name in ipairs(cards) do
                if file_name:match('%.json$') then
                    local card_key = file_name:gsub('%.json$', '')
                    local file_path = set_dir .. file_name
                    local content = NFS.read(file_path)
                    if content then
                        local success, data = pcall(json.decode, content)
                        if success and data then
                            AI_CARD_CACHE[mod_id][set_name][card_key] = data
                        end
                    end
                end
            end
        end
    end

    if TEO_dbg_print then TEO_dbg_print("[TEO AI Cache] 已加载卡牌级缓存:", mod_id) end
end

local function save_ai_card_cache(mod_id, set_key, card_key, content)
    if not TEO or not TEO.path or not mod_id or not set_key or not card_key then return end

    local cache_dir = TEO.path .. 'impl/ai/' .. mod_id .. '/' .. set_key .. '/'

    -- 创建目录结构
    if not NFS.getInfo(TEO.path .. 'impl/ai/') then
        pcall(NFS.createDirectory, TEO.path .. 'impl/ai/')
    end
    if not NFS.getInfo(TEO.path .. 'impl/ai/' .. mod_id .. '/') then
        pcall(NFS.createDirectory, TEO.path .. 'impl/ai/' .. mod_id .. '/')
    end
    if not NFS.getInfo(cache_dir) then
        pcall(NFS.createDirectory, cache_dir)
    end

    -- 保存到文件
    local file_path = cache_dir .. card_key .. '.json'
    local encoded = json.encode(content)
    local ok, err = pcall(NFS.write, file_path, encoded)

    if ok then
        if TEO_dbg_print then
            TEO_dbg_print("[TEOcean AI Cache] 已保存缓存:", mod_id, set_key, card_key)
        end

        -- 同时更新内存缓存
        AI_CARD_CACHE[mod_id] = AI_CARD_CACHE[mod_id] or {}
        AI_CARD_CACHE[mod_id][set_key] = AI_CARD_CACHE[mod_id][set_key] or {}
        AI_CARD_CACHE[mod_id][set_key][card_key] = content
    else
        print("[TEOcean AI Cache] 保存缓存失败:", err)
    end
end

-- 获取卡片的AI翻译缓存
function TEO_get_ai_card_translation(mod_id, set_key, card_key)
    if not mod_id or not set_key or not card_key then return nil end

    -- 确保缓存已加载
    if not AI_CARD_CACHE[mod_id] then
        load_ai_card_cache(mod_id)
    end

    if AI_CARD_CACHE[mod_id] and
        AI_CARD_CACHE[mod_id][set_key] and
        AI_CARD_CACHE[mod_id][set_key][card_key] then
        return AI_CARD_CACHE[mod_id][set_key][card_key]
    end

    return nil
end

-- 检查是否存在手动翻译 (impl/mods/...)
local function has_manual_translation(mod_id, lang)
    if not TEO or not TEO.path then return false end
    lang = lang or 'zh_CN' -- 默认检查中文
    local impl_path = TEO.path .. 'impl/mods/' .. mod_id .. '/localization/' .. lang .. '.lua'
    return NFS.getInfo(impl_path)
end


--- 解析 AI 返回内容
local function parse_ai_response(content)
    local lines = {}
    for line in content:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
    if #lines == 1 then return lines[1] end
    return lines
end

--- 深拷贝辅助函数
local function deep_copy(obj)
    if type(obj) ~= 'table' then return obj end
    local res = setmetatable({}, getmetatable(obj))
    for k, v in pairs(obj) do res[k] = deep_copy(v) end
    return res
end

--- 将翻译结果应用到游戏内存 (Runtime Override)
function TEO_apply_ai_override(mod_id, set_key, card_key, translated_content)
    if not mod_id or not set_key or not card_key or not translated_content then return end

    if TEO_dbg_print then
        TEO_dbg_print("[TEOcean AI Check] 尝试应用 Override - Mod:", mod_id, "Set:", set_key, "Key:",
            card_key)
    end

    if not G.localization or not G.localization.descriptions then return end

    local target_set = G.localization.descriptions[set_key]
    if not target_set then
        if TEO_dbg_print then TEO_dbg_print("[TEOcean AI Check] 目标 Set 不存在于 localization:", set_key) end
        return
    end

    local target_card_loc = target_set[card_key]

    if not target_card_loc then
        if TEO_dbg_print then TEO_dbg_print("[TEOcean AI Check] 目标 Card Key 不存在:", card_key) end
        return
    end

    -- 备份
    TEO_localization_backup = TEO_localization_backup or {}
    TEO_localization_backup[mod_id] = TEO_localization_backup[mod_id] or { descriptions = {} }

    if not TEO_localization_backup[mod_id].descriptions[set_key] then
        TEO_localization_backup[mod_id].descriptions[set_key] = {}
    end

    if not TEO_localization_backup[mod_id].descriptions[set_key][card_key] then
        TEO_localization_backup[mod_id].descriptions[set_key][card_key] = deep_copy(target_card_loc)
    end

    -- 应用翻译
    local new_loc_data = deep_copy(target_card_loc)

    -- 辅助函数：确保是字符串
    local function ensure_string(val)
        if type(val) == 'string' then return val end
        if type(val) == 'number' then return tostring(val) end
        if type(val) == 'table' then
            -- 如果是 table，尝试 concat（使用ipairs保持顺序）
            local parts = {}
            if #val > 0 then
                -- 数组类型
                for i = 1, #val do
                    table.insert(parts, tostring(val[i]))
                end
            else
                -- map类型，按key排序
                local keys = {}
                for k in pairs(val) do table.insert(keys, k) end
                table.sort(keys)
                for _, k in ipairs(keys) do
                    table.insert(parts, tostring(val[k]))
                end
            end
            return table.concat(parts, " ")
        end
        if val == nil then return "" end
        return tostring(val)
    end

    -- 辅助函数：确保text是正确的table格式
    local function ensure_text_table(val)
        if type(val) == 'string' then
            return { val }
        elseif type(val) == 'table' then
            -- 确保所有元素都是字符串
            local result = {}
            if #val > 0 then
                for i = 1, #val do
                    table.insert(result, ensure_string(val[i]))
                end
            else
                for _, v in pairs(val) do
                    table.insert(result, ensure_string(v))
                end
            end
            return result
        else
            return { tostring(val) }
        end
    end

    if type(translated_content) == 'string' then
        new_loc_data.text = { translated_content }
        -- 确保name是字符串
        if new_loc_data.name then
            new_loc_data.name = ensure_string(new_loc_data.name)
        end
    elseif type(translated_content) == 'table' then
        local lines = translated_content
        -- 尝试分离 Name
        if #lines > 1 then
            -- 第一行作为 Name，必须确保是 String
            new_loc_data.name = ensure_string(lines[1])

            local new_text = {}
            for i = 2, #lines do
                table.insert(new_text, ensure_string(lines[i]))
            end
            new_loc_data.text = new_text
        else
            -- 只有一行，赋给 text
            new_loc_data.text = ensure_text_table(lines)
            -- 保留原有name并确保是字符串
            if new_loc_data.name then
                new_loc_data.name = ensure_string(new_loc_data.name)
            end
        end
    end

    -- 三重保险：最终检查，强制确保 name 是字符串
    if new_loc_data.name then
        if type(new_loc_data.name) ~= 'string' then
            new_loc_data.name = ensure_string(new_loc_data.name)
            print("[TEOcean AI] 警告：name字段不是字符串，已强制转换:", card_key)
        end
    end

    -- 确保text是正确格式的table
    if new_loc_data.text then
        if type(new_loc_data.text) ~= 'table' then
            new_loc_data.text = { ensure_string(new_loc_data.text) }
        else
            -- 确保所有text元素都是字符串
            for i = 1, #new_loc_data.text do
                if type(new_loc_data.text[i]) ~= 'string' then
                    new_loc_data.text[i] = ensure_string(new_loc_data.text[i])
                end
            end
        end
    end

    -- 内存修改
    G.localization.descriptions[set_key][card_key] = new_loc_data

    -- 打印日志到后台 (Console)
    print(("[TEOcean AI] Applied Translation for key: %s \nName: %s"):format(tostring(card_key),
        tostring(new_loc_data.name)))

    -- 刷新
    if init_localization then pcall(init_localization) end
end

--- 请求 AI 翻译（卡牌级别）
function TEO_request_ai_translation(source_text, mod_id, set_key, card_key)
    if not source_text or source_text == "" then return end
    if not https then return end
    if not mod_id or not set_key or not card_key then return end

    -- 生成卡片唯一标识
    local card_id = mod_id .. "." .. set_key .. "." .. card_key

    -- 0. 预加载该 mod 的缓存
    if not AI_CARD_CACHE[mod_id] then
        load_ai_card_cache(mod_id)
    end

    -- 1. 检查卡牌级缓存
    local cached = TEO_get_ai_card_translation(mod_id, set_key, card_key)
    if cached then
        if TEO_dbg_print then TEO_dbg_print("[TEOcean AI Manager] 命中卡片缓存:", card_id) end
        TEO_apply_ai_override(mod_id, set_key, card_key, cached)
        return
    end

    -- 2. 检查队列（避免重复请求）
    if PENDING_CARD_REQUESTS[card_id] then
        if TEO_dbg_print then TEO_dbg_print("[TEOcean AI Manager] 请求已在队列中:", card_id) end
        return
    end

    PENDING_CARD_REQUESTS[card_id] = true
    if TEO_dbg_print then TEO_dbg_print("[TEOcean AI Manager] 发起 API 请求:", card_id) end

    local request_body = {
        model = "deepseek-chat",
        messages = {
            { role = "system", content = "You are a professional game localization expert. " .. sys_prompt },
            { role = "user",   content = source_text }
        },
        stream = false
    }

    local headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bearer " .. API_KEY
    }

    https.asyncRequest(
        API_URL,
        { method = "POST", headers = headers, data = json.encode(request_body) },
        function(code, body, resp_headers)
            PENDING_CARD_REQUESTS[card_id] = nil

            if code == 200 then
                local success, data = pcall(json.decode, body)
                if success and data and data.choices and data.choices[1] then
                    local content = data.choices[1].message.content
                    local parsed_content = parse_ai_response(content)

                    if TEO_dbg_print then TEO_dbg_print("[TEO AI Manager] 翻译成功:", card_id, parsed_content) end

                    -- 持久化到卡牌级缓存
                    save_ai_card_cache(mod_id, set_key, card_key, parsed_content)

                    TEO_apply_ai_override(mod_id, set_key, card_key, parsed_content)
                else
                    print("[TEOcean AI] 解析失败:", body)
                end
            else
                print("[TEOcean AI] 请求失败 Code:", code, "Card:", card_id)
            end
        end
    )
end

function TEO_get_cached_ai_translation(source_text)
    return AI_CACHE[get_text_hash(source_text)]
end
