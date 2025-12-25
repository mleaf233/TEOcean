-- DEBUG 模式开关：开启后会打印更多调试信息
local DEBUG = false
local mod = SMODS.current_mod

-- Credits: Steamodded
-- I was lazy and it's not like I'm going to code anything different from this anyways~
local function recurse(target, ref_table)
    if type(target) ~= 'table' then return end --this shouldn't happen unless there's a bad return value
    for k, v in pairs(target) do
        if not ref_table[k] or (type(v) ~= 'table') then
            ref_table[k] = v
        else
            recurse(v, ref_table[k])
        end
    end
end

function TEO_printTable(t, indent, visited)
    if type(t) ~= "table" then
        print("TEO_printTable: 传入的参数不是表格类型")
        return
    end
    print("TEO_printTable 开始 =====================================")
    indent = indent or 0
    visited = visited or {}

    -- 避免循环引用
    if visited[t] then
        print(string.rep(" ", indent) .. "*循环引用*\n")
        return
    end
    visited[t] = true

    local spaces = string.rep(" ", indent)

    for k, v in pairs(t) do
        local keyStr = type(k) == "string" and k or "[" .. tostring(k) .. "]"

        if type(v) == "table" then
            print(spaces .. keyStr .. " = {\n")
            TEO_printTable(v, indent + 2, visited)
            print(spaces .. "}\n")
        else
            local valueStr
            if type(v) == "string" then
                valueStr = "'" .. v .. "'"
            else
                valueStr = tostring(v)
            end
            print(spaces .. keyStr .. " = " .. valueStr .. "\n")
        end
    end

    visited[t] = nil -- 清理visited标记
    print("TEO_printTable 结束 =====================================")
end

function TEO_insert_unique_first(t, v)
    if not v then return end
    for _, x in ipairs(t) do
        if x == v then return end
    end
    table.insert(t, 1, v)
end

function TEO_dbg_print(...)
    if not DEBUG then return end
    print('[TEOcean DEBUG]', ...)
end

function TEO_tbl_count(t)
    if type(t) ~= 'table' then return 0 end
    local c = 0
    for _ in pairs(t) do c = c + 1 end
    return c
end

function TEO_merge_table(dest, src)
    if type(src) ~= 'table' then return end
    dest = dest or {}
    for k, v in pairs(src) do
        if type(k) == 'number' then
            dest[k] = v
        else
            if dest[k] == nil then
                dest[k] = v
            else
                if type(v) == 'table' and type(dest[k]) == 'table' then
                    TEO_merge_table(dest[k], v)
                else
                    -- impl 优先覆盖原始 mod
                    dest[k] = v
                end
            end
        end
    end
    return dest
end

-- helper: 读取 .lua 或 .json 文件并返回 table
function TEO_read_loc_file(path)
    local info = NFS.getInfo(path)
    if not info then return nil end
    local ok_read, content = pcall(NFS.read, path)
    if not ok_read then return nil end
    if path:lower():match('%.json$') then
        local ok_json, parsed = pcall(JSON.decode, content)
        if ok_json then return parsed end
        return nil
    else
        local chunk, errc = load(tostring(content), ('=[TEOcean loc "%s"]'):format(path))
        if not chunk then return nil end
        local ok_exec, res = pcall(chunk)
        if ok_exec then return res end
        return nil
    end
end

function TEO_normalize_str(s)
    if not s then return s end
    -- 统一换行并去掉尾部空白，减少无意义差异
    s = tostring(s):gsub('\r\n', '\n')
    s = s:gsub('[ \t\n\r]+$', '')
    return s
end

