-- AI Manager: 负责处理 AI的 API 请求、缓存和直接Override

local TEO = SMODS.current_mod
local AI_CACHE = {} -- 内存缓存：{ [text_hash] = "Translated Text" }

local function TEO_get_ai_request_config()
    local cfg = (TEO and TEO.config) or {}
    return {
        api_url = cfg.api_url or "",
        api_model = cfg.api_model or "",
        api_key = cfg.api_key or "",
        api_format = cfg.api_format or "auto",
        temperature = cfg.ai_temperature
    }
end
local AI_CARD_CACHE = {}         -- 卡牌级缓存：{ [mod_id] = { [set_key] = { [card_key] = content } } }
local PENDING_REQUESTS = {}      -- 正在请求中的文本哈希集合
local PENDING_CARD_REQUESTS = {} -- 卡牌级请求跟踪：{ [mod_id.set_key.card_key] = true }

local LOC_REFRESH_PENDING = false
local LOC_REFRESH_DELAY = 5

--- 请求延迟刷新本地化（批量处理）
local function TEO_request_localization_refresh()
    if LOC_REFRESH_PENDING then return end
    LOC_REFRESH_PENDING = true

    if G and G.E_MANAGER then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = LOC_REFRESH_DELAY,
            blockable = false,
            func = function()
                if init_localization then
                    TEO_dbg_print("[TEOcean AI] 执行批量本地化刷新...")
                    pcall(init_localization)
                end
                LOC_REFRESH_PENDING = false
                return true
            end
        }))
    else
        -- 降级方案
        TEO_dbg_print("[TEOcean AI] 执行批量本地化刷新（立即刷新无延迟）...")
        if init_localization then pcall(init_localization) end
        LOC_REFRESH_PENDING = false
    end
