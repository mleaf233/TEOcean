-- DEBUG 模式开关：开启后会打印更多调试信息
-- 初始值为 false，稍后会从配置中读取
local DEBUG = false
TEO_DEBUG = DEBUG

-- 更新 DEBUG 模式（供配置回调使用）
function TEO_set_debug_mode(enabled)
    DEBUG = enabled
    TEO_DEBUG = enabled
end
function TEO_get_mod()
    return SMODS.current_mod or TEO
end

function TEO_ensure_slash(path)
    if not path then return "" end
    if path:sub(-1) ~= '/' and path:sub(-1) ~= '\\' then
        return path .. '/'
    end
    return path
end

-- nativefs reports many failures as nil/false return values rather than errors.
function TEO_fs_call(fn, ...)
    local ok, result, detail = pcall(fn, ...)
    if not ok then return false, result end
    if result == nil or result == false then
        return false, detail or 'filesystem operation failed'
    end
    return true, result, detail
end

function TEO_trim_string(s)
    if type(s) ~= "string" then return "" end
    return s:match("^%s*(.-)%s*$") or ""
end

function TEO_has_required_ai_config(cfg)
    if type(cfg) ~= "table" then return false end
    return TEO_trim_string(cfg.api_url) ~= ""
        and TEO_trim_string(cfg.api_model) ~= ""
        and TEO_trim_string(cfg.api_key) ~= ""
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

-- 检测是否为安卓平台（带安全检查）
local TEO_os_ok, TEO_os_name = pcall(function()
    return love and love.system and love.system.getOS()
end)
local TEO_is_android = TEO_os_ok and TEO_os_name == 'Android'

local TEO_debug_log_path = nil

-- 初始化 debug 日志路径（带错误处理）
local function init_debug_log_path()
    if not TEO_is_android then return end
    if not NFS then return end

    local ok, err = pcall(function()
        local TEO_mod = TEO_get_mod()
        if not TEO_mod or not TEO_mod.path then return end

        local teo_path = TEO_ensure_slash(TEO_mod.path)
        local debug_dir = teo_path .. 'impl/debug/'

        -- 确保 debug 目录存在
        if not NFS.getInfo(debug_dir) then
            NFS.createDirectory(debug_dir)
        end

        -- 使用带时间戳的日志文件名
        local timestamp = os.date('%Y%m%d_%H%M%S')
        TEO_debug_log_path = debug_dir .. 'debug_' .. timestamp .. '.log'

        -- 写入日志文件头
        local header = string.format('[TEOcean Debug Log] Started at %s\n', os.date('%Y-%m-%d %H:%M:%S'))
        NFS.write(TEO_debug_log_path, header)
    end)

    if not ok then
        print('[TEOcean] Failed to initialize debug log:', err)
        TEO_debug_log_path = nil
    end
end

-- 延迟初始化（确保 mod 已加载）
local TEO_debug_initialized = false

function TEO_dbg_print(...)
    if not DEBUG then return end

    -- 安全地将参数转换为字符串
    local function safe_tostring(v)
        local ok, str = pcall(function()
            if v == nil then return "nil"
            elseif type(v) == "string" then return v
            elseif type(v) == "table" then
                local parts = {}
                for k, val in pairs(v) do
                    table.insert(parts, tostring(k) .. "=" .. tostring(val))
                end
                return "{" .. table.concat(parts, ", ") .. "}"
            else return tostring(v) end
        end)
        return ok and str or ("<" .. type(v) .. ">")
    end

    -- 构建日志字符串
    local args = {...}
    local parts = {}
    for i, v in ipairs(args) do
        table.insert(parts, safe_tostring(v))
    end
    local log_line = '[TEOcean DEBUG] ' .. table.concat(parts, '\t')

    if TEO_is_android then
        -- 延迟初始化日志路径
        if not TEO_debug_initialized then
            pcall(init_debug_log_path)
            TEO_debug_initialized = true
        end

        -- 安全写入文件
        if TEO_debug_log_path and NFS then
            pcall(function()
                NFS.append(TEO_debug_log_path, log_line .. '\n')
            end)
        end
    end

    -- 始终输出到控制台作为备份
    pcall(print, log_line)
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

function TEO_deep_copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    seen = seen or {}
    if seen[obj] then return seen[obj] end
    local res = {}
    seen[obj] = res
    for k, v in pairs(obj) do
        res[TEO_deep_copy(k, seen)] = TEO_deep_copy(v, seen)
    end
    return res
end

