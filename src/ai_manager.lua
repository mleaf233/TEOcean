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
local AI_CARD_CACHE = {}         -- 卡牌级缓存：{ [mod_id] = { [set_key] = { [card_key] = { __teo_shape, __teo_content } } } }
local PENDING_REQUESTS = {}      -- 正在请求中的文本哈希集合
local PENDING_CARD_REQUESTS = {} -- 卡牌级请求跟踪：{ [mod_id.set_key.card_key] = true }
local LAST_HOVERED_TRANSLATION_TARGET = nil

local LOC_REFRESH_PENDING = false
local LOC_REFRESH_DELAY = 0.1
local refresh_hovered_card_popup = nil
TEO_suspend_ai_resolve = TEO_suspend_ai_resolve or false
local REFRESHING_HOVERED_POPUP = false

local function get_ai_card_id(mod_id, set_key, card_key)
    if not mod_id or not set_key or not card_key then return nil end
    return tostring(mod_id) .. "." .. tostring(set_key) .. "." .. tostring(card_key)
end

--- 请求延迟刷新本地化（批量处理）
local function TEO_request_localization_refresh()
    if LOC_REFRESH_PENDING then return end
    LOC_REFRESH_PENDING = true

    local function run_refresh()
        if refresh_hovered_card_popup then
            TEO_dbg_print("[TEOcean AI] 刷新当前悬停卡牌弹窗...")
            pcall(refresh_hovered_card_popup)
        end
        LOC_REFRESH_PENDING = false
        return true
    end

    if G and G.E_MANAGER then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = LOC_REFRESH_DELAY,
            blockable = false,
            func = run_refresh
        }))
    else
        run_refresh()
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
你必须仅返回一个合法的 JSON 对象，不要包含任何额外的 Markdown 代码块标签、前序或后续说明。输出类似这样的结构：
{
  "name": "翻译后的卡牌名称",
  "text": ["描述行1", "描述行2", ...]
}
以下是严格遵循的要求：
1. 翻译后的语句如果不通顺，需要以中文的语序改变语句顺序（即json输出中数组的顺序）
2. 翻译中的游戏术语尽量还原
3. 遇到数字时，统一用阿拉伯数字
4. 保持原有层级、字段数量不变
5. 只翻译字符串值；数字、布尔值、空表、控制标签和键名都不要改
6. 遇到“倍乘”“倍增”时，不需要翻译出来，只需要写数字表示（例如X3、+10)
8. 如果需要逗号，请改成另起一行文本，也就是不要出现逗号，句号同理
10. 如果输入里存在 name/text 结构，保持它；如果存在更深层嵌套，也必须原样保留
11. 不要把多层表拍平，不要合并不同 box
12. 保留 {C:...}、#1#、^^ 等占位符
13. 有 #1#/#2# 几率 的字样时，翻译为“有 #1#/#2# 几率”，不要翻译为“有 #1#/#2# 概率”，并且统一用 / 符号分割分子和分母，分母和分子之间不允许有中文
14. 可供参考的替换词汇表，遇到词汇匹配可直接根据选择替换（每个词汇以|或换行分隔）：
Arcana -> 秘术 | Minor Arcana Packs -> 秘术包 | Jumbo Arcana Pack -> 巨型秘术包 | Mega Arcana Pack -> 超级秘术包 | Arcana Pack -> 秘术包
held in hand -> 留在手牌中 | Joker -> 小丑 | give -> 给予 | chance -> 几率 | has a {C:green}#1# in #2# chance -> 有{C:green}#1#/#2#{}几率
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

local tree_sys_prompt = sys_prompt