end

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
### 输出格式 (必须)
你必须仅返回一个合法的 JSON 对象，不要包含任何额外的 Markdown 代码块标签、前序或后续说明。格式如下：
{
  "name": "翻译后的卡牌名称",
  "text": ["描述行1", "描述行2", ...]
}
1. 遵循原版翻译的lua格式
2. 翻译中的游戏术语尽量还原
3. 遇到数字时，统一用阿拉伯数字
4. 遵循官方中文翻译风格
5. 如果可以，可以将部分中文替换成中国传统文化词汇，或者信达雅
6. 遇到“倍乘”“倍增”时，不需要翻译出来，只需要写数字表示（例如X3、+10)
8. 如果需要逗号，请改成另起一行文本，也就是不要出现逗号，句号同理
10. 如果英语中遇到条件语句的倒装（相对于中文而言），需要以中文的语序改变语句顺序
11. 可供参考的替换词汇表（每个词汇以|或换行分隔）：
Arcana -> 秘术 | Minor Arcana Packs -> 秘术包 | Jumbo Arcana Pack -> 巨型秘术包 | Mega Arcana Pack -> 超级秘术包 | Arcana Pack -> 秘术包
held in hand -> 留在手牌中 | Joker -> 小丑 (此条当且仅当小丑名称字段‘name’含有时) | Joker -> 小丑牌 | give -> 给予 | chance -> 几率 | has a {C:green}#1# in #2# chance -> 有{C:green}#1#/#2#{}几率
first hand -> 第一次出牌 | first played card -> 第一张计分牌 | self destructs -> 自毁 | if -> 如果 | sell -> 售出 | add -> 添加
E.G.O. Gift -> E.G.O. 饰品 | consumable slot -> 消耗牌槽位 | eat -> 吃完了 | Booster Pack -> 补充包 | card back -> 牌套
Ascension power -> 晋升强度 | Ascended hands -> 已晋升牌型 | Mythos Pack -> 神话包 | Mythos -> 神话
loteria_pack -> 乐透包 | zodiac -> 星座 | unique hand -> 不重复的牌型 | final hand of round -> 最后一次出牌 | silly -> 滑稽
Deck -> 牌组 | Blind -> 盲注 | Joker -> 小丑牌 | Ante -> 底注 | Chips -> 筹码 | Mult -> 倍率 | Face Cards -> 人头牌 | Playing Cards -> 游戏牌
Consumable -> 消耗牌 | Spectral -> 幻灵 | Tarot -> 塔罗牌 | Planet -> 星球牌 | Voucher -> 优惠券 | Booster Pack -> 补充包
Edition -> 版本 | Foil -> 闪箔 | Holographic -> 镭射 | Polychrome -> 多彩 | Negative -> 负片 | Eternal -> 永恒卡 | Perishable -> 易腐
Rental -> 租用 | Seal -> 蜡封 | Sticker -> 标贴 | Boss Blind -> Boss盲注 | Small Blind -> 小盲注 | Big Blind -> 大盲注
Hand -> 出牌 | Discard -> 弃牌 | Hand Size -> 手牌上限 | Poker Hand -> 牌型 | Flush -> 同花 | Straight -> 顺子
Full House -> 葫芦 | Royal Flush -> 皇家同花顺 | Five of a Kind -> 五条 | Flush Five -> 同花五条 | Flush House -> 同花葫芦
Four of a Kind -> 四条 | Three of a Kind -> 三条 | Two Pair -> 两对 | Pair -> 对子 | High Card -> 高牌
Straight Flush -> 同花顺 | interest -> 利息 | reroll -> 重掷 | shop -> 商店 | round -> 回合 | run -> 赛局/局
debuffed -> 被削弱 | destroy -> 摧毁 | create -> 生成 | copy -> 复制 | random -> 随机 | selected -> 选定
upgrade -> 升级 | level -> 等级 | score -> 计分/得分 | trigger -> 触发 | retrigger -> 重新触发 | ability -> 能力
enhance -> 增强 | enhancement -> 增强效果 | suit -> 花色 | rank -> 点数 | common -> 普通 | uncommon -> 罕见
rare -> 稀有 | legendary -> 传奇 | tag -> 标签 | stake -> 赌注 | challenge -> 挑战 | collection -> 收藏
profile -> 配置 | seed -> 种子 | victory -> 胜利 | defeat -> 失败 | skip -> 跳过 | cash -> 资金/现金
reward -> 奖励 | voucher -> 优惠券 | celestial pack -> 天体包 | standard pack -> 标准包 | spectral pack -> 幻灵包
buffoon pack -> 小丑包 | playing card -> 游戏牌 | stone card -> 石头牌 | glass card -> 玻璃牌 | gold card -> 黄金牌
steel card -> 钢铁牌 | lucky card -> 幸运牌 | wild card -> 万能牌 | bonus card -> 奖励牌 | mult card -> 倍率牌
enhanced card -> 增强卡牌 | debuffed card -> 被削弱的牌 | face down -> 背面朝上 | face up -> 正面朝上
select -> 选择 | choose -> 选择 | use -> 使用 | play -> 打出/出牌 | discard -> 弃掉 | hold -> 持有/留在
gain -> 获得 | lose -> 失去 | earn -> 赚取 | permanent -> 永久 | consecutive -> 连续 | remaining -> 剩余
total -> 总计 | per -> 每 | each -> 每个 | every -> 每一 | when -> 当...时 | if -> 如果 | at end of -> 在...结束时
at start of -> 在...开始时 | in shop -> 在商店中 | in hand -> 在手牌中 | in deck -> 在牌组中 | in run -> 在本赛局中
most played -> 最常用的 | final -> 最后的 | additional -> 额外的 | base -> 基础 | extra -> 额外 | free -> 免费
cost -> 花费 | price -> 价格 | sell value -> 售价 | money -> 资金 | dollar -> 美元 | cash -> 现金
chips -> 筹码 | mult -> 倍率 | X mult -> X倍率 | plus -> 加 | minus -> 减 | times -> 乘以 | chance -> 几率
probability -> 概率 | luck -> 幸运 | hex -> 妖法 | soul -> 灵魂 | aura -> 光环 | ankh -> 生命十字章
cryptid -> 神秘生物 | deja vu -> 既视感 | ectoplasm -> 灵质 | familiar -> 使魔 | grim -> 严峻 | immolate -> 火祭
incantation -> 咒语 | medium -> 灵媒 | ouija -> 占卜 | sigil -> 符印 | talisman -> 护身符 | trance -> 入迷
wraith -> 幽灵 | black hole -> 黑洞 | ceres -> 谷神星 | earth -> 地球 | eris -> 阋神星 | jupiter -> 木星
mars -> 火星 | mercury -> 水星 | neptune -> 海王星 | planet x -> X行星 | pluto -> 冥王星 | saturn -> 土星
uranus -> 天王星 | venus -> 金星 | dwarf planet -> 矮行星 | the chariot -> 战车 | death -> 死神 | the devil -> 恶魔
the emperor -> 皇帝 | the empress -> 皇后 | the fool -> 愚者 | the hanged man -> 倒吊人 | the hierophant -> 教皇
the hermit -> 隐者 | the high priestess -> 女祭司 | judgement -> 审判 | justice -> 正义 | the lovers -> 恋人
the magician -> 魔术师 | the moon -> 月亮 | the star -> 星星 | strength -> 力量 | the sun -> 太阳 | temperance -> 节制
the tower -> 塔 | the wheel of fortune -> 命运之轮 | the world -> 世界
特殊规则：
Sticker -> 标贴（仅在key包含stack关键字时应用此规则）否则统一应用：Sticker -> 贴纸
当且仅当"有 1/2 几率" "have #1#/#2# chance" 意思相近的字样出现时译作'几率'否则一律翻译为概率
]]
TEO_ai_sys_prompt = sys_prompt

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
--- 结构: impl/ai/<mod_id>/<lang>.lua
--- 文件格式: return { descriptions = { [set_key] = { [card_key] = { name = ..., text = {...} } } } }
local function load_ai_card_cache(mod_id)
    if not TEO or not TEO.path or not mod_id then return end
    if AI_CARD_CACHE[mod_id] then return end -- 已加载

    AI_CARD_CACHE[mod_id] = {}
    local lang = TEO_get_cur_language and TEO_get_cur_language() or 'zh_CN'
    local cache_file = TEO.path .. 'impl/ai/' .. mod_id .. '/' .. lang .. '.lua'

    -- 如果新格式文件不存在，尝试从旧格式迁移
    if not NFS.getInfo(cache_file) then
        local old_cache_base = TEO.path .. 'impl/ai/' .. mod_id .. '/'
        if NFS.getInfo(old_cache_base) then
            -- 尝试迁移旧的JSON格式
            local migrated_data = { descriptions = {} }
            local sets = NFS.getDirectoryItems(old_cache_base) or {}

            for _, set_name in ipairs(sets) do
                local set_dir = old_cache_base .. set_name .. '/'
                if NFS.getInfo(set_dir) and NFS.getInfo(set_dir).type == 'directory' then
                    migrated_data.descriptions[set_name] = {}
                    local cards = NFS.getDirectoryItems(set_dir) or {}

                    for _, file_name in ipairs(cards) do
                        if file_name:match('%.json$') then
                            local card_key = file_name:gsub('%.json$', '')
                            local file_path = set_dir .. file_name
                            local content = NFS.read(file_path)
                            if content then
                                local success, data = pcall(json.decode, content)
                                if success and data then
                                    migrated_data.descriptions[set_name][card_key] = data
                                end
                            end
                        end
                    end
                end
            end

            -- 如果成功迁移了数据，保存为新格式
            if next(migrated_data.descriptions) then
                -- 创建目录
                local cache_dir = TEO.path .. 'impl/ai/' .. mod_id .. '/'
                if not NFS.getInfo(cache_dir) then
                    pcall(NFS.createDirectory, cache_dir)
                end

                -- 保存为lua格式
                local lua_content = 'return ' ..
                    (TEO_table_to_lua and TEO_table_to_lua(migrated_data, '') or json.encode(migrated_data)) .. '\n'
                local ok = pcall(NFS.write, cache_file, lua_content)

                if ok and TEO_dbg_print then
                    TEO_dbg_print("[TEO AI Cache] 已迁移旧缓存:", mod_id, "to", cache_file)
                end
            end
        end

        -- 重新检查文件是否存在
        if not NFS.getInfo(cache_file) then return end
    end

    -- 读取lua格式的缓存文件
    local data = TEO_read_loc_file and TEO_read_loc_file(cache_file)
    if data and type(data) == 'table' and data.descriptions then
        for set_key, set_data in pairs(data.descriptions) do
            if type(set_data) == 'table' then
                AI_CARD_CACHE[mod_id][set_key] = AI_CARD_CACHE[mod_id][set_key] or {}
                for card_key, card_data in pairs(set_data) do
                    AI_CARD_CACHE[mod_id][set_key][card_key] = card_data
                end
            end
        end
    end

    if TEO_dbg_print then TEO_dbg_print("[TEO AI Cache] 已加载缓存，modid=" .. mod_id .. " from " .. cache_file) end
