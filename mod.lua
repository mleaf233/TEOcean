local mod = SMODS.current_mod

local DEBUG = false
local function merge_impl_mod_localizations()
    if not mod or not mod.path then return end

    local function dbg_print(...)
        if not DEBUG then return end
        print('[TEOcean DBG]', ...)
    end
    local function tbl_count(t)
        if type(t) ~= 'table' then return 0 end
        local c = 0
        for _ in pairs(t) do c = c + 1 end
        return c
    end
    -- helper: 读取 .lua 或 .json 文件并返回 table
    local function read_loc_file(path)
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

    local function merge_table(dest, src)
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
                        merge_table(dest[k], v)
                    else
                        -- impl 优先覆盖原始 mod
                        dest[k] = v
                    end
                end
            end
        end
        return dest
    end

    local function table_to_lua(tbl, indent)
        indent = indent or ''
        local next_indent = indent .. '  '
        local parts = {}
        local is_array = true
        local max_index = 0
        for k, _ in pairs(tbl) do
            if type(k) ~= 'number' then
                is_array = false; break
            end
            if type(k) == 'number' and k > max_index then max_index = k end
        end
        if is_array then
            for i = 1, max_index do
                local v = tbl[i]
                if type(v) == 'table' then
                    parts[#parts + 1] = next_indent .. table_to_lua(v, next_indent)
                elseif type(v) == 'string' then
                    parts[#parts + 1] = next_indent .. string.format('%q', v)
                else
                    parts[#parts + 1] = next_indent .. tostring(v)
                end
            end
            return '{\n' .. table.concat(parts, ',\n') .. '\n' .. indent .. '}'
        else
            for k, v in pairs(tbl) do
                local key
                if type(k) == 'string' and k:match('^%a[_%w]*$') then key = k else key = string.format('[%q]',
                        tostring(k)) end
                local val
                if type(v) == 'table' then
                    val = table_to_lua(v, next_indent)
                elseif type(v) == 'string' then
                    val = string.format('%q', v)
                else
                    val = tostring(v)
                end
                parts[#parts + 1] = next_indent .. key .. ' = ' .. val
            end
            return '{\n' .. table.concat(parts, ',\n') .. '\n' .. indent .. '}'
        end
    end

    -- 递归比较：返回 base 中在 other 中缺失的键及其原始值（保留原始结构）
    local function diff_table(base, other)
        if type(base) ~= 'table' then return nil end
        local res = {}
        for k, v in pairs(base) do
            local ov = (type(other) == 'table') and other[k] or nil
            if type(v) == 'table' then
                -- 特例: 仅当 key 为 'text' 或 'unlock' 时应用特殊逻辑：
                -- 如果 base.text 中任意一行为非空（非 nil 且非空字符串），则认为该键不是缺失的，跳过标记。
                if k == 'text' or k == 'unlock' then
                    local has_non_empty = false
                    for _, line in pairs(v) do
                        if line ~= nil and tostring(line) ~= '' then
                            has_non_empty = true
                            dbg_print('found non-empty text line (key=', k, ')->', tostring(line))
                            break
                        end
                    end
                    if not has_non_empty then
                        local sub = diff_table(v, ov)
                        if sub and next(sub) then res[k] = sub end
                    end
                else
                    local sub = diff_table(v, ov)
                    if sub and next(sub) then res[k] = sub end
                end
            else
                if ov == nil or ov == '' then
                    res[k] = v
                end
            end
        end
        return res
    end

    -- languages to process (原 mod 文件 + impl 覆盖)
    local langs = { 'zh_CN', 'en-us', 'default' }
    if G and G.SETTINGS and G.SETTINGS.language then table.insert(langs, 1, G.SETTINGS.language) end
    if G and G.SETTINGS and G.SETTINGS.real_language then table.insert(langs, 1, G.SETTINGS.real_language) end

    for _, target_mod in ipairs(SMODS.mod_list or {}) do
        if not (target_mod and target_mod.id and target_mod.path) then goto continue end
        -- 只处理 impl/mods 下存在对应文件夹的 mod，避免修改未适配的 mod
        local impl_mod_dir = mod.path .. 'impl/mods/' .. target_mod.id .. '/'
        if not NFS.getInfo(impl_mod_dir) then
            -- 跳过没有 impl 适配的 mod
            -- print(('[TEOcean Language Packs] 跳过未适配 mod: %s'):format(target_mod.id))
            goto continue
        end
        local merged_by_lang = {}
        -- 1) 读取并合并目标 mod 自带的 localization 文件
        local loc_dir = target_mod.path .. 'localization/'
        for _, lang in ipairs(langs) do
            local file_lua = loc_dir .. lang .. '.lua'
            local file_json = loc_dir .. lang .. '.json'
            local t = nil
            if NFS.getInfo(file_lua) then
                t = read_loc_file(file_lua)
                dbg_print('read base file', file_lua, '->', type(t), 'keys=', tbl_count(t))
            end
            if not t and NFS.getInfo(file_json) then
                t = read_loc_file(file_json)
                dbg_print('read base file', file_json, '->', type(t), 'keys=', tbl_count(t))
            end
            if t and type(t) == 'table' then
                dbg_print('merging base loc into lang', lang, 'for', target_mod.id, 'src_keys=', tbl_count(t))
                merged_by_lang[lang] = merge_table(merged_by_lang[lang] or {}, t)
                dbg_print('merged_by_lang[' .. tostring(lang) .. '] now keys=', tbl_count(merged_by_lang[lang]))
            end
        end

        -- 2) 读取并合并 impl/mods/<modid>/localization/ 下的文件，覆盖原始
        local impl_base = mod.path .. 'impl/mods/' .. target_mod.id .. '/localization/'
        if NFS.getInfo(impl_base) then
            for _, lang in ipairs(langs) do
                local file_lua = impl_base .. lang .. '.lua'
                local file_json = impl_base .. lang .. '.json'
                local t = nil
                if NFS.getInfo(file_lua) then
                    t = read_loc_file(file_lua)
                    dbg_print('read impl file', file_lua, '->', type(t), 'keys=', tbl_count(t))
                end
                if not t and NFS.getInfo(file_json) then
                    t = read_loc_file(file_json)
                    dbg_print('read impl file', file_json, '->', type(t), 'keys=', tbl_count(t))
                end
                if t and type(t) == 'table' then
                    dbg_print('merging impl loc into lang', lang, 'for', target_mod.id, 'src_keys=', tbl_count(t))
                    merged_by_lang[lang] = merge_table(merged_by_lang[lang] or {}, t)
                    dbg_print('merged_by_lang[' .. tostring(lang) .. '] now keys=', tbl_count(merged_by_lang[lang]))
                end
            end
        end

        -- 额外：将合并后的本地化与原 mod 的 en-us.lua 比较，生成缺失翻译清单并保存到 impl/todo/<modid>/
        local orig_en = nil
        local orig_en_lua = loc_dir .. 'en-us.lua'
        local orig_en_json = loc_dir .. 'en-us.json'
        if NFS.getInfo(orig_en_lua) then
            orig_en = read_loc_file(orig_en_lua)
            dbg_print('read orig en lua', orig_en_lua, '->', type(orig_en), 'keys=', tbl_count(orig_en))
        end
        if not orig_en and NFS.getInfo(orig_en_json) then
            orig_en = read_loc_file(orig_en_json)
            dbg_print('read orig en json', orig_en_json, '->', type(orig_en), 'keys=', tbl_count(orig_en))
        end
        if orig_en and type(orig_en) == 'table' then
            local todo_root = mod.path .. 'impl/todo/'
            if not NFS.getInfo(todo_root) then pcall(NFS.createDirectory, todo_root) end
            local todo_mod_dir = todo_root .. target_mod.id .. '/'
            if not NFS.getInfo(todo_mod_dir) then pcall(NFS.createDirectory, todo_mod_dir) end
            for lang, merged_tbl in pairs(merged_by_lang) do
                -- 对每个目标语言，找出原 en 中存在但合并后缺失的键
                dbg_print('computing missing for', target_mod.id, 'lang', lang, 'orig_en_keys=', tbl_count(orig_en), 'merged_keys=', tbl_count(merged_tbl))
                local missing = diff_table(orig_en, merged_tbl)
                if missing and next(missing) then
                    local out_path = todo_mod_dir .. 'missing_' .. tostring(lang) .. '.lua'
                    local content = 'return ' .. table_to_lua(missing, '') .. '\n'
                    dbg_print('missing table for', target_mod.id, lang, 'top_keys=', tbl_count(missing))
                    local okw, errw = pcall(NFS.write, out_path, content)
                    if okw then
                        print(('[TEOcean Language Packs] 生成缺失翻译: %s -> %s'):format(target_mod.id, out_path))

                    else
                        print(('[TEOcean Language Packs] 写入缺失翻译失败: %s -> %s (%s)'):format(target_mod.id, out_path, tostring(errw)))
                    end
                end
            end
        else
            -- 如果没有原始 en-us，可选地记录一条信息
            print(('[TEOcean Language Packs] 未找到原始 en-us，跳过缺失翻译检查: %s'):format(target_mod.id))
        end

        -- 3) 将合并结果写回到目标 mod 的 localization 目录（创建目录如有必要），并先备份原始文件到 impl/backup/<modid>/localization/
        local out_dir = target_mod.path .. 'localization/'
        if not NFS.getInfo(out_dir) then pcall(NFS.createDirectory, out_dir) end
        local backup_root = mod.path .. 'impl/backup/'
        if not NFS.getInfo(backup_root) then pcall(NFS.createDirectory, backup_root) end
        local backup_mod_dir = mod.path .. 'impl/backup/' .. target_mod.id .. '/'
        if not NFS.getInfo(backup_mod_dir) then pcall(NFS.createDirectory, backup_mod_dir) end
        local backup_base = backup_root .. target_mod.id .. '/localization/'
        if not NFS.getInfo(backup_base) then pcall(NFS.createDirectory, backup_base) end

        local function normalize_str(s)
            if not s then return s end
            -- 统一换行并去掉尾部空白，减少无意义差异
            s = tostring(s):gsub('\r\n', '\n')
            s = s:gsub('[ \t\n\r]+$', '')
            return s
        end

        for lang, tbl in pairs(merged_by_lang) do
            -- 先尝试备份精确命名的原始文件（如果存在）
            local orig_lua = out_dir .. lang .. '.lua'
            local orig_json = out_dir .. lang .. '.json'
            local backed = false

            if type(tbl) == 'table' then
                local content = 'return ' .. table_to_lua(tbl, '') .. '\n'
                local norm_content = normalize_str(content)
                local out_path = out_dir .. lang .. '.lua'

                -- 如果已有目标 lua 文件，比较内容（归一化后）
                if NFS.getInfo(out_path) then
                    local okr, existing = pcall(NFS.read, out_path)
                    if okr and existing then
                        if normalize_str(existing) == norm_content then
                            print(('[TEOcean Language Packs] 合并结果与现有相同，跳过写入: %s (%s)'):format(target_mod.id, lang))
                            goto skip_write
                        end
                    end
                end

                -- 若到这里表示需要写入：先备份原始文件（存在时）
                if NFS.getInfo(orig_lua) or NFS.getInfo(orig_json) then
                    if not NFS.getInfo(backup_base) then pcall(NFS.createDirectory, backup_base) end
                    if NFS.getInfo(orig_lua) then
                        local okr, raw = pcall(NFS.read, orig_lua)
                        if okr and raw then
                            local backup_path = backup_base .. lang .. '.lua'
                            if not NFS.getInfo(backup_path) then
                                pcall(NFS.write, backup_path, raw)
                                print(('[TEOcean Language Packs] 备份原始本地化: %s -> %s'):format(orig_lua, backup_path))
                                backed = true
                            else
                                print(('[TEOcean Language Packs] 备份已存在，跳过: %s'):format(backup_path))
                            end
                        end
                    end
                    if NFS.getInfo(orig_json) then
                        local okr, raw = pcall(NFS.read, orig_json)
                        if okr and raw then
                            local backup_path = backup_base .. lang .. '.json'
                            if not NFS.getInfo(backup_path) then
                                pcall(NFS.write, backup_path, raw)
                                print(('[TEOcean Language Packs] 备份原始本地化: %s -> %s'):format(orig_json, backup_path))
                                backed = true
                            else
                                print(('[TEOcean Language Packs] 备份已存在，跳过: %s'):format(backup_path))
                            end
                        end
                    end
                else
                    -- 如果没有精确文件，尝试模糊匹配备份
                    local ok_list, items = pcall(NFS.getDirectoryItems, out_dir)
                    if ok_list and items then
                        for _, fname in ipairs(items) do
                            local fname_l = fname:lower()
                            local lang_l = tostring(lang):lower()
                            if fname_l:find(lang_l, 1, true) then
                                local fpath = out_dir .. fname
                                local okr, raw = pcall(NFS.read, fpath)
                                if okr and raw then
                                    if not NFS.getInfo(backup_base) then pcall(NFS.createDirectory, backup_base) end
                                    local backup_path = backup_base .. fname
                                    if not NFS.getInfo(backup_path) then
                                        pcall(NFS.write, backup_path, raw)
                                        print(('[TEOcean Language Packs] 备份原始本地化(模糊匹配): %s -> %s'):format(fpath,
                                            backup_path))
                                        backed = true
                                    else
                                        print(('[TEOcean Language Packs] 备份已存在，跳过: %s'):format(backup_path))
                                    end
                                end
                            end
                        end
                    end
                end

                if not backed then
                    print(('[TEOcean Language Packs] 无原始本地化可备份: %s (%s)'):format(target_mod.id, lang))
                end

                -- 写入合并后的内容
                local okw, errw = pcall(NFS.write, out_path, content)
                if okw then
                    print(('[TEOcean Language Packs] 写入合并本地化: %s -> %s'):format(target_mod.id, out_path))
                    -- -- 额外保存一份带时间戳的副本，方便历史追踪
                    -- local ok_ts, err_ts
                    -- local ts = os.date('%Y%m%d%H%M%S')
                    -- local alt_path
                    -- if out_path:lower():match('%.lua$') then
                    --     alt_path = out_path:gsub('%.lua$', '_' .. ts .. '.lua')
                    -- else
                    --     alt_path = out_path .. '_' .. ts
                    -- end
                    -- ok_ts, err_ts = pcall(NFS.write, alt_path, content)
                    -- if ok_ts then
                    --     print(('[TEOcean Language Packs] 另存时间戳文件: %s'):format(alt_path))
                    -- else
                    --     print(('[TEOcean Language Packs] 另存时间戳失败: %s (%s)'):format(tostring(alt_path), tostring(err_ts)))
                    -- end
                else
                    print(('[TEOcean Language Packs] 写入失败: %s -> %s (%s)'):format(target_mod.id, out_path, tostring(errw)))
                end
                ::skip_write::
            end
        end
        ::continue::
    end
end

print('[TEOcean Language Packs] 正在合并 impl/mods 下的本地化文件...')
if mod then
    mod.process_loc_text = merge_impl_mod_localizations
    print('[TEOcean Language Packs] 已注册本地化合并函数，将在注入阶段运行')
else
    print('[TEOcean Language Packs] 当前 mod 未就绪，无法注册本地化合并函数')
end

print('[TEOcean Language Packs] 翻译mod加载完成')

-- 手动重载回调：在模组配置中调用以立即触发合并/备份/写入操作
G.FUNCS = G.FUNCS or {}
G.FUNCS.TEOcean_manual_reload = function(e)
    print('[TEOcean Language Packs] 手动重载触发')
    local ok, err = pcall(merge_impl_mod_localizations)
    if ok then
        print('[TEOcean Language Packs] 手动重载完成')
    else
        print(('[TEOcean Language Packs] 手动重载失败: %s'):format(tostring(err)))
    end
    -- 给玩家一点可见反馈（控制台日志即可）；如需弹窗，可在这里增加 UI 提示
end

if mod then
    mod.config_tab = function()
        return {
            n = G.UIT.ROOT,
            config = { align = "cm", padding = 0.05, colour = G.C.CLEAR },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm" },
                    nodes = {
                        UIBox_button({ button = 'TEOcean_manual_reload', label = { localize('teo_reload') or '手动重载(切换语言生效)' }, minw = 6 })
                    }
                }
            }
        }
    end
end
