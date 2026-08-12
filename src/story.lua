-- TEOcean 故事(story)模块
-- 在卡牌悬停弹窗中显示 impl/mods/<modid>/localization/ 本地化文件里
-- 对应条目（如 c_abn_hyperborea）的注释内容（"故事"）。
-- 支持两种注释格式：
--   1) 行尾注释:  name = "极北之地",  -- 译为许珀耳玻瑞亚或极北之地……
--   2) 条目前注释块:
--      c_abn_lemuria = {
--          -- Lemuria（雷姆利亚）是一个科学史上的假想地质概念……
local TEO = SMODS.current_mod
if not TEO then
    TEO = TEO_get_mod()
end

-- 缓存: mod_id:lang:key -> story_lines (table) | false（false 表示无故事）
local story_cache = {}

-- ============ 注释提取 ============

-- 查找一行中字符串字面量之外第一个 '--' 的位置；无则返回 nil
local function find_inline_comment(line)
    local in_str = false
    local i = 1
    local n = #line
    while i <= n do
        local c = line:sub(i, i)
        if in_str then
            if c == '\\' then
                i = i + 2
            elseif c == '"' then
                in_str = false
                i = i + 1
            else
                i = i + 1
            end
        else
            if c == '"' then
                in_str = true
                i = i + 1
            elseif c == '-' and line:sub(i + 1, i + 1) == '-' then
                return i
            else
                i = i + 1
            end
        end
    end
    return nil
end

-- 计算一行中字符串字面量之外的花括号深度变化
-- 遇到注释（--）即停止，注释中的花括号不参与配对
local function brace_delta(line)
    local in_str = false
    local delta = 0
    local i = 1
    local n = #line
    while i <= n do
        local c = line:sub(i, i)
        if in_str then
            if c == '\\' then
                i = i + 2
            elseif c == '"' then
                in_str = false
                i = i + 1
            else
                i = i + 1
            end
        else
            if c == '"' then
                in_str = true
                i = i + 1
            elseif c == '-' and line:sub(i + 1, i + 1) == '-' then
                break
            elseif c == '{' then
                delta = delta + 1
                i = i + 1
            elseif c == '}' then
                delta = delta - 1
                i = i + 1
            else
                i = i + 1
            end
        end
    end
    return delta
end

-- 文件解析缓存：path -> { lines = {...}, entries = { [entry_name] = 起始行号 } }
local file_parse_cache = {}

-- 解析文件原文：拆分行，并预扫描所有形如 `key = {` 的条目起始行
local function parse_file(content)
    local lines = {}
    for line in (content .. '\n'):gmatch('(.-)\n') do
        lines[#lines + 1] = line
    end
    local entries = {}
    for i, line in ipairs(lines) do
        local name = line:match('^%s*([%w_]+)%s*=%s*{%s*$')
        if name then
            entries[name] = i
        end
    end
    return { lines = lines, entries = entries }
end

local function get_parsed(path)
    if file_parse_cache[path] then
        return file_parse_cache[path]
    end
    local ok_read, content = TEO_fs_call(NFS.read, path)
    if not ok_read or type(content) ~= 'string' then return nil end
    local parsed = parse_file(content)
    file_parse_cache[path] = parsed
    return parsed
end

-- 从解析结果中提取某条目的故事注释（块前注释 + 行尾注释）
local function extract_story(parsed, entry_name)
    local lines = parsed.lines
    -- 1) 定位条目起始行（形如:  c_abn_hyperborea = {）
    local start_idx = parsed.entries[entry_name]
    -- 宽松模式：{ 之后可能还有内容（如行尾注释）
    if not start_idx then
        for i, line in ipairs(lines) do
            if line:match('^%s*' .. entry_name .. '%s*=%s*{') then
                start_idx = i
                break
            end
        end
    end
    if not start_idx then
        return nil
    end

    -- 2) 块前注释：条目起始行之前紧邻的连续注释行
    local before = {}
    local k = start_idx - 1
    while k >= 1 do
        local comment = lines[k]:match('^%s*%-%-%s*(.-)%s*$')
        if not comment then break end
        table.insert(before, 1, comment)
        k = k - 1
    end

    -- 3) 条目结束行：从起始行开始做花括号配对（跳过字符串内的 {}）
    local depth = 0
    local end_idx = start_idx
    for j = start_idx, #lines do
        depth = depth + brace_delta(lines[j])
        if depth <= 0 then
            end_idx = j
            break
        end
    end

    -- 4) 行尾注释：条目范围内各行中字符串之外的行内注释
    local inline = {}
    for j = start_idx, end_idx do
        local pos = find_inline_comment(lines[j])
        if pos then
            local comment = lines[j]:sub(pos + 2):gsub('^%s*', ''):gsub('%s*$', '')
            if comment ~= '' then
                inline[#inline + 1] = comment
            end
        end
    end

    local result = {}
    for _, c in ipairs(before) do
        if c ~= '' then result[#result + 1] = c end
    end
    for _, c in ipairs(inline) do
        result[#result + 1] = c
    end
    return #result > 0 and result or nil
end

-- ============ 条目定位 ============

local function strip_card_prefix(key)
    return (key:gsub('^[jc]_', ''))
end

-- 本地化条目名与卡牌 key 的模糊匹配（处理 j_/c_ 前缀等命名差异）
local function entry_matches(entry_key, loc_key)
    if entry_key == loc_key then return true end
    local e, l = strip_card_prefix(entry_key), strip_card_prefix(loc_key)
    if e == l then return true end
    local e_rest = entry_key:match('^[^_]+_(.*)$')
    local l_rest = loc_key:match('^[^_]+_(.*)$')
    if e_rest and e_rest == loc_key then return true end
    if l_rest and entry_key == l_rest then return true end
    if e_rest and l_rest and e_rest == l_rest then return true end
    return false
end

-- 条目名查找缓存：path -> { [loc_key] = entry_name | false }
local entry_cache = {}

-- 在已加载的本地化表中查找与 loc_key 匹配的条目名
local function find_entry_name(loc_tbl, loc_key)
    if type(loc_tbl) ~= 'table' then return nil end
    local bases = {}
    if type(loc_tbl.descriptions) == 'table' then
        table.insert(bases, loc_tbl.descriptions)
    end
    table.insert(bases, loc_tbl)
    for _, base in ipairs(bases) do
        if type(base) == 'table' then
            for _, category in pairs(base) do
                if type(category) == 'table' then
                    for entry_key, entry in pairs(category) do
                        if type(entry) == 'table' and entry.name ~= nil and entry_matches(entry_key, loc_key) then
                            return entry_key
                        end
                    end
                end
            end
        end
    end
    return nil
end

-- ============ 对外接口 ============

-- 获取指定 mod 卡牌条目的故事注释（行数组）；无注释返回 nil
function TEO_get_story_text(mod_id, loc_key)
    if not mod_id or mod_id == 'base' or not loc_key or loc_key == '' then
        return nil
    end
    local lang = TEO_get_cur_language() or 'zh_CN'
    if lang == 'en-us' or lang == 'default' then
        -- 注释主要写在中文文件中，英文语言时直接尝试 zh_CN
        lang = 'zh_CN'
    end

    local cache_key = string.format('%s:%s:%s', tostring(mod_id), tostring(lang), tostring(loc_key))
    if story_cache[cache_key] ~= nil then
        return story_cache[cache_key] or nil
    end

    local TEO_mod = TEO_get_mod()
    if not TEO_mod or not TEO_mod.path then return nil end
    local impl_base = TEO_ensure_slash(TEO_mod.path) .. 'impl/mods/' .. mod_id .. '/localization/'

    local story = nil
    local langs_try = { lang }
    if lang ~= 'zh_CN' then table.insert(langs_try, 'zh_CN') end
    for _, l in ipairs(langs_try) do
        local path = impl_base .. l .. '.lua'
        if NFS.getInfo(path) then
            -- 条目名查找（带缓存，避免重复 load 执行整个本地化文件）
            local ec = entry_cache[path]
            if not ec then
                ec = {}
                entry_cache[path] = ec
            end
            local entry_name = nil
            if ec[loc_key] ~= nil then
                entry_name = ec[loc_key] or nil
            else
                local loc_tbl = TEO_read_loc_file(path)
                entry_name = loc_tbl and find_entry_name(loc_tbl, loc_key) or nil
                ec[loc_key] = entry_name or false
            end
            -- 注释提取（带解析缓存，避免重复读文件）
            if entry_name then
                local parsed = get_parsed(path)
                if parsed then
                    story = extract_story(parsed, entry_name)
                    if story then break end
                end
            end
        end
    end

    story_cache[cache_key] = story or false
    return story or nil
end

-- ============ 富文本处理 ============

-- 只保留 G.C 中已注册的颜色标记（{C:xxx} / {X:xxx}），无效标记剥离为纯文字
local function sanitize_marks(text)
    if not text or text == '' then return text end
    text = text:gsub('{(%a+):([^}]-)}', function(kind, name)
        name = name:gsub('%s+', '')
        if (kind == 'C' or kind == 'X') and G and G.C and G.C[name] then
            return '{' .. kind .. ':' .. name .. '}'
        end
        return name == '' and '{}' or name
    end)
    return text
end

-- ============ 自动换行 ============

-- 单行最大可见字符数，超过则强制分行（避免长句把字挤出屏幕）
local STORY_LINE_MAX = 25

-- 断行时优先选用的标点（向前就近查找）
local WRAP_PUNCTUATION = '，。、；：！？,.;:!? '

-- UTF-8 辅助：Lua 的 string 操作按字节进行，多字节字符（如中文）必须按字符切分，
-- 否则会产生截断的 UTF-8 序列，导致 LÖVE 文本渲染（font:getWidth）崩溃。

-- 根据首字节返回 UTF-8 字符的字节长度
local function utf8_char_len(b)
    if not b then return 1 end
    if b < 0x80 then return 1
    elseif b < 0xE0 then return 2
    elseif b < 0xF0 then return 3
    elseif b < 0xF8 then return 4
    else return 1 end
end

-- 将字符串拆分为 UTF-8 字符数组（每个元素是一个完整字符）
local function utf8_chars(s)
    local chars = {}
    local i = 1
    local n = #s
    while i <= n do
        local len = utf8_char_len(s:byte(i))
        chars[#chars + 1] = s:sub(i, i + len - 1)
        i = i + len
    end
    return chars
end

-- 将一行按可见字符数限制自动换行，返回行数组
-- 按 UTF-8 字符切分，保证不切断多字节字符；
-- 优先在断点前 8 个字符内最近的标点处断行，找不到则硬切；
-- {C:xxx} 等富文本标记不可被切断，且不占用可见字符计数
local function wrap_story_line(line, max_chars)
    max_chars = max_chars or STORY_LINE_MAX
    if not line or line == '' then return { line } end

    local chars = utf8_chars(line)
    if #chars <= max_chars then return { line } end

    local out = {}
    local cur = {}
    local cur_len = 0 -- 当前行可见字符数

    local function flush()
        if #cur > 0 then
            out[#out + 1] = table.concat(cur)
            cur = {}
            cur_len = 0
        end
    end

    local i = 1
    local n = #chars
    while i <= n do
        local ch = chars[i]
        if ch == '{' then
            -- 富文本标记：从 { 到最近的 }，不占字符计数
            local j = i + 1
            while j <= n and chars[j] ~= '}' do j = j + 1 end
            if j <= n then
                cur[#cur + 1] = table.concat(chars, '', i, j)
                i = j + 1
            else
                -- 无闭合的 {，按普通字符处理
                cur[#cur + 1] = '{'
                cur_len = cur_len + 1
                i = i + 1
                if cur_len >= max_chars then flush() end
            end
        else
            -- 文本段：不能跨越下一个 '{'（富文本标记的开头）
            local next_brace = i
            while next_brace <= n and chars[next_brace] ~= '{' do next_brace = next_brace + 1 end
            local limit = math.min(n, next_brace - 1) -- 段内最后一个可消费的字符
            local take = math.max(0, max_chars - cur_len)
            if take == 0 then
                flush()
                take = max_chars
            end
            local j = math.min(limit, i + take - 1)
            if j < limit then
                -- 段内还有剩余：优先在 [i..j] 尾部 8 个字符内最近的标点处断行
                local cut = j
                local start = math.max(i, j - 7)
                for k = j, start, -1 do
                    if WRAP_PUNCTUATION:find(chars[k], 1, true) then
                        cut = k
                        break
                    end
                end
                cur[#cur + 1] = table.concat(chars, '', i, cut)
                cur_len = cur_len + (cut - i + 1)
                i = cut + 1
                -- 切出的段已结束：立即换行（标点断行时标点留在行尾）
                flush()
            else
                -- 消费到段尾（可能因 take 满，也可能段本身较短）
                cur[#cur + 1] = table.concat(chars, '', i, j)
                cur_len = cur_len + (j - i + 1)
                i = j + 1
                if cur_len >= max_chars then flush() end
            end
        end
    end
    flush()
    return out
end

-- ============ UI ============

function TEO_build_story_ui(story_lines)
    local text_nodes = {}
    for _, line in ipairs(story_lines) do
        if line and line ~= '' then
            -- 超长行自动换行，避免文字被挤出屏幕
            local wrapped = wrap_story_line(line)
            for _, wl in ipairs(wrapped) do
                table.insert(text_nodes, {
                    n = G.UIT.R,
                    config = { align = 'cm', padding = 0.02 },
                    nodes = {
                        { n = G.UIT.T, config = { text = sanitize_marks(wl), scale = 0.33, colour = HEX('EAE2D0'), shadow = true } }
                    }
                })
            end
        end
    end

    return {
        n = G.UIT.R,
        config = { align = 'cm', minw = 2.2, padding = 0.04, emboss = 0.08, r = 0.1, colour = HEX('23242E') },
        nodes = {
            -- 标题栏
            {
                n = G.UIT.R,
                config = { align = 'cm', minh = 0.32, padding = 0.03, r = 0.08, colour = HEX('3A3B4C') },
                nodes = {
                    { n = G.UIT.T, config = { text = localize('teo_story_tooltip') or '故事', scale = 0.34, colour = HEX('F2C879'), shadow = true } }
                }
            },
            -- 正文
            {
                n = G.UIT.R,
                config = { align = 'cm', padding = 0.04 },
                nodes = text_nodes
            }
        }
    }
end

-- ============ 挂载：卡牌悬停弹窗 ============
-- 只 hook G.UIDEF.card_h_popup（所有悬停弹窗的必经之路），
-- 避免与 generate_card_ui 的 info_queue 路径重复显示。
-- 幂等标记：模块重复加载（热重载）时不叠加包装
if not G.UIDEF.card_h_popup_teo_story_ref then
    G.UIDEF.card_h_popup_teo_story_ref = G.UIDEF.card_h_popup
    function G.UIDEF.card_h_popup(card)
        local ret_val = G.UIDEF.card_h_popup_teo_story_ref(card)

        local TEO_mod = TEO_get_mod()
        if not TEO_mod or not TEO_mod.config or not TEO_mod.config.show_story then
            return ret_val
        end
        if not card then return ret_val end

        local _c = card.config and card.config.center
        if not _c or not _c.key then return ret_val end

        -- 探测 Mod ID
        local mod_id = nil
        if _c.mod and _c.mod.id then
            mod_id = _c.mod.id
        elseif _c.mod_id then
            mod_id = _c.mod_id
        elseif SMODS.Centers and SMODS.Centers[_c.key] and SMODS.Centers[_c.key].mod then
            mod_id = SMODS.Centers[_c.key].mod.id
        elseif _c.config and _c.config.mod and _c.config.mod.id then
            mod_id = _c.config.mod.id
        end

        if not mod_id or mod_id == 'base' then return ret_val end

        local story_lines = TEO_get_story_text(mod_id, _c.key)
        if not story_lines then return ret_val end

        if ret_val and ret_val.nodes then
            -- 与弹窗内容之间留一点间距
            table.insert(ret_val.nodes, { n = G.UIT.R, config = { minh = 0.05 } })
            table.insert(ret_val.nodes, TEO_build_story_ui(story_lines))
        end

        return ret_val
    end
end

print('[TEOcean] 故事模块加载 (Hooked: card_h_popup)')