end

local function save_ai_card_cache(mod_id, set_key, card_key, content)
    if not TEO or not TEO.path or not mod_id or not set_key or not card_key then return end

    local lang = TEO_get_cur_language and TEO_get_cur_language() or 'zh_CN'
    local cache_dir = TEO.path .. 'impl/ai/' .. mod_id .. '/'
    local cache_file = cache_dir .. lang .. '.lua'

    -- 创建目录结构
    if not NFS.getInfo(TEO.path .. 'impl/ai/') then
        pcall(NFS.createDirectory, TEO.path .. 'impl/ai/')
    end
    if not NFS.getInfo(cache_dir) then
        pcall(NFS.createDirectory, cache_dir)
    end

    -- 更新内存缓存
    AI_CARD_CACHE[mod_id] = AI_CARD_CACHE[mod_id] or {}
    AI_CARD_CACHE[mod_id][set_key] = AI_CARD_CACHE[mod_id][set_key] or {}
    AI_CARD_CACHE[mod_id][set_key][card_key] = content

    -- 构建完整的缓存数据结构
    local cache_data = { descriptions = {} }
    for s_key, s_data in pairs(AI_CARD_CACHE[mod_id]) do
        cache_data.descriptions[s_key] = cache_data.descriptions[s_key] or {}
        for c_key, c_data in pairs(s_data) do
            cache_data.descriptions[s_key][c_key] = c_data
        end
    end

    -- 序列化并保存为lua格式
    local lua_content = 'return ' ..
        (TEO_table_to_lua and TEO_table_to_lua(cache_data, '') or json.encode(cache_data)) .. '\n'
    local ok, err = pcall(NFS.write, cache_file, lua_content)

    if ok then
        if TEO_dbg_print then
            TEO_dbg_print("[TEOcean AI Cache] 已保存缓存:", mod_id, set_key, card_key, "to", cache_file)
        end
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