function TEO_table_to_lua(tbl, indent, visited)
    indent = indent or ''
    visited = visited or {}

    if type(tbl) ~= 'table' then
        return 'nil'
    end

    -- 循环引用检测
    if visited[tbl] then
        return '"<cycle>"' -- 或 error / nil
    end
    visited[tbl] = true

    local next_indent = indent .. '  '
    local parts = {}

    -- 判断是否为数组（1..n 连续）
    local is_array = true
    local max_index = 0
    local count = 0

    for k, _ in pairs(tbl) do
        if type(k) ~= 'number' or k <= 0 or k % 1 ~= 0 then
            is_array = false
            break
        end
        if k > max_index then max_index = k end
        count = count + 1
    end

    if is_array and count == max_index then
        -- array
        for i = 1, max_index do
            local v = tbl[i]
            local val
            if type(v) == 'table' then
                val = TEO_table_to_lua(v, next_indent, visited)
            elseif type(v) == 'string' then
                val = string.format('%q', v)
            elseif type(v) == 'number' or type(v) == 'boolean' then
                val = tostring(v)
            else
                val = 'nil'
            end
            parts[#parts + 1] = next_indent .. val
        end
    else
        -- map
        for k, v in pairs(tbl) do
            local key
            if type(k) == 'string' and k:match('^%a[_%w]*$') then
                key = k
            elseif type(k) == 'number' then
                key = '[' .. k .. ']'
            else
                -- 跳过不可序列化 key
                goto continue
            end

            local val
            if type(v) == 'table' then
                val = TEO_table_to_lua(v, next_indent, visited)
            elseif type(v) == 'string' then
                val = string.format('%q', v)
            elseif type(v) == 'number' or type(v) == 'boolean' then
                val = tostring(v)
            else
                val = 'nil'
            end

            parts[#parts + 1] = next_indent .. key .. ' = ' .. val
            ::continue::
        end
    end

    visited[tbl] = nil
    return '{\n' .. table.concat(parts, ',\n') .. '\n' .. indent .. '}'
end

function TEO_quick_reload_lang(e)
    local current_lang = G.LANG
    local lang = current_lang
    if lang then
        G.SETTINGS.language = lang.key
        G:set_language()
        G.E_MANAGER:clear_queue()
        G.FUNCS.wipe_on()
        G.E_MANAGER:add_event(Event({
            no_delete = true,
            blockable = true,
            blocking = false,
            func = function()
                G:delete_run()
                G:init_item_prototypes()
                G:main_menu()
                return true
            end
        }))
        G.FUNCS.wipe_off()
    end
end

local initialized = false
-- 初始化配置，从当前mod的配置中加载
function TEO_init_configs()
    -- 如果当前mod的配置中没有teocean_configs项，则初始化为空表
    if initialized == true then
        return
    end
    if not mod.config then
        mod.config = {}
    end
    if not mod.config.clicked_list then
        mod.config.clicked_list = {}
    end
    if not mod.config.skip_backup_list then
        mod.config.skip_backup_list = {}
    end

    for _, modInfo in ipairs(SMODS.mod_list or {}) do
        if mod.config.clicked_list[modInfo.id] ~= nil then
            modInfo.should_teo_localize = mod.config.clicked_list[modInfo.id]
        elseif modInfo.should_teo_localize == nil then
            -- 默认值为false
            modInfo.should_teo_localize = false
        end
    end
    initialized = true
end

-- 保存配置到当前mod的配置中
function TEO_save_configs()
    -- 确保配置表存在

    if not mod.config then
        mod.config = {}
    end
    if not mod.config.clicked_list then
        mod.config.clicked_list = {}
    end

    -- 保存当前mod的配置
    SMODS.save_mod_config(mod)
    print('[TEOcean] 配置已保存到SMODS配置系统')
end

-- 获取已适配mod列表的译者，在每个本地化文件的 translator表中
function TEO_get_translators(target_mod, lang)
    if lang == nil or type(lang) ~= "string" then
        lang = G.SETTINGS.language or 'en-us'
    end
    loc_path = mod.path .. 'impl/mods/' .. target_mod.id .. '/localization/' .. lang .. '.lua'
    if NFS.getInfo(loc_path) then
        local loc_table = TEO_read_loc_file(loc_path)
        if loc_table and type(loc_table) == 'table' and loc_table.translator then
            if type(loc_table.translator) == 'table' then
                return loc_table.translator
            elseif type(loc_table.translator) == 'string' then
                return { loc_table.translator }
            end
        end
        if loc_table and type(loc_table) == 'table' and loc_table.misc and loc_table.misc.translator then
            if type(loc_table.misc.translator) == 'table' then
                return loc_table.misc.translator
            elseif type(loc_table.misc.translator) == 'string' then
                return { loc_table.misc.translator }
            end
        end
    end
    return {}
end

function TEO_get_cur_language()
    local cur_lang = nil
    if G and G.SETTINGS and G.SETTINGS.language then
        cur_lang = G.SETTINGS.language
    end
    if G and G.SETTINGS and G.SETTINGS.real_language then
        cur_lang = G.SETTINGS.real_language
    end
    return cur_lang
end

-- 在初始化时加载配置
-- TEO_init_configs()

-- local card_h_popup_ref = G.UIDEF.card_h_popup

-- function G.UIDEF.card_h_popup(card)
--     -- print('G.UIDEF.card_h_popup: \n', inspectDepth(card, nil, 5))
--     local ret_val = card_h_popup_ref(card)
--     return ret_val
-- end

-- local generate_card_ui_ref = generate_card_ui
-- function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
--     if full_UI_table and type(full_UI_table) == 'table' then
--         print('generate_card_ui_name: ', inspectDepth(localize{type = 'name', set = _c.set, key = _c.key, nodes = full_UI_table}))
--     end
--     local t = generate_card_ui_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
--     return t
-- end

-- local function load_localization(loc_table)
--     if loc_table and type(loc_table) == 'table' then
--         recurse(loc_table, G.localization)
--     else
--         return
--     end
-- end

-- local init_localization_ref = init_localization
-- function init_localization(loc_table)
--     load_localization(loc_table)
--     return init_localization_ref()
-- end

-- local set_language_ref = Game.set_language

-- function Game:set_language(localization)
--     print('Game:set_language_1')

--     if localization and type(localization) == 'table' then
--         init_localization(localization)
--     end
--     print('Game:set_language_2')
--     -- 调用原函数，保持参数不变
--     set_language_ref(G, localization)
-- end