function TEO_is_sequence_table(t)
    if type(t) ~= 'table' then return false end
    local count = 0
    local max_index = 0
    for k, _ in pairs(t) do
        if type(k) ~= 'number' or k <= 0 or k % 1 ~= 0 then
            return false
        end
        count = count + 1
        if k > max_index then max_index = k end
    end
    return count > 0 and count == max_index
end

function TEO_table_has_nested_table(t)
    if type(t) ~= 'table' then return false end
    for _, v in pairs(t) do
        if type(v) == 'table' then
            return true
        end
    end
    return false
end

function TEO_collect_text_parts(value, parts)
    parts = parts or {}
    if type(value) == 'string' then
        parts[#parts + 1] = value
    elseif type(value) == 'number' or type(value) == 'boolean' then
        parts[#parts + 1] = tostring(value)
    elseif type(value) == 'table' then
        if TEO_is_sequence_table(value) then
            for i = 1, #value do
                TEO_collect_text_parts(value[i], parts)
            end
        else
            for _, v in pairs(value) do
                TEO_collect_text_parts(v, parts)
            end
        end
    end
    return parts
end

function TEO_loc_translation_uses_tree(data)
    if type(data) ~= 'table' then return false end
    if type(data.name) == 'table' then
        return true
    end
    if type(data.text) == 'table' and TEO_table_has_nested_table(data.text) then
        return true
    end
    for k, v in pairs(data) do
        if k ~= 'name' and k ~= 'text' and type(v) == 'table' and TEO_table_has_nested_table(v) then
            return true
        end
    end
    return false
end

function TEO_resolve_actual_loc_set_key(set_key)
    local localization_set_map = {
        Booster = 'Other',
    }
    return localization_set_map[set_key] or set_key
end

function TEO_get_loc_set_key_candidates(set_key)
    local candidates = {}
    local function add_candidate(value)
        if not value then return end
        for _, existing in ipairs(candidates) do
            if existing == value then return end
        end
        candidates[#candidates + 1] = value
    end

    add_candidate(set_key)
    add_candidate(TEO_resolve_actual_loc_set_key(set_key))
    return candidates
end

function TEO_loc_has_content(loc_data, is_tree)
    if type(loc_data) == 'string' then
        return loc_data ~= ''
    end
    if type(loc_data) == 'number' or type(loc_data) == 'boolean' then
        return true
    end
    if type(loc_data) ~= 'table' then
        return false
    end

    local function value_has_content(value)
        if type(value) == 'string' then return value ~= '' end
        if type(value) == 'number' or type(value) == 'boolean' then return true end
        if type(value) ~= 'table' then return false end
        for _, child in pairs(value) do
            if value_has_content(child) then return true end
        end
        return false
    end

    if value_has_content(loc_data.name) or value_has_content(loc_data.text) or value_has_content(loc_data.unlock) then
        return true
    end
    if is_tree then
        return next(loc_data) ~= nil
    end
    return next(loc_data) ~= nil
end

function TEO_strip_runtime_loc_metadata(node)
    if type(node) ~= 'table' then
        return node
    end

    local res = {}
    for k, v in pairs(node) do
        if k ~= 'name_parsed' and k ~= 'text_parsed' and k ~= 'unlock_parsed' then
            res[k] = TEO_strip_runtime_loc_metadata(v)
        end
    end
    return res
end

function TEO_deep_equal(lhs, rhs)
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
        if not TEO_deep_equal(v, rhs[k]) then
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

function TEO_loc_equals(lhs, rhs)
    return TEO_deep_equal(TEO_strip_runtime_loc_metadata(lhs), TEO_strip_runtime_loc_metadata(rhs))
end

function TEO_loc_translation_shape_matches(expected, actual)
    if expected == nil then return actual == nil end
    if type(expected) ~= 'table' then
        if actual == nil then return true end
        return type(actual) ~= 'table'
    end
    if type(actual) ~= 'table' then return false end

    local expected_array = TEO_is_sequence_table(expected)
    local actual_array = TEO_is_sequence_table(actual)
    if expected_array ~= actual_array then return false end

    if expected_array then
        if #expected ~= #actual then return false end
        for i = 1, #expected do
            if not TEO_loc_translation_shape_matches(expected[i], actual[i]) then return false end
        end
        return true
    end

    for k, v in pairs(expected) do
        local actual_child = actual[k]
        if type(v) == 'table' then
            if not TEO_loc_translation_shape_matches(v, actual_child) then return false end
        else
            if actual_child ~= nil and type(actual_child) == 'table' then return false end
        end
    end
    return true
end

TEO_last_loc_read_error = TEO_last_loc_read_error or nil

local function TEO_set_loc_read_error(path, stage, err)
    local msg = tostring(err or 'unknown error')
    TEO_last_loc_read_error = {
        path = path,
        stage = stage,
        message = msg,
    }
    print(('[TEOcean Language Packs] 读取本地化失败[%s]: %s (%s)'):format(tostring(stage), tostring(path), msg))
end

function TEO_get_last_loc_read_error()
    return TEO_last_loc_read_error
end

-- helper: 读取 .lua 或 .json 文件并返回 table
function TEO_read_loc_file(path)
    TEO_last_loc_read_error = nil
    local info = NFS.getInfo(path)
    if not info then
        TEO_last_loc_read_error = {
            path = path,
            stage = 'stat',
            message = 'file not found',
        }
        return nil
    end
    local ok_read, content = TEO_fs_call(NFS.read, path)
    if not ok_read then
        TEO_set_loc_read_error(path, 'read', content)
        return nil
    end
    if path:lower():match('%.json$') then
        local ok_json, parsed = pcall(JSON.decode, content)
        if ok_json then
            if type(parsed) ~= 'table' then
                TEO_set_loc_read_error(path, 'json-structure', 'decoded value is not a table')
                return nil
            end
            return parsed
        end
        TEO_set_loc_read_error(path, 'json-decode', parsed)
        return nil
    else
        local chunk, errc = load(tostring(content), ('=[TEOcean loc "%s"]'):format(path))
        if not chunk then
            TEO_set_loc_read_error(path, 'lua-load', errc)
            return nil
        end
        local ok_exec, res = pcall(chunk)
        if not ok_exec then
            TEO_set_loc_read_error(path, 'lua-runtime', res)
            return nil
        end
        if type(res) ~= 'table' then
            TEO_set_loc_read_error(path, 'lua-return-type', 'chunk returned ' .. tostring(type(res)))
            return nil
        end
        return res
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
        return '"<cycle>"'
    end
    visited[tbl] = true

    local next_indent = indent .. '  '
    local parts = {}

    -- 判断是否为数组（1..n 连续）
    local is_array = true
    local max_index = 0
    local count = 0

    for k, _ in pairs(tbl) do
        count = count + 1
        if type(k) ~= 'number' or k <= 0 or k % 1 ~= 0 then
            is_array = false
            break
        end
        if k > max_index then max_index = k end
    end

    -- 空表直接返回
    if count == 0 then
        visited[tbl] = nil
        return '{}'
    end

    -- 数组必须是连续的
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
            elseif v == nil then
                val = 'nil' -- 明确处理 nil
            else
                val = 'nil'
            end
            parts[#parts + 1] = next_indent .. val
        end
    else
        -- map
        local keys = {}
        for k in pairs(tbl) do keys[#keys + 1] = k end
        table.sort(keys, function(a, b)
            if type(a) == type(b) then
                if type(a) == 'number' then return a < b end
                return tostring(a) < tostring(b)
            end
            return type(a) < type(b)
        end)

        for _, k in ipairs(keys) do
            local v = tbl[k]
            local key
            if type(k) == 'string' and k:match('^[%a_][%w_]*$') then -- 允许下划线开头
                key = k
            elseif type(k) == 'number' then
                key = '[' .. k .. ']'
            elseif type(k) == 'string' then
                -- 修复：其他字符串 key 也序列化
                key = '[' .. string.format('%q', k) .. ']'
            else
                key = nil
            end

            if key then
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
            end
        end
    end

    visited[tbl] = nil
    if #parts == 0 then
        return '{}'
    end

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

function TEO_init_UI_configs()
    local mod = TEO_get_mod()
    -- if initialized == true then
    --     return
    -- end
    if mod and not mod.config then
        mod.config = {}
    end
    if mod and mod.config and not mod.config.clicked_list then
        mod.config.clicked_list = {}
    end
    if mod and mod.config and not mod.config.skip_backup_list then
        mod.config.skip_backup_list = {}
    end
    -- 初始化"显示原版翻译"配置项
    if mod and mod.config and mod.config.show_original_translation == nil then
        mod.config.show_original_translation = false
    end
    -- 初始化"显示原版盲注翻译"配置项
    if mod and mod.config and mod.config.show_original_blind_translation == nil then
        mod.config.show_original_blind_translation = false
    end
    -- 初始化"显示故事"配置项
    if mod and mod.config and mod.config.show_story == nil then
        mod.config.show_story = false
    end
    -- 初始化"关闭侧边栏"配置项
    if mod and mod.config and mod.config.disable_edge_sidebar == nil then
        mod.config.disable_edge_sidebar = false
    end
    -- 统一使用 UI 和业务逻辑实际读取的配置键；磁盘模式是默认行为。
    if mod and mod.config and mod.config.use_runtime_override == nil then
        mod.config.use_runtime_override = false
    end
    if mod and mod.config then
        mod.config.runtime_override = nil
    end
    -- 初始化"启用DEBUG模式"配置项
    if mod and mod.config and mod.config.enable_debug == nil then
        mod.config.enable_debug = false
    end
    -- 初始化 AI 接口配置（必填：URL / Model / API Key）
    if mod and mod.config and mod.config.api_url == nil then
        mod.config.api_url = "https://api.deepseek.com/v1/chat/completions"
    end
    if mod and mod.config and mod.config.api_model == nil then
        mod.config.api_model = "deepseek-chat"
    end
    if mod and mod.config and mod.config.api_key == nil then
        mod.config.api_key = ""
    end
    -- 可选：手动指定协议（auto/openai/claude/gemini），默认自动识别
    if mod and mod.config and mod.config.api_format == nil then
        mod.config.api_format = "auto"
    end
end

-- 初始化配置，从当前mod的配置中加载
function TEO_init_configs()
    TEO_init_UI_configs()
    -- 从配置中读取 DEBUG 模式设置
    local mod = TEO_get_mod()
    if mod and mod.config and mod.config.enable_debug then
        TEO_set_debug_mode(true)
    end
end

-- 保存配置到当前mod的配置中
function TEO_save_configs()
    local mod = TEO_get_mod()
    -- 确保配置表存在

    if mod and not mod.config then
        mod.config = {}
    end
    if mod and mod.config and not mod.config.clicked_list then
        mod.config.clicked_list = {}
    end

    -- 保存当前mod的配置
    if mod then
        local ok = SMODS.save_mod_config(mod)
        if ok == false then
            print('[TEOcean] 配置保存失败')
            return false
        end
        TEO_dbg_print('[TEOcean] 配置已保存到SMODS配置系统')
        return true
    end
    return false
end

-- 获取已适配mod列表的译者，在每个本地化文件的 translator表中
function TEO_get_translators(target_mod, lang)
    local TEO_mod = TEO_get_mod()
    if not TEO_mod or not TEO_mod.path then return {} end

    if lang == nil or type(lang) ~= "string" then
        lang = G.SETTINGS.language or 'en-us'
    end
    local loc_path = TEO_mod.path .. 'impl/mods/' .. target_mod.id .. '/localization/' .. lang .. '.lua'
    if NFS.getInfo(loc_path) then
        local loc_table = TEO_read_loc_file(loc_path)
        if loc_table and type(loc_table) == 'table' then
            if loc_table.translator then
                if type(loc_table.translator) == 'table' then
                    return loc_table.translator
                elseif type(loc_table.translator) == 'string' then
                    return { loc_table.translator }
                end
            end
            if loc_table.misc and loc_table.misc.translator then
                if type(loc_table.misc.translator) == 'table' then
                    return loc_table.misc.translator
                elseif type(loc_table.misc.translator) == 'string' then
                    return { loc_table.misc.translator }
                end
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
    -- TEO_dbg_print('[TEOcean] 当前语言检测:', tostring(cur_lang))
    return cur_lang
end

function TEO_create_hover_tooltip(args)
    args = args or {}

    -- 按照 SMODS 的标准方式：直接传递 set 和 key
    -- 游戏会自动从 G.localization.descriptions 中查找
    local tooltip_key = args.tooltip_key or "teo_show_original"

    -- TEO_dbg_print('[TEOcean Tooltip] 使用 key:', tooltip_key)

    -- 直接返回 set/key 对象，让游戏自动处理
    local tooltip_content = {
        set = "Other",
        key = tooltip_key
    }

    TEO_dbg_print('[TEOcean Tooltip] tooltip_content:', tooltip_content)

    return {
        n = args.top_level_node or G.UIT.C,
        config = {
            align = "cm"
        },
        nodes = {
            {
                n = G.UIT.R,
                config = {
                    align = "cm",
                    hover = true,
                    can_collide = true,
                    r = args.round or 0.1,
                    maxh = args.h or 0.5,
                    maxw = args.w or 0.5,
                    minh = args.h or 0.5,
                    minw = args.w or 0.5,
                    focus_args = { snap_to = true },
                    detailed_tooltip = tooltip_content,
                    func = args.func,
                    colour = args.colour or HEX('0096C7'),
                    padding = args.padding or 0.1,
                },
                nodes = {
                    {
                        n = G.UIT.T,
                        config = {
                            text = args.text or "i",
                            colour = args.text_colour or G.C.WHITE,
                            scale = args.scale or 0.3,
                        }
                    }
                }
            }
        }
    }
end