--- 解析 AI 返回内容
-- 优先尝试 JSON 解析，失败则回退到行解析
local function parse_ai_response(content)
    if not content or content == "" then return nil end

    -- 1. 尝试 JSON 解析
    -- 移除可能存在的 Markdown 代码块标签和首尾空白
    local clean_json = content:gsub("^%s*```json", ""):gsub("^%s*```", ""):gsub("```%s*$", ""):gsub("^%s*(.-)%s*$", "%1")
    local success, data = pcall(json.decode, clean_json)

    if success and type(data) == 'table' then
        -- 规范化输出格式
        local res = {
            name = data.name and tostring(data.name) or nil,
            text = {}
        }

        if type(data.text) == 'table' then
            for i = 1, #data.text do
                table.insert(res.text, tostring(data.text[i]))
            end
        elseif type(data.text) == 'string' then
            table.insert(res.text, data.text)
        end

        -- 如果既没名字也没描述，说明解析虽然成功但数据没用
        if res.name or #res.text > 0 then
            return res
        end
    end

    -- 2. 回退到旧的行解析逻辑 (为了兼容性和容错)
    local lines = {}
    for line in content:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end

    if #lines == 0 then return nil end
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

    -- 某些类型的 set 名称与实际存储位置不同，需要映射
    -- Booster 的本地化存储在 Other 中，而不是 Booster
    local localization_set_map = {
        ['Booster'] = 'Other',
    }
    local actual_set_key = localization_set_map[set_key] or set_key

    local target_set = G.localization.descriptions[actual_set_key]
    if not target_set then
        -- 如果 Set 不存在，创建它
        G.localization.descriptions[actual_set_key] = {}
        target_set = G.localization.descriptions[actual_set_key]
        if TEO_dbg_print then TEO_dbg_print("[TEOcean AI Check] 创建新 Set:", actual_set_key) end
    end

    local target_card_loc = target_set[card_key]

    if not target_card_loc then
        if TEO_dbg_print then TEO_dbg_print("[TEOcean AI Check] 目标 Card Key 不存在，创建新条目:", card_key) end
        -- 创建新的本地化条目（用于没有本地化文件的 mod）
        target_card_loc = {}
        target_set[card_key] = target_card_loc
    end

    -- 备份（使用实际的 set key）
    TEO_localization_backup = TEO_localization_backup or {}
    TEO_localization_backup[mod_id] = TEO_localization_backup[mod_id] or { descriptions = {} }

    if not TEO_localization_backup[mod_id].descriptions[actual_set_key] then
        TEO_localization_backup[mod_id].descriptions[actual_set_key] = {}
    end

    if not TEO_localization_backup[mod_id].descriptions[actual_set_key][card_key] then
        TEO_localization_backup[mod_id].descriptions[actual_set_key][card_key] = deep_copy(target_card_loc)
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
        -- 纯字符串：更新描述，保留原名
        new_loc_data.text = { translated_content }
        if new_loc_data.name then
            new_loc_data.name = ensure_string(new_loc_data.name)
        end
    elseif type(translated_content) == 'table' then
        if translated_content.name or translated_content.text then
            -- 结构化对象 (JSON 解析结果)
            if translated_content.name and translated_content.name ~= "" then
                new_loc_data.name = ensure_string(translated_content.name)
            end
            if translated_content.text and type(translated_content.text) == 'table' and #translated_content.text > 0 then
                new_loc_data.text = ensure_text_table(translated_content.text)
            end
        else
            -- 纯文本行数组 (旧逻辑迁移)
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

    -- 内存修改（使用实际的 set key）
    G.localization.descriptions[actual_set_key][card_key] = new_loc_data

    -- 打印日志到后台 (Console)
    TEO_dbg_print(("[TEOcean AI] Applied Translation for key: %s \nName: %s"):format(tostring(card_key),
        tostring(new_loc_data.name)))

    -- 刷新（批量延迟）
    TEO_request_localization_refresh()
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

    local request_cfg = TEO_get_ai_request_config()
    if not (TEO_has_required_ai_config and TEO_has_required_ai_config(request_cfg)) then
        print("[TEOcean AI] AI 配置不完整：请填写 API URL、Model、API Key")
        return
    end

    local request_spec, build_err = TEO_build_ai_request(
        request_cfg,
        "You are a professional game localization expert. " .. sys_prompt,
        source_text
    )
    if not request_spec then
        print("[TEOcean AI] 构建请求失败:", tostring(build_err))
        return
    end

    PENDING_CARD_REQUESTS[card_id] = true
    if TEO_dbg_print then
        TEO_dbg_print("[TEOcean AI Manager] 发起 API 请求:", card_id, request_spec.provider, request_spec.url)
    end

    https.asyncRequest(
        request_spec.url,
        { method = "POST", headers = request_spec.headers, data = json.encode(request_spec.body) },
        function(code, body, resp_headers)
            PENDING_CARD_REQUESTS[card_id] = nil

            local ok, content, parse_err, parsed_data = TEO_parse_ai_response(request_spec.provider, code, body)
            if ok then
                local parsed_content = parse_ai_response(content) or content
                if TEO_dbg_print then
                    TEO_dbg_print("[TEO AI Manager] 翻译成功:", card_id, request_spec.provider, parsed_content)
                end

                -- 持久化到卡牌级缓存
                save_ai_card_cache(mod_id, set_key, card_key, parsed_content)
                TEO_apply_ai_override(mod_id, set_key, card_key, parsed_content)
            else
                print("[TEOcean AI] 请求或解析失败:", tostring(parse_err), "Code:", tostring(code), "Card:", card_id)
                if TEO_dbg_print and parsed_data then
                    TEO_dbg_print("[TEOcean AI] 原始错误响应:", parsed_data)
                end
            end
        end
    )