local function sanitize_translation_tree(node, expected)
    if expected ~= nil then
        if type(expected) == 'table' then
            if type(node) ~= 'table' then return nil end

            local res = {}
            if TEO_is_sequence_table and TEO_is_sequence_table(expected) then
                if not (TEO_is_sequence_table(node) and #node == #expected) then return nil end
                for i = 1, #expected do
                    local child = sanitize_translation_tree(node[i], expected[i])
                    if child == nil then
                        child = TEO_deep_copy and TEO_deep_copy(expected[i]) or expected[i]
                    end
                    res[i] = child
                end
            else
                for k, expected_child in pairs(expected) do
                    local child = sanitize_translation_tree(node[k], expected_child)
                    if child == nil then
                        child = TEO_deep_copy and TEO_deep_copy(expected_child) or expected_child
                    end
                    res[k] = child
                end
            end
            return res
        end

        if type(expected) == 'string' then
            if type(node) == 'string' then return node end
            if type(node) == 'number' or type(node) == 'boolean' then return tostring(node) end
            return expected
        end

        if type(expected) == 'number' or type(expected) == 'boolean' then
            if type(node) == type(expected) then return node end
            return expected
        end

        return expected
    end

    if type(node) == 'string' then return node end
    if type(node) == 'number' or type(node) == 'boolean' then return node end
    if type(node) ~= 'table' then return nil end

    local res = {}
    if TEO_is_sequence_table and TEO_is_sequence_table(node) then
        for i = 1, #node do
            res[i] = sanitize_translation_tree(node[i])
        end
    else
        for k, v in pairs(node) do
            res[k] = sanitize_translation_tree(v)
        end
    end
    return res
end

local function strip_runtime_loc_metadata(node)
    if type(node) ~= 'table' then
        return node
    end

    local res = {}
    for k, v in pairs(node) do
        if k ~= 'name_parsed' and k ~= 'text_parsed' and k ~= 'unlock_parsed' then
            res[k] = strip_runtime_loc_metadata(v)
        end
    end
    return res
end

local function build_ai_system_prompt(preserve_structure)
    if preserve_structure then
        return "You are a professional game localization expert. " .. tree_sys_prompt
    end
    return "You are a professional game localization expert. " .. sys_prompt
end

local function format_ai_debug_value(value)
    local text
    if type(value) == 'string' then
        text = value
    elseif type(value) == 'table' then
        local ok, encoded = pcall(json.encode, value)
        text = ok and encoded or tostring(value)
    else
        text = tostring(value)
    end

    local max_len = 20000
    if #text > max_len then
        return text:sub(1, max_len) .. "\n...[truncated " .. tostring(#text - max_len) .. " chars]"
    end
    return text
end

local function debug_ai_api_success(card_id, provider, code, body, parsed_data, content, parsed_content, preserve_structure)
    if not TEO_dbg_print then return end

    -- TEO_dbg_print("[TEOcean AI Debug] API success:", card_id, provider, "code=", tostring(code),
    --     "shape=", preserve_structure and "tree" or "flat")
    -- TEO_dbg_print("[TEOcean AI Debug] Raw API body:", format_ai_debug_value(body))
    -- TEO_dbg_print("[TEOcean AI Debug] Provider parsed data:", format_ai_debug_value(parsed_data))
    -- TEO_dbg_print("[TEOcean AI Debug] Extracted content:", format_ai_debug_value(content))
    -- TEO_dbg_print("[TEOcean AI Debug] Parsed translation:",
    --     format_ai_debug_value(strip_runtime_loc_metadata(parsed_content)))
end

local function encode_ai_source_payload(source_payload, preserve_structure)
    if preserve_structure then
        local clean_payload = strip_runtime_loc_metadata(source_payload)
        local ok, encoded = pcall(json.encode, clean_payload)
        if ok and type(encoded) == 'string' and encoded ~= "" then
            return encoded
        end
        return nil, encoded
    end

    if type(source_payload) == 'string' then
        return source_payload
    end

    if type(source_payload) == 'table' then
        local parts = {}
        if source_payload.name ~= nil then
            TEO_collect_text_parts(source_payload.name, parts)
        end
        if source_payload.text ~= nil then
            TEO_collect_text_parts(source_payload.text, parts)
        end
        if source_payload.unlock ~= nil then
            TEO_collect_text_parts(source_payload.unlock, parts)
        end
        local source_text = table.concat(parts, "\n")
        if source_text ~= "" then
            return source_text
        end
    end

    local text = tostring(source_payload or "")
    if text ~= "" then
        return text
    end
    return nil, "empty payload"
end

local function pack_ai_cache_entry(content, preserve_structure)
    if type(content) == 'table' then
        content = strip_runtime_loc_metadata(content)
    end
    return {
        __teo_shape = preserve_structure and 'tree' or 'flat',
        __teo_content = content
    }
end

local function normalize_ai_cache_entry(card_data)
    if type(card_data) == 'table' and card_data.__teo_content ~= nil then
        local preserve_structure = card_data.__teo_shape == 'tree'
        return {
            __teo_shape = preserve_structure and 'tree' or 'flat',
            __teo_content = type(card_data.__teo_content) == 'table'
                and strip_runtime_loc_metadata(card_data.__teo_content)
                or card_data.__teo_content
        }
    end

    local preserve_structure = type(card_data) == 'table' and TEO_loc_translation_uses_tree and
        TEO_loc_translation_uses_tree(card_data) or false
    return pack_ai_cache_entry(card_data, preserve_structure)
end

local function resolve_actual_set_key(set_key)
    if TEO_resolve_actual_loc_set_key then
        return TEO_resolve_actual_loc_set_key(set_key)
    end
    local localization_set_map = {
        ['Booster'] = 'Other',
    }
    return localization_set_map[set_key] or set_key
end

TEO_ai_runtime_override_sources = TEO_ai_runtime_override_sources or {}

local function mark_runtime_override_source(mod_id, set_key, card_key, source)
    if not mod_id or not set_key or not card_key then return end
    TEO_ai_runtime_override_sources[mod_id] = TEO_ai_runtime_override_sources[mod_id] or {}
    TEO_ai_runtime_override_sources[mod_id][set_key] = TEO_ai_runtime_override_sources[mod_id][set_key] or {}
    TEO_ai_runtime_override_sources[mod_id][set_key][card_key] = source or 'ai'
end

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
--- 文件格式: return { descriptions = { [set_key] = { [card_key] = { __teo_shape = 'tree'|'flat', __teo_content = ... } } } }
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
                                    migrated_data.descriptions[set_name][card_key] = normalize_ai_cache_entry(data)
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
                    AI_CARD_CACHE[mod_id][set_key][card_key] = normalize_ai_cache_entry(card_data)
                end
            end
        end
    end

    if TEO_dbg_print then TEO_dbg_print("[TEO AI Cache] 已加载缓存，modid=" .. mod_id .. " from " .. cache_file) end
end

local function persist_ai_card_cache(mod_id, log_set_key, log_card_key)
    if not TEO or not TEO.path or not mod_id then return false end
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

    -- 构建完整的缓存数据结构
    local cache_data = { descriptions = {} }
    for s_key, s_data in pairs(AI_CARD_CACHE[mod_id] or {}) do
        if type(s_data) == 'table' and next(s_data) then
            cache_data.descriptions[s_key] = cache_data.descriptions[s_key] or {}
            for c_key, c_data in pairs(s_data) do
                if type(c_data) == 'table' and c_data.__teo_content ~= nil then
                    cache_data.descriptions[s_key][c_key] =
                        pack_ai_cache_entry(c_data.__teo_content, c_data.__teo_shape == 'tree')
                end
            end
        end
    end

    -- 序列化并保存为lua格式
    local lua_content = 'return ' ..
        (TEO_table_to_lua and TEO_table_to_lua(cache_data, '') or json.encode(cache_data)) .. '\n'
    local ok, err = pcall(NFS.write, cache_file, lua_content)

    if ok then
        if TEO_dbg_print then
            TEO_dbg_print("[TEOcean AI Cache] 已保存缓存:", mod_id, log_set_key or "", log_card_key or "", "to", cache_file)
        end
        return true
    else
        print("[TEOcean AI Cache] 保存缓存失败:", err)
        return false
    end
end

local function save_ai_card_cache(mod_id, set_key, card_key, content, preserve_structure)
    if not TEO or not TEO.path or not mod_id or not set_key or not card_key then return end

    -- 更新内存缓存
    AI_CARD_CACHE[mod_id] = AI_CARD_CACHE[mod_id] or {}
    AI_CARD_CACHE[mod_id][set_key] = AI_CARD_CACHE[mod_id][set_key] or {}
    AI_CARD_CACHE[mod_id][set_key][card_key] = pack_ai_cache_entry(content, preserve_structure == true)

    return persist_ai_card_cache(mod_id, set_key, card_key)
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
        local entry = AI_CARD_CACHE[mod_id][set_key][card_key]
        if type(entry) == 'table' and entry.__teo_content ~= nil then
            return entry.__teo_content, entry.__teo_shape == 'tree'
        end
    end

    return nil
end

function TEO_set_last_hovered_translation_target(mod_id, set_key, card_key, display_name)
    if not mod_id or mod_id == 'base' or not set_key or not card_key then return end

    LAST_HOVERED_TRANSLATION_TARGET = {
        mod_id = mod_id,
        set_key = set_key,
        card_key = card_key,
        display_name = display_name or card_key,
        timestamp = G and G.TIMERS and G.TIMERS.REAL or nil
    }
end

function TEO_get_last_hovered_translation_target()
    if not LAST_HOVERED_TRANSLATION_TARGET then return nil end

    return {
        mod_id = LAST_HOVERED_TRANSLATION_TARGET.mod_id,
        set_key = LAST_HOVERED_TRANSLATION_TARGET.set_key,
        card_key = LAST_HOVERED_TRANSLATION_TARGET.card_key,
        display_name = LAST_HOVERED_TRANSLATION_TARGET.display_name,
        timestamp = LAST_HOVERED_TRANSLATION_TARGET.timestamp
    }
end

function TEO_clear_ai_card_translation(mod_id, set_key, card_key)
    if not TEO or not TEO.path or not mod_id or not set_key or not card_key then return false end

    if not AI_CARD_CACHE[mod_id] then
        load_ai_card_cache(mod_id)
    end

    if not AI_CARD_CACHE[mod_id] or not AI_CARD_CACHE[mod_id][set_key] or
        AI_CARD_CACHE[mod_id][set_key][card_key] == nil then
        return false
    end

    AI_CARD_CACHE[mod_id][set_key][card_key] = nil
    if not next(AI_CARD_CACHE[mod_id][set_key]) then
        AI_CARD_CACHE[mod_id][set_key] = nil
    end

    persist_ai_card_cache(mod_id, set_key, card_key)
    return true
end

function TEO_retranslate_last_hovered_card()
    local target = TEO_get_last_hovered_translation_target and TEO_get_last_hovered_translation_target() or nil
    if not target then
        print('[TEOcean AI] 没有可重译的悬停卡牌')
        return false
    end

    local TEO_mod = TEO_get_mod and TEO_get_mod() or TEO
    if not (TEO_mod and TEO_mod.config and TEO_mod.config.enable_ai_translation) then
        print('[TEOcean AI] AI 翻译未启用，无法重译')
        return false
    end

    local card_id = get_ai_card_id(target.mod_id, target.set_key, target.card_key)
    if card_id and PENDING_CARD_REQUESTS[card_id] then
        print('[TEOcean AI] 该卡牌已有翻译请求进行中:', card_id)
        return false
    end

    if not TEO_get_original_localization or not TEO_request_ai_translation then
        print('[TEOcean AI] 重译接口未就绪')
        return false
    end

    local original_data = TEO_get_original_localization(target.mod_id, target.set_key, target.card_key, true, "source")
    if not original_data then
        print('[TEOcean AI] 未找到原始本地化，无法重译:', card_id or target.card_key)
        return false
    end

    local preserve_structure = type(original_data) == 'table' and TEO_loc_translation_uses_tree and
        TEO_loc_translation_uses_tree(original_data) or false

    local queued = TEO_request_ai_translation(
        original_data,
        target.mod_id,
        target.set_key,
        target.card_key,
        preserve_structure,
        original_data,
        true
    )

    if queued then
        print('[TEOcean AI] 已重新请求翻译:', card_id or target.card_key)
    end
    return queued == true
end

--- 解析 AI 返回内容
-- 优先尝试 JSON 解析，失败则回退到行解析
local function parse_ai_response(content, preserve_structure, expected_shape)
    if not content or content == "" then return nil end

    -- 1. 尝试 JSON 解析
    -- 移除可能存在的 Markdown 代码块标签和首尾空白
    local clean_json = content:gsub("^%s*```json", ""):gsub("^%s*```", ""):gsub("```%s*$", ""):gsub("^%s*(.-)%s*$", "%1")
    local success, data = pcall(json.decode, clean_json)

    if success and type(data) == 'table' then
        if preserve_structure then
            return sanitize_translation_tree(data, strip_runtime_loc_metadata(expected_shape or data))
        else
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
    end

    if preserve_structure then
        return nil
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

local function deep_equal(lhs, rhs)
    if lhs == rhs then
        return true
    end
    if type(lhs) ~= type(rhs) then
        return false
    end
    if type(lhs) ~= 'table' then
        return false
    end

    local seen = {}
    for k, v in pairs(lhs) do
        if not deep_equal(v, rhs[k]) then
            return false
        end
        seen[k] = true
    end

    for k in pairs(rhs) do
        if not seen[k] then
            return false
        end
    end

    return true
end

local function runtime_loc_has_parsed_fields(loc_data)
    if type(loc_data) ~= 'table' then
        return false
    end
    if loc_data.name ~= nil and type(loc_data.name_parsed) ~= 'table' then
        return false
    end
    if loc_data.text ~= nil and type(loc_data.text_parsed) ~= 'table' then
        return false
    end
    if loc_data.unlock ~= nil and type(loc_data.unlock_parsed) ~= 'table' then
        return false
    end
    return true
end

local function should_skip_ai_override(current_loc, next_loc)
    if type(current_loc) ~= 'table' or not runtime_loc_has_parsed_fields(current_loc) then
        return false
    end
    return deep_equal(strip_runtime_loc_metadata(current_loc), strip_runtime_loc_metadata(next_loc))
end

local function rebuild_loc_parsed_lines(lines)
    if type(lines) ~= 'table' then
        return {}
    end

    local parsed = {}
    for i = 1, #lines do
        local line = lines[i]
        if type(line) == 'table' then
            parsed[#parsed + 1] = rebuild_loc_parsed_lines(line)
        else
            parsed[#parsed + 1] = loc_parse_string(tostring(line or ""))
        end
    end
    return parsed
end

local function rebuild_loc_parsed_field(value)
    if value == nil then
        return nil
    end
    if type(value) == 'table' then
        return rebuild_loc_parsed_lines(value)
    end
    return { loc_parse_string(tostring(value or "")) }
end

local function sync_runtime_loc_parsed_fields(loc_data)
    if type(loc_data) ~= 'table' then
        return loc_data
    end

    loc_data.name_parsed = rebuild_loc_parsed_field(loc_data.name) or {}
    loc_data.text_parsed = rebuild_loc_parsed_field(loc_data.text) or {}
    if loc_data.unlock ~= nil then
        loc_data.unlock_parsed = rebuild_loc_parsed_field(loc_data.unlock) or {}
    else
        loc_data.unlock_parsed = nil
    end
    return loc_data
end

refresh_hovered_card_popup = function()
    if REFRESHING_HOVERED_POPUP then
        return false
    end

    local target = G and G.CONTROLLER and G.CONTROLLER.hovering and G.CONTROLLER.hovering.target or nil
    if not target or target.REMOVED or type(target.is) ~= 'function' or not target:is(Card) then
        return false
    end
    if not target.config or not target.config.center or not target.generate_UIBox_ability_table then
        return false
    end

    REFRESHING_HOVERED_POPUP = true
    TEO_suspend_ai_resolve = true
    local ok, result = pcall(function()
        target.ability_UIBox_table = target:generate_UIBox_ability_table()
        target.config.h_popup = G.UIDEF.card_h_popup(target)
        target.config.h_popup_config = target:align_h_popup()

        if target.children and target.children.h_popup then
            target.children.h_popup:remove()
            target.children.h_popup = nil
        end
        Node.hover(target)
        return true
    end)
    TEO_suspend_ai_resolve = false
    REFRESHING_HOVERED_POPUP = false
    return ok and result or false
end

--- 将翻译结果应用到游戏内存 (Runtime Override)
function TEO_apply_ai_override(mod_id, set_key, card_key, translated_content, preserve_structure, expected_shape, source)
    if not mod_id or not set_key or not card_key or not translated_content then return end
    source = source or 'ai'

    if TEO_dbg_print then
        TEO_dbg_print("[TEOcean AI Check] 尝试应用 Override - Mod:", mod_id, "Set:", set_key, "Key:",
            card_key, "Source:", source)
    end

    if not G.localization or not G.localization.descriptions then return end

    local actual_set_key = resolve_actual_set_key(set_key)

    if source ~= 'manual' and TEO_get_protected_manual_localization then
        local manual_loc, manual_is_tree, manual_source = TEO_get_protected_manual_localization(
            mod_id,
            set_key,
            card_key,
            { source_data = expected_shape }
        )
        if manual_loc then
            if TEO_dbg_print then
                TEO_dbg_print("[TEOcean AI] 检测到人工翻译，跳过 AI Override:", manual_source, mod_id, set_key,
                    card_key)
            end
            return false, 'manual_exists', manual_loc, manual_is_tree
        end
    end

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

    if preserve_structure == nil then
        preserve_structure = type(translated_content) == 'table' and TEO_loc_translation_uses_tree and
            TEO_loc_translation_uses_tree(translated_content)
    else
        preserve_structure = preserve_structure == true
    end

    if preserve_structure then
        local has_target_shape = type(target_card_loc) == 'table' and next(target_card_loc) ~= nil
        local clean_target_card_loc = strip_runtime_loc_metadata(target_card_loc)
        local clean_shape_source = strip_runtime_loc_metadata(expected_shape or (has_target_shape and clean_target_card_loc or translated_content))
        local clean_translated_content = strip_runtime_loc_metadata(translated_content)
        local tree_loc = sanitize_translation_tree(clean_translated_content, clean_shape_source)
        if not tree_loc then
            if TEO_dbg_print then
                TEO_dbg_print("[TEOcean AI] 结构化翻译结构不匹配，跳过:", mod_id, set_key, card_key)
            end
            return false
        end

        sync_runtime_loc_parsed_fields(tree_loc)
        if should_skip_ai_override(target_card_loc, tree_loc) then
            mark_runtime_override_source(mod_id, actual_set_key, card_key, source)
            if TEO_dbg_print then
                TEO_dbg_print("[TEOcean AI] Override 未变化，跳过刷新:", mod_id, actual_set_key, card_key)
            end
            return false
        end
        G.localization.descriptions[actual_set_key][card_key] = tree_loc
        mark_runtime_override_source(mod_id, actual_set_key, card_key, source)

        TEO_dbg_print(("[TEOcean AI] Applied Tree Translation for key: %s"):format(tostring(card_key)))
        TEO_request_localization_refresh()
        return true
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
    sync_runtime_loc_parsed_fields(new_loc_data)
    if should_skip_ai_override(target_card_loc, new_loc_data) then
        mark_runtime_override_source(mod_id, actual_set_key, card_key, source)
        if TEO_dbg_print then
            TEO_dbg_print("[TEOcean AI] Override 未变化，跳过刷新:", mod_id, actual_set_key, card_key)
        end
        return false
    end
    G.localization.descriptions[actual_set_key][card_key] = new_loc_data
    mark_runtime_override_source(mod_id, actual_set_key, card_key, source)

    -- 打印日志到后台 (Console)
    TEO_dbg_print(("[TEOcean AI] Applied Translation for key: %s \nName: %s"):format(tostring(card_key),
        tostring(new_loc_data.name)))

    -- 刷新（批量延迟）
    TEO_request_localization_refresh()
    return true
end

--- 请求 AI 翻译（卡牌级别）
function TEO_request_ai_translation(source_payload, mod_id, set_key, card_key, preserve_structure, expected_shape,
                                    force_refresh)
    if source_payload == nil then return false end
    if not https then return false end
    if not mod_id or not set_key or not card_key then return false end
    force_refresh = force_refresh == true

    if preserve_structure == nil and type(source_payload) == 'table' and TEO_loc_translation_uses_tree then
        preserve_structure = TEO_loc_translation_uses_tree(source_payload)
    else
        preserve_structure = preserve_structure == true
    end

    if TEO_get_protected_manual_localization then
        local manual_loc, manual_is_tree, manual_source = TEO_get_protected_manual_localization(
            mod_id,
            set_key,
            card_key,
            { source_data = source_payload }
        )
        if manual_loc then
            if TEO_dbg_print then
                TEO_dbg_print("[TEOcean AI Manager] 检测到人工翻译，跳过 AI 请求:", manual_source, mod_id, set_key,
                    card_key)
            end
            TEO_apply_ai_override(mod_id, set_key, card_key, manual_loc, manual_is_tree, source_payload, 'manual')
            return false
        end
    end

    local request_payload, payload_err = encode_ai_source_payload(source_payload, preserve_structure)
    if not request_payload or request_payload == "" then
        if TEO_dbg_print then
            TEO_dbg_print("[TEOcean AI] 生成请求负载失败:", tostring(payload_err), mod_id, set_key, card_key)
        end
        return false
    end

    -- 生成卡片唯一标识
    local card_id = get_ai_card_id(mod_id, set_key, card_key)

    -- 0. 预加载该 mod 的缓存
    if not AI_CARD_CACHE[mod_id] then
        load_ai_card_cache(mod_id)
    end

    -- 1. 检查卡牌级缓存
    if not force_refresh then
        local cached, cached_is_tree = TEO_get_ai_card_translation(mod_id, set_key, card_key)
        if cached and (preserve_structure == cached_is_tree) then
            if TEO_dbg_print then TEO_dbg_print("[TEOcean AI Manager] 命中卡片缓存:", card_id) end
            TEO_apply_ai_override(mod_id, set_key, card_key, cached, cached_is_tree, source_payload, 'cache')
            return true
        end
    end

    -- 2. 检查队列（避免重复请求）
    if PENDING_CARD_REQUESTS[card_id] then
        if TEO_dbg_print then TEO_dbg_print("[TEOcean AI Manager] 请求已在队列中:", card_id) end
        return false
    end

    local request_cfg = TEO_get_ai_request_config()
    if not (TEO_has_required_ai_config and TEO_has_required_ai_config(request_cfg)) then
        print("[TEOcean AI] AI 配置不完整：请填写 API URL、Model、API Key")
        return false
    end

    local request_spec, build_err = TEO_build_ai_request(
        request_cfg,
        build_ai_system_prompt(preserve_structure),
        request_payload
    )
    if not request_spec then
        print("[TEOcean AI] 构建请求失败:", tostring(build_err))
        return false
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
                local parsed_content = parse_ai_response(content, preserve_structure,
                    expected_shape or (preserve_structure and (type(source_payload) == 'table' and source_payload or nil) or nil))
                if not parsed_content and not preserve_structure then
                    parsed_content = content
                end
                if TEO_dbg_print then
                    TEO_dbg_print("[TEO AI Manager] 翻译成功:", card_id, request_spec.provider, parsed_content)
                    debug_ai_api_success(card_id, request_spec.provider, code, body, parsed_data, content, parsed_content,
                        preserve_structure)
                end

                if preserve_structure and not parsed_content then
                    print("[TEOcean AI] 结构化翻译解析失败:", card_id)
                    return
                end

                if TEO_get_protected_manual_localization then
                    local manual_loc, manual_is_tree, manual_source = TEO_get_protected_manual_localization(
                        mod_id,
                        set_key,
                        card_key,
                        { source_data = source_payload }
                    )
                    if manual_loc then
                        if TEO_dbg_print then
                            TEO_dbg_print("[TEOcean AI Manager] 回调阶段检测到人工翻译，丢弃 AI 结果:", manual_source,
                                mod_id, set_key, card_key)
                        end
                        TEO_apply_ai_override(mod_id, set_key, card_key, manual_loc, manual_is_tree, source_payload,
                            'manual')
                        return
                    end
                end

                -- 持久化到卡牌级缓存
                save_ai_card_cache(mod_id, set_key, card_key, parsed_content, preserve_structure)
                TEO_apply_ai_override(mod_id, set_key, card_key, parsed_content, preserve_structure, source_payload, 'ai')
            else
                print("[TEOcean AI] 请求或解析失败:", tostring(parse_err), "Code:", tostring(code), "Card:", card_id)
                if TEO_dbg_print and parsed_data then
                    TEO_dbg_print("[TEOcean AI] 原始错误响应:", parsed_data)
                end
            end
        end
    )
    return true
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