end

function TEO_get_cached_ai_translation(source_text)
    return AI_CACHE[get_text_hash(source_text)]
end

--- 获取所有有AI缓存的mod列表
function TEO_get_ai_cached_mods()
    if not TEO or not TEO.path then return {} end

    local cached_mods = {}
    local ai_dir = TEO.path .. 'impl/ai/'

    -- 检查AI缓存目录是否存在
    if not NFS.getInfo(ai_dir) then
        return cached_mods
    end

    -- 遍历impl/ai/下的所有子目录
    local mod_dirs = NFS.getDirectoryItems(ai_dir) or {}
    for _, mod_id in ipairs(mod_dirs) do
        local mod_path = ai_dir .. mod_id
        if NFS.getInfo(mod_path) and NFS.getInfo(mod_path).type == 'directory' then
            -- 检查是否有缓存文件
            local lang = TEO_get_cur_language and TEO_get_cur_language() or 'zh_CN'
            local cache_file = mod_path .. '/' .. lang .. '.lua'

            if NFS.getInfo(cache_file) then
                -- 读取缓存文件以获取更多信息
                local data = TEO_read_loc_file and TEO_read_loc_file(cache_file)
                local card_count = 0
                if data and data.descriptions then
                    for set_key, set_data in pairs(data.descriptions) do
                        if type(set_data) == 'table' then
                            for _ in pairs(set_data) do
                                card_count = card_count + 1
                            end
                        end
                    end
                end

                -- 获取mod的名称
                local mod_name = mod_id
                for _, modInfo in ipairs(SMODS.mod_list or {}) do
                    if modInfo.id == mod_id then
                        mod_name = modInfo.name or mod_id
                        break
                    end
                end

                table.insert(cached_mods, {
                    id = mod_id,
                    name = mod_name,
                    card_count = card_count,
                    cache_file = cache_file
                })
            end
        end
    end

    -- 按mod名称排序
    table.sort(cached_mods, function(a, b)
        return a.name < b.name
    end)

    return cached_mods
end

--- 清除单个mod的AI缓存
function TEO_clear_ai_cache_for_mod(mod_id)
    if not TEO or not TEO.path or not mod_id then return false end

    local mod_cache_dir = TEO.path .. 'impl/ai/' .. mod_id .. '/'
    local lang = TEO_get_cur_language and TEO_get_cur_language() or 'zh_CN'
    local cache_file = mod_cache_dir .. lang .. '.lua'

    -- 删除内存缓存
    AI_CARD_CACHE[mod_id] = nil

    -- 删除磁盘缓存文件
    if NFS.getInfo(cache_file) then
        local ok, err = pcall(NFS.remove, cache_file)
        if ok then
            print('[TEOcean AI Cache] 已清除Mod缓存:', mod_id)
            return true
        else
            print('[TEOcean AI Cache] 删除Mod缓存失败:', mod_id, err)
            return false
        end
    end

    return false
end

--- 清除所有AI缓存
function TEO_clear_all_ai_cache()
    if not TEO or not TEO.path then return false end

    local ai_dir = TEO.path .. 'impl/ai/'
    local cleared_count = 0

    -- 检查AI缓存目录是否存在
    if not NFS.getInfo(ai_dir) then
        print('[TEOcean AI Cache] AI缓存目录不存在')
        return false
    end

    -- 遍历所有mod的缓存目录
    local mod_dirs = NFS.getDirectoryItems(ai_dir) or {}
    for _, mod_id in ipairs(mod_dirs) do
        local mod_path = ai_dir .. mod_id
        if NFS.getInfo(mod_path) and NFS.getInfo(mod_path).type == 'directory' then
            -- 清除内存缓存
            AI_CARD_CACHE[mod_id] = nil

            -- 删除缓存文件
            local lang = TEO_get_cur_language and TEO_get_cur_language() or 'zh_CN'
            local cache_file = mod_path .. '/' .. lang .. '.lua'

            if NFS.getInfo(cache_file) then
                local ok, err = pcall(NFS.remove, cache_file)
                if ok then
                    cleared_count = cleared_count + 1
                else
                    print('[TEOcean AI Cache] 删除失败:', cache_file, err)
                end
            end
        end
    end

    print('[TEOcean AI Cache] 已清除', cleared_count, '个Mod的AI缓存')
    return cleared_count > 0
end
