local TEO = SMODS.current_mod

-- Source languages are reference data only. They must never be written back to
-- an adapted mod, even when the current game language is English/default.
local function TEO_is_source_language(lang)
    return lang == 'en-us' or lang == 'default'
end

local function TEO_add_writable_language(langs, lang)
    if lang and not TEO_is_source_language(lang) then
        TEO_insert_unique_first(langs, lang)
    end
end

local function diff_table(base, other)
    if type(base) ~= 'table' then return nil end
    local res = {}
    for k, v in pairs(base) do
        local ov = (type(other) == 'table') and other[k] or nil
        if type(v) == 'table' then
            -- 特例: 仅当 key 为 'text' 或 'unlock' 时应用特殊逻辑：
            -- 如果 base.text 中任意一行为非空（非 nil 且非空字符串），则认为该键不是缺失的，跳过标记。
            if TEO_DEBUG == false and (k == 'text' or k == 'unlock') then
                local has_non_empty = false
                for _, line in pairs(v) do
                    if line ~= nil and tostring(line) ~= '' then
                        has_non_empty = true
                        TEO_dbg_print('found non-empty text line (key=', k, ')->', tostring(line))
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

local function TEO_format_last_loc_error()
    if not TEO_get_last_loc_read_error then return nil end
    local err = TEO_get_last_loc_read_error()
    if not err then return nil end
    return ('stage=%s, detail=%s'):format(tostring(err.stage), tostring(err.message))
end

local function TEO_safe_create_dir(path, scene)
    if NFS.getInfo(path) then return true end
    local ok, err = TEO_fs_call(NFS.createDirectory, path)
    if not ok then
        print(('[TEOcean Language Packs] 创建目录失败[%s]: %s (%s)'):format(tostring(scene), tostring(path), tostring(err)))
        return false
    end
    return true
end

function merge_impl_mod_localizations(in_memory)
    if in_memory == nil or type(in_memory) ~= 'boolean' then
        in_memory = false
    end
    if not TEO or not TEO.path then return end
    local mod = TEO

    -- languages to process (原 mod 文件 + impl 覆盖)
    local langs = {}

    if G and G.SETTINGS and G.SETTINGS.language then TEO_add_writable_language(langs, G.SETTINGS.language) end
    if G and G.SETTINGS and G.SETTINGS.real_language then
        TEO_add_writable_language(langs, G.SETTINGS.real_language)
    end

    if #langs == 0 then
        TEO_dbg_print('[TEOcean Language Packs] 当前语言为只读源语言，跳过磁盘合并')
        return
    end

    for _, target_mod in ipairs(SMODS.mod_list or {}) do
        if not (target_mod and target_mod.id and target_mod.path) then goto continue end
        -- 检查是否在 impl/mods/<modid>/ 下存在对应文件夹
        local impl_mod_dir = mod.path .. 'impl/mods/' .. target_mod.id .. '/'
        if not NFS.getInfo(impl_mod_dir) then
            -- 跳过没有 impl 适配的 mod
            print(('[TEOcean Language Packs] 跳过未适配 mod: %s'):format(target_mod.id))
            goto continue
        end

        -- 检查该mod是否应该进行本地化合并
        -- 在SMODS.mod_list中查找对应的mod并检查should_teo_localize属性
        local should_localize = false
        if TEO.config then
            local clicked_list = mod.config.clicked_list or {}
            if clicked_list and clicked_list[target_mod.id] and clicked_list[target_mod.id] == true then
                should_localize = true
            end
        end

        -- for _, mod_entry in ipairs(TEO.config) do
        --     if mod_entry.id == target_mod.id then
        --         if mod_entry.should_teo_localize ~= nil then
        --             should_localize = mod_entry.should_teo_localize
        --         else
        --             -- 如果没有设置，则默认为false（不进行本地化合并）
        --             should_localize = false
        --         end
        --         break
        --     end
        -- end
        if should_localize == true then
            local ok_merge, err_merge = pcall(merge_single_mod_localization, target_mod, mod)
            if not ok_merge then
                print(('[TEOcean Language Packs] 本地化合并异常: %s (%s)'):format(target_mod.id, tostring(err_merge)))
            end
        else
            print(('[TEOcean Language Packs] 跳过未勾选 mod: %s'):format(target_mod.id))
        end
        ::continue::
    end
end

-- 为单个mod执行本地化合并的辅助函数
function merge_single_mod_localization(target_mod, mod)
    if not mod or not mod.path then return end
    TEO_dbg_print(('[TEOcean] 开始为 %s 执行本地化操作'):format(target_mod.id))

    local langs = {} -- 默认处理的语言
    if G and G.SETTINGS and G.SETTINGS.language then
        TEO_add_writable_language(langs, G.SETTINGS.language)
    end
    if G and G.SETTINGS and G.SETTINGS.real_language then
        TEO_add_writable_language(langs, G.SETTINGS.real_language)
    end

    if #langs == 0 then
        TEO_dbg_print(('[TEOcean] 当前语言为只读源语言，跳过 %s 的磁盘合并'):format(tostring(target_mod.id)))
        return
    end

    local merged_by_lang = {}
    -- 1) 读取并合并到目标mod的 localization 文件
    local loc_dir = target_mod.path .. 'localization/'
    for _, lang in ipairs(langs) do
        local file_lua = loc_dir .. lang .. '.lua'
        local file_json = loc_dir .. lang .. '.json' -- 兼容旧版, 优先级低于 lua, 未来可能会废弃
        local t = nil
        if NFS.getInfo(file_lua) then
            t = TEO_read_loc_file(file_lua)
            if not t then
                local detail = TEO_format_last_loc_error()
                print(('[TEOcean Language Packs] 读取目标本地化失败: mod=%s lang=%s file=%s%s'):format(
                    target_mod.id, tostring(lang), file_lua, detail and (' (' .. detail .. ')') or ''))
            end
            TEO_dbg_print('read base file', file_lua, '->', type(t), 'keys=', TEO_tbl_count(t))
        end
        if not t and NFS.getInfo(file_json) then
            t = TEO_read_loc_file(file_json)
            if not t then
                local detail = TEO_format_last_loc_error()
                print(('[TEOcean Language Packs] 读取目标本地化失败: mod=%s lang=%s file=%s%s'):format(
                    target_mod.id, tostring(lang), file_json, detail and (' (' .. detail .. ')') or ''))
            end
            TEO_dbg_print('read base file', file_json, '->', type(t), 'keys=', TEO_tbl_count(t))
        end
        if t and type(t) == 'table' then
            TEO_dbg_print('merging base loc into lang', lang, 'for', target_mod.id, 'src_keys=', TEO_tbl_count(t))
            merged_by_lang[lang] = TEO_merge_table(merged_by_lang[lang] or {}, t)
            TEO_dbg_print('merged_by_lang[' .. tostring(lang) .. '] now keys=', TEO_tbl_count(merged_by_lang[lang]))
        elseif t == nil then
            TEO_dbg_print('no base loc file for `', lang, '` in', target_mod.id,
                '. Skipping backup step.')
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
                t = TEO_read_loc_file(file_lua)
                if not t then
                    local detail = TEO_format_last_loc_error()
                    print(('[TEOcean Language Packs] 读取impl本地化失败: mod=%s lang=%s file=%s%s'):format(
                        target_mod.id, tostring(lang), file_lua, detail and (' (' .. detail .. ')') or ''))
                end
                TEO_dbg_print('read impl file', file_lua, '->', type(t), 'keys=', TEO_tbl_count(t))
            end
            if not t and NFS.getInfo(file_json) then
                t = TEO_read_loc_file(file_json)
                if not t then
                    local detail = TEO_format_last_loc_error()
                    print(('[TEOcean Language Packs] 读取impl本地化失败: mod=%s lang=%s file=%s%s'):format(
                        target_mod.id, tostring(lang), file_json, detail and (' (' .. detail .. ')') or ''))
                end
                TEO_dbg_print('read impl file', file_json, '->', type(t), 'keys=', TEO_tbl_count(t))
            end
            if t and type(t) == 'table' then
                TEO_dbg_print('merging impl loc into lang', lang, 'for', target_mod.id, 'src_keys=', TEO_tbl_count(t))
                merged_by_lang[lang] = TEO_merge_table(merged_by_lang[lang] or {}, t)
                TEO_dbg_print('merged_by_lang[' .. tostring(lang) .. '] now keys=', TEO_tbl_count(merged_by_lang[lang]))
            end
        end
    end

    -- 3) 将合并后的本地化与原 mod 的 en-us.lua/default.lua 比较，生成缺失翻译清单并保存到 impl/todo/<modid>/
    TEO_dbg_print(('[TEOcean Language Packs] 处理缺失翻译检查: %s'):format(target_mod.id))
    local orig_en = nil
    local orig_default_lua = loc_dir .. 'default.lua' -- 优先级最高
    local orig_en_lua = loc_dir .. 'en-us.lua'
    local orig_default_json = loc_dir .. 'default.json'
    local orig_en_json = loc_dir .. 'en-us.json'
    if NFS.getInfo(orig_default_lua) then
        orig_en = TEO_read_loc_file(orig_default_lua)
        if not orig_en then
            local detail = TEO_format_last_loc_error()
            print(('[TEOcean Language Packs] 读取源语言失败: mod=%s file=%s%s'):format(
                target_mod.id, orig_default_lua, detail and (' (' .. detail .. ')') or ''))
        end
        TEO_dbg_print('read orig default lua', orig_default_lua, '->', type(orig_en), 'keys=', TEO_tbl_count(orig_en))
    end
    if not orig_en and NFS.getInfo(orig_en_lua) then
        orig_en = TEO_read_loc_file(orig_en_lua)
        if not orig_en then
            local detail = TEO_format_last_loc_error()
            print(('[TEOcean Language Packs] 读取源语言失败: mod=%s file=%s%s'):format(
                target_mod.id, orig_en_lua, detail and (' (' .. detail .. ')') or ''))
        end
        TEO_dbg_print('read orig en lua', orig_en_lua, '->', type(orig_en), 'keys=', TEO_tbl_count(orig_en))
    end
    if not orig_en and NFS.getInfo(orig_default_json) then
        orig_en = TEO_read_loc_file(orig_default_json)
        if not orig_en then
            local detail = TEO_format_last_loc_error()
            print(('[TEOcean Language Packs] 读取源语言失败: mod=%s file=%s%s'):format(
                target_mod.id, orig_default_json, detail and (' (' .. detail .. ')') or ''))
        end
        TEO_dbg_print('read orig default json', orig_default_json, '->', type(orig_en), 'keys=', TEO_tbl_count(orig_en))
    end
    if not orig_en and NFS.getInfo(orig_en_json) then
        orig_en = TEO_read_loc_file(orig_en_json)
        if not orig_en then
            local detail = TEO_format_last_loc_error()
            print(('[TEOcean Language Packs] 读取源语言失败: mod=%s file=%s%s'):format(
                target_mod.id, orig_en_json, detail and (' (' .. detail .. ')') or ''))
        end
        TEO_dbg_print('read orig en json', orig_en_json, '->', type(orig_en), 'keys=', TEO_tbl_count(orig_en))
    end
    if orig_en and type(orig_en) == 'table' then
        local todo_root = mod.path .. 'impl/todo/'
        if not TEO_safe_create_dir(todo_root, 'todo_root') then return end
        local todo_mod_dir = todo_root .. target_mod.id .. '/'
        if not TEO_safe_create_dir(todo_mod_dir, 'todo_mod_dir') then return end
        for lang, merged_tbl in pairs(merged_by_lang) do
            -- 对每个目标语言，找出原 en 中存在但合并后缺失的键
            TEO_dbg_print('computing missing for', target_mod.id, 'lang', lang, 'orig_en_keys=', TEO_tbl_count(orig_en),
                'merged_keys=', TEO_tbl_count(merged_tbl))
            local missing = diff_table(orig_en, merged_tbl)
            if missing and next(missing) then
                local out_path = todo_mod_dir .. 'missing_' .. tostring(lang) .. '.lua'
                local content = 'return ' .. TEO_table_to_lua(missing, '') .. '\n'
                TEO_dbg_print('missing table for', target_mod.id, lang, 'top_keys=', TEO_tbl_count(missing))
                local okw, errw = TEO_fs_call(NFS.write, out_path, content)
                if okw then
                    print(('[TEOcean Language Packs] 生成缺失翻译: %s -> %s'):format(target_mod.id, out_path))
                else
                    print(('[TEOcean Language Packs] 写入缺失翻译失败: %s -> %s (%s)'):format(target_mod.id, out_path,
                        tostring(errw)))
                end
            end
        end
    else
        -- 如果没有原始 en-us，可选地记录一条信息
        print(('[TEOcean Language Packs] 未找到原始 default、 en-us本地化文件，跳过缺失翻译检查: %s'):format(target_mod.id))
    end

    -- 3) 将合并结果写回到目标 mod 的 localization 目录（创建目录如有必要），并先备份原始文件到 impl/backup/<modid>/localization/
    local out_dir = target_mod.path .. 'localization/'
    if not TEO_safe_create_dir(out_dir, 'target_localization_dir') then return end
    local backup_root = mod.path .. 'impl/backup/'
    if not TEO_safe_create_dir(backup_root, 'backup_root') then return end
    local backup_mod_dir = mod.path .. 'impl/backup/' .. target_mod.id .. '/'
    if not TEO_safe_create_dir(backup_mod_dir, 'backup_mod_dir') then return end
    local backup_base = backup_root .. target_mod.id .. '/localization/'
    if not TEO_safe_create_dir(backup_base, 'backup_localization_dir') then return end

    if next(merged_by_lang) == nil then
        print(('[TEOcean Language Packs] 未生成可写入的合并结果: %s'):format(target_mod.id))
    end



    for lang, tbl in pairs(merged_by_lang) do
        local orig_path = out_dir .. lang .. '.lua'
        local out_path = orig_path
        local backup_path = backup_base .. lang .. '.lua'
        local content = 'return ' .. TEO_table_to_lua(tbl, '') .. '\n'

        if type(tbl) == 'table' then
            local existing_content = nil
            if NFS.getInfo(out_path) then
                local ok_read, raw = TEO_fs_call(NFS.read, out_path)
                if ok_read then existing_content = raw end
            end

            if existing_content and TEO_normalize_str(existing_content) == TEO_normalize_str(content) then
                TEO_dbg_print('[TEOcean Language Packs] 本地化内容未变化，跳过写入:', out_path)
                goto continue_write
            end

            local backup_ready = true
            -- 先检查是否已有备份，如果没有则创建备份
            if not NFS.getInfo(backup_path) then
                -- 尝试读取原始文件进行备份
                if NFS.getInfo(orig_path) then
                    local okr, raw = TEO_fs_call(NFS.read, orig_path)
                    if okr and raw ~= nil then
                        -- 成功读取原始文件，写入备份
                        local okw, errw = TEO_fs_call(NFS.write, backup_path, raw)
                        if okw then
                            print(('[TEOcean Language Packs] 备份原始本地化: %s -> %s'):format(orig_path, backup_path))
                        else
                            backup_ready = false
                            print(('[TEOcean Language Packs] 备份写入失败: %s (%s)'):format(backup_path, tostring(errw)))
                        end
                    else
                        backup_ready = false
                        print(('[TEOcean Language Packs] 读取原始文件失败，已取消覆盖: %s'):format(orig_path))
                    end
                else
                    -- 原始文件不存在，创建空备份
                    local ok_empty, err_empty = TEO_fs_call(NFS.write, backup_path,
                        "-- TEOCEAN_ORIGINAL_FILE_MISSING\nreturn {}\n")
                    if ok_empty then
                        print(('[TEOcean Language Packs] 原始文件不存在，创建空备份: %s'):format(backup_path))
                    else
                        backup_ready = false
                        print(('[TEOcean Language Packs] 创建空备份失败: %s (%s)'):format(backup_path,
                            tostring(err_empty)))
                    end
                end
            else
                print(('[TEOcean Language Packs] 备份已存在，跳过: %s'):format(backup_path))
            end

            if not backup_ready then
                print(('[TEOcean Language Packs] 未能安全备份，跳过写入: %s'):format(out_path))
                goto continue_write
            end

            -- 写入合并后的内容
            local okw, errw = TEO_fs_call(NFS.write, out_path, content)
            if okw then
                print(('[TEOcean Language Packs] 写入合并本地化: %s -> %s'):format(target_mod.id, out_path))
            else
                print(('[TEOcean Language Packs] 写入失败: %s -> %s (%s)'):format(target_mod.id, out_path, tostring(errw)))
            end
        end
        ::continue_write::
    end
end

-- 为单个mod恢复原始本地化
function restore_original_localization_for_mod(target_mod)
    local mod = TEO -- 使用TEO作为当前mod引用
    if not mod or not mod.path then return end

    -- languages to process
    local langs = {}
    if G and G.SETTINGS and G.SETTINGS.language then
        TEO_add_writable_language(langs, G.SETTINGS.language)
    end
    if G and G.SETTINGS and G.SETTINGS.real_language then
        TEO_add_writable_language(langs, G.SETTINGS.real_language)
    end

    if #langs == 0 then
        TEO_dbg_print(('[TEOcean] 当前语言为只读源语言，跳过 %s 的本地化恢复'):format(tostring(target_mod and target_mod.id)))
        return
    end

    if not (target_mod and target_mod.id and target_mod.path) then return end
    -- 检查是否在 impl/backup/<modid>/ 下存在备份
    local backup_mod_dir = mod.path .. 'impl/backup/' .. target_mod.id .. '/'
    if not NFS.getInfo(backup_mod_dir) then
        print(('[TEOcean Language Packs] 无备份可恢复: %s'):format(target_mod.id))
        return
    end

    -- 从备份目录恢复文件
    local backup_loc_dir = backup_mod_dir .. 'localization/'
    local out_dir = target_mod.path .. 'localization/'

    if not NFS.getInfo(backup_loc_dir) then
        print(('[TEOcean Language Packs] 无备份本地化文件: %s'):format(target_mod.id))
        return
    end
    if not TEO_safe_create_dir(out_dir, 'restore_target_localization_dir') then
        return
    end

    for _, lang in ipairs(langs) do
        local backup_lua = backup_loc_dir .. lang .. '.lua'
        local out_path = out_dir .. lang .. '.lua'
        if NFS.getInfo(backup_lua) then
            local ok_read, content = TEO_fs_call(NFS.read, backup_lua)
            if ok_read and content then
                if content:find('TEOCEAN_ORIGINAL_FILE_MISSING', 1, true) then
                    if NFS.getInfo(out_path) then
                        local ok_delete, err = TEO_fs_call(NFS.remove, out_path)
                        if not ok_delete then
                            print(('[TEOcean Language Packs] 删除生成文件失败: %s (%s)'):format(out_path, tostring(err)))
                        else
                            print(('[TEOcean Language Packs] 已删除原本不存在的本地化文件: %s'):format(out_path))
                        end
                    end
                else
                    local ok_write, err = TEO_fs_call(NFS.write, out_path, content)
                    if ok_write then
                        print(('[TEOcean Language Packs] 恢复原始本地化: %s -> %s'):format(backup_lua, out_path))
                    else
                        print(('[TEOcean Language Packs] 恢复失败: %s -> %s (%s)'):format(backup_lua, out_path,
                            tostring(err)))
                    end
                end
            else
                print(('[TEOcean Language Packs] 读取备份文件失败: %s'):format(backup_lua))
            end
        else
            print(('[TEOcean Language Packs] 跳过恢复，未找到备份文件: %s'):format(backup_lua))
        end
    end
end

-- 为单个mod执行本地化合并
function merge_impl_mod_localizations_for_mod(target_mod)
    local ok, err = pcall(merge_single_mod_localization, target_mod, TEO)
    if not ok then
        local mod_id = target_mod and target_mod.id or 'unknown'
        print(('[TEOcean Language Packs] 单模组合并异常: %s (%s)'):format(tostring(mod_id), tostring(err)))
        return false, err
    end
    return true
end

-- ========================================================================================
-- 运行时本地化合并系统（内存操作，不修改磁盘文件）
-- ========================================================================================

-- 全局备份表，存储原始 G.localization 内容
TEO_localization_backup = TEO_localization_backup or {}

-- 记录当前已应用合并的 mod 列表
TEO_active_overrides = TEO_active_overrides or {}

local function runtime_deep_merge(target, source)
    if type(target) ~= 'table' or type(source) ~= 'table' then
        return TEO_deep_copy(source)
    end

    for k, v in pairs(source) do
        if type(v) == 'table' and type(target[k]) == 'table' and not TEO_is_sequence_table(v) then
            target[k] = runtime_deep_merge(target[k], v)
        else
            target[k] = TEO_deep_copy(v)
        end
    end

    return target
end

local function build_runtime_payload(data)
    local payload = {}
    for key, value in pairs(data or {}) do
        if key ~= 'translator' then
            payload[key] = TEO_deep_copy(value)
        end
    end
    return payload
end

local function capture_runtime_patch(target, patch)
    local snapshot = {}
    target = type(target) == 'table' and target or {}

    for key, patch_value in pairs(patch) do
        local current_value = target[key]
        if type(patch_value) == 'table' and type(current_value) == 'table' and
            not TEO_is_sequence_table(patch_value) then
            snapshot[key] = {
                kind = 'tree',
                value = capture_runtime_patch(current_value, patch_value)
            }
        else
            snapshot[key] = {
                kind = 'value',
                existed = current_value ~= nil,
                value = TEO_deep_copy(current_value)
            }
        end
    end

    return snapshot
end

local function restore_runtime_patch(target, snapshot)
    for key, entry in pairs(snapshot or {}) do
        if entry.kind == 'tree' then
            if type(target[key]) ~= 'table' then target[key] = {} end
            restore_runtime_patch(target[key], entry.value)
        elseif entry.existed then
            target[key] = TEO_deep_copy(entry.value)
        else
            target[key] = nil
        end
    end
end

-- 应用运行时本地化合并（单个 mod）
-- @param mod_id string mod ID
-- @param skip_init boolean 是否跳过 init_localization（批量操作时使用）
function TEO_apply_runtime_localization(mod_id, skip_init)
    if not mod_id then
        return false
    end

    -- 查找目标 mod
    local target_mod = nil
    for _, m in ipairs(SMODS.mod_list or {}) do
        if m.id == mod_id then
            target_mod = m
            break
        end
    end

    if not target_mod then
        print(('[TEOcean Runtime] 未找到 mod: %s'):format(mod_id))
        return false
    end

    local TEO_mod = TEO_get_mod()
    if not TEO_mod or not TEO_mod.path then
        print('[TEOcean Runtime] TEOcean mod 路径未找到')
        return false
    end

    -- 检查是否有对应的 impl 文件
    local lang = TEO_get_cur_language() or 'zh_CN'
    if TEO_is_source_language(lang) then
        TEO_dbg_print('[TEOcean Runtime] 当前语言为只读源语言，跳过运行时覆盖:', lang)
        return false
    end
    local impl_base = TEO_mod.path .. 'impl/mods/' .. mod_id .. '/localization/'
    local impl_file = impl_base .. lang .. '.lua'

    if not NFS.getInfo(impl_file) then
        TEO_dbg_print('[TEOcean Runtime] 未找到 impl 文件:', impl_file)
        return false
    end

    -- 读取数据
    local override_data = TEO_read_loc_file(impl_file)
    if not override_data or type(override_data) ~= 'table' then
        local detail = TEO_format_last_loc_error()
        print(('[TEOcean Runtime] 读取 impl 文件失败: %s%s'):format(
            impl_file, detail and (' (' .. detail .. ')') or ''))
        return false
    end

    local payload = build_runtime_payload(override_data)
    if not next(payload) then
        TEO_dbg_print('[TEOcean Runtime] impl 文件没有可应用的本地化内容:', impl_file)
        return false
    end

    TEO_dbg_print('[TEOcean Runtime] 开始进行合并操作:', mod_id, '语言:', lang)
    G.localization = G.localization or {}

    if not TEO_localization_backup[mod_id] then
        TEO_localization_backup[mod_id] = capture_runtime_patch(G.localization, payload)
    end

    runtime_deep_merge(G.localization, payload)

    -- 标记为已应用
    TEO_active_overrides[mod_id] = true

    -- 重新解析本地化文本（批量操作时跳过，最后统一调用）
    if not skip_init and init_localization then
        pcall(init_localization)
    end

    print(('[TEOcean Runtime] 成功应用合并操作: %s'):format(mod_id))
    return true
end

-- 移除运行时本地化覆盖（单个 mod）
function TEO_remove_runtime_localization(mod_id, skip_init)
    if not mod_id then return false end

    local backup = TEO_localization_backup[mod_id]
    if not backup then
        TEO_dbg_print('[TEOcean Runtime] 无备份数据，跳过恢复:', mod_id)
        return false
    end

    TEO_dbg_print('[TEOcean Runtime] 开始恢复原始本地化:', mod_id)

    G.localization = G.localization or {}
    restore_runtime_patch(G.localization, backup)

    -- 移除合并覆盖标记
    TEO_active_overrides[mod_id] = nil
    TEO_localization_backup[mod_id] = nil

    -- 重新解析本地化文本
    if not skip_init and init_localization then
        pcall(init_localization)
    end

    print(('[TEOcean Runtime] 成功恢复原始本地化: %s'):format(mod_id))
    return true
end

-- 批量应用运行时本地化合并操作
function TEO_apply_all_runtime_localizations(skip_init)
    local TEO_mod = TEO_get_mod()
    if not TEO_mod or not TEO_mod.config then return end

    local clicked_list = TEO_mod.config.clicked_list or {}
    local count = 0
    local changed = false

    local active_ids = {}
    for mod_id in pairs(TEO_active_overrides) do
        active_ids[#active_ids + 1] = mod_id
    end
    for _, mod_id in ipairs(active_ids) do
        if clicked_list[mod_id] ~= true and TEO_remove_runtime_localization(mod_id, true) then
            changed = true
        end
    end

    -- 批量应用时跳过每个 mod 的 init_localization
    for mod_id, is_checked in pairs(clicked_list) do
        if is_checked == true then
            if TEO_apply_runtime_localization(mod_id, true) then -- skip_init = true
                count = count + 1
                changed = true
            end
        end
    end

    -- 所有 mod 应用完成后，统一调用一次 init_localization
    if changed and not skip_init and init_localization then
        TEO_dbg_print('[TEOcean Runtime] 批量应用完成，重新初始化本地化')
        pcall(init_localization)
    end

    print(('[TEOcean Runtime] 批量应用完成，已进行合并操作 %d 个 mod'):format(count))
end

-- 批量恢复运行时本地化
function TEO_restore_all_runtime_localizations()
    local count = 0

    local active_ids = {}
    for mod_id in pairs(TEO_active_overrides) do
        active_ids[#active_ids + 1] = mod_id
    end
    for _, mod_id in ipairs(active_ids) do
        if TEO_remove_runtime_localization(mod_id, true) then
            count = count + 1
        end
    end

    if count > 0 and init_localization then
        pcall(init_localization)
    end

    print(('[TEOcean Runtime] 批量恢复完成，已恢复 %d 个 mod'):format(count))
end

-- ========================================================================================
-- 卡牌级本地化获取（集成AI翻译）
-- ========================================================================================

local function TEO_find_target_mod(mod_id)
    if not mod_id then return nil end
    for _, m in ipairs(SMODS.mod_list or {}) do
        if m.id == mod_id then
            return m
        end
    end
    return nil
end

local function TEO_find_loc_entry(loc_table, set_key, card_key)
    if type(loc_table) ~= 'table' or not set_key or not card_key then return nil end

    local candidates = TEO_get_loc_set_key_candidates and TEO_get_loc_set_key_candidates(set_key) or { set_key }
    local search_bases = {}
    if type(loc_table.descriptions) == 'table' then
        search_bases[#search_bases + 1] = loc_table.descriptions
    end
    search_bases[#search_bases + 1] = loc_table

    for _, base in ipairs(search_bases) do
        if type(base) == 'table' then
            for _, candidate_set in ipairs(candidates) do
                local category = base[candidate_set]
                local loc_entry = type(category) == 'table' and category[card_key] or nil
                local is_tree = loc_entry and TEO_loc_translation_uses_tree and TEO_loc_translation_uses_tree(loc_entry)
                if loc_entry and TEO_loc_has_content and TEO_loc_has_content(loc_entry, is_tree) then
                    return loc_entry, is_tree, candidate_set
                end
            end
        end
    end
    return nil
end

local function TEO_runtime_override_source(mod_id, set_key, card_key)
    local sources = TEO_ai_runtime_override_sources
    if type(sources) ~= 'table' or not mod_id or not set_key or not card_key then return nil end
    return sources[mod_id] and sources[mod_id][set_key] and sources[mod_id][set_key][card_key] or nil
end

--- 获取受保护的人工翻译。返回值: loc, is_tree, source.
--- source 为 impl / target / runtime.
function TEO_get_protected_manual_localization(mod_id, set_key, card_key, options)
    if not mod_id or not set_key or not card_key then return nil end

    options = options or {}
    local include_impl = options.include_impl ~= false
    local include_target_lang_file = options.include_target_lang_file ~= false
    local include_runtime = options.include_runtime ~= false
    local source_data = options.source_data
    local lang = options.lang or (TEO_get_cur_language and TEO_get_cur_language()) or 'zh_CN'

    local TEO_mod = TEO_get_mod and TEO_get_mod() or TEO
    if include_impl and TEO_mod and TEO_mod.path then
        local impl_file = TEO_mod.path .. 'impl/mods/' .. mod_id .. '/localization/' .. lang .. '.lua'
        if NFS.getInfo(impl_file) then
            local impl_data = TEO_read_loc_file(impl_file)
            local impl_loc, impl_is_tree = TEO_find_loc_entry(impl_data, set_key, card_key)
            if impl_loc then
                return impl_loc, impl_is_tree, 'impl'
            end
        end
    end

    if include_target_lang_file and not TEO_is_source_language(lang) then
        local target_mod = TEO_find_target_mod(mod_id)
        if target_mod and target_mod.path then
            local target_file = TEO_ensure_slash(target_mod.path) .. 'localization/' .. lang .. '.lua'
            if NFS.getInfo(target_file) then
                local target_data = TEO_read_loc_file(target_file)
                local target_loc, target_is_tree = TEO_find_loc_entry(target_data, set_key, card_key)
                if target_loc and not (source_data and TEO_loc_equals and TEO_loc_equals(target_loc, source_data)) then
                    return target_loc, target_is_tree, 'target'
                end
            end
        end
    end

    if include_runtime and not TEO_is_source_language(lang) and G and G.localization and G.localization.descriptions then
        local candidates = TEO_get_loc_set_key_candidates and TEO_get_loc_set_key_candidates(set_key) or { set_key }
        for _, candidate_set in ipairs(candidates) do
            local runtime_loc = G.localization.descriptions[candidate_set] and
                G.localization.descriptions[candidate_set][card_key] or nil
            local runtime_is_tree = runtime_loc and TEO_loc_translation_uses_tree and
                TEO_loc_translation_uses_tree(runtime_loc)
            if runtime_loc and TEO_loc_has_content and TEO_loc_has_content(runtime_loc, runtime_is_tree) then
                local source = TEO_runtime_override_source(mod_id, candidate_set, card_key)
                if source == 'ai' or source == 'cache' then
                    goto continue_runtime
                end
                if source == 'manual' then
                    return runtime_loc, runtime_is_tree, 'runtime'
                end
                if not (source_data and TEO_loc_equals and TEO_loc_equals(runtime_loc, source_data)) then
                    return runtime_loc, runtime_is_tree, 'runtime'
                end
            end
            ::continue_runtime::
        end
    end

    return nil
end

--- 获取卡片本地化数据，优先级：impl/mods > impl/ai > AI请求
-- @param mod_id string mod ID
-- @param set_key string set类型 (如 'Joker', 'Tarot' 等)
-- @param card_key string 卡片key
-- @return table|nil 本地化数据，如果未找到返回nil
function TEO_resolve_card_localization(mod_id, set_key, card_key)
    if not mod_id or not set_key or not card_key then return nil end

    local TEO_mod = TEO_get_mod()
    if not TEO_mod or not TEO_mod.path then return nil end

    local lang = TEO_get_cur_language() or 'zh_CN'
    local actual_set_key = TEO_resolve_actual_loc_set_key and TEO_resolve_actual_loc_set_key(set_key) or
        ((set_key == 'Booster') and 'Other' or set_key)
    local original_data = nil
    local original_is_tree = nil

    if TEO_get_original_localization then
        original_data = TEO_get_original_localization(mod_id, set_key, card_key, true, "source")
        original_is_tree = original_data and TEO_loc_translation_uses_tree and TEO_loc_translation_uses_tree(original_data)
    end

    -- 1. 检查受保护的人工翻译（impl/mods > 目标当前语言文件 > 运行时当前语言）
    if TEO_get_protected_manual_localization then
        local manual_loc, manual_is_tree, manual_source = TEO_get_protected_manual_localization(
            mod_id,
            set_key,
            card_key,
            { lang = lang, source_data = original_data }
        )
        if manual_loc then
            if TEO_dbg_print then
                TEO_dbg_print('[TEOcean AI Loc] 使用受保护的人工翻译:', manual_source, mod_id, set_key, card_key)
            end
            TEO_apply_ai_override(mod_id, set_key, card_key, manual_loc, manual_is_tree, original_data or manual_loc,
                'manual')
            return manual_loc
        end
    end

    -- 2. 检查 impl/ai AI缓存
    if TEO_get_ai_card_translation then
        local ai_cached, ai_cached_is_tree = TEO_get_ai_card_translation(mod_id, set_key, card_key)
        local ai_cached_type = type(ai_cached)
        local ai_cached_has_content = false
        if ai_cached_type == 'table' then
            ai_cached_has_content = TEO_loc_has_content and TEO_loc_has_content(ai_cached, ai_cached_is_tree)
        elseif ai_cached_type == 'string' then
            ai_cached_has_content = ai_cached ~= ""
        end
        local expected_is_tree = original_is_tree
        if expected_is_tree == nil and G and G.localization and G.localization.descriptions then
            local current_target_loc = G.localization.descriptions[actual_set_key] and
                G.localization.descriptions[actual_set_key][card_key] or nil
            expected_is_tree = current_target_loc and TEO_loc_translation_uses_tree and
                TEO_loc_translation_uses_tree(current_target_loc) or nil
        end
        local cache_shape_matches = expected_is_tree == nil or ai_cached_is_tree == expected_is_tree

        if ai_cached and ai_cached_has_content and cache_shape_matches then
            if TEO_dbg_print then
                TEO_dbg_print('[TEOcean AI Loc] 使用AI缓存:', mod_id, set_key, card_key)
            end
            -- AI缓存的数据需要应用到 G.localization
            TEO_apply_ai_override(mod_id, set_key, card_key, ai_cached, ai_cached_is_tree, original_data, 'cache')
            return ai_cached
        elseif ai_cached and ai_cached_has_content and TEO_dbg_print and expected_is_tree ~= nil and not cache_shape_matches then
            TEO_dbg_print('[TEOcean AI Loc] 跳过结构不匹配的AI缓存:', mod_id, set_key, card_key,
                ai_cached_is_tree and 'tree' or 'flat', 'expected', expected_is_tree and 'tree' or 'flat')
        end
    end

    -- 3. 检查是否启用AI翻译
    local ai_enabled = TEO_mod.config and TEO_mod.config.enable_ai_translation
    if not ai_enabled then return nil end

    -- 4. 触发AI请求（异步，不阻塞）
    -- 获取原始文本用于翻译
    if TEO_get_original_localization and TEO_request_ai_translation then
        if original_data then
            local preserve_structure = original_is_tree
            if preserve_structure == nil and G and G.localization and G.localization.descriptions then
                local target_loc = G.localization.descriptions[actual_set_key] and
                    G.localization.descriptions[actual_set_key][card_key] or nil
                preserve_structure = target_loc and TEO_loc_translation_uses_tree and
                    TEO_loc_translation_uses_tree(target_loc) or false
            end
            -- 触发异步翻译请求
            TEO_request_ai_translation(original_data, mod_id, set_key, card_key, preserve_structure, original_data)
            if TEO_dbg_print then
                TEO_dbg_print('[TEOcean AI Loc] 触发AI翻译请求:', mod_id, set_key, card_key)
            end
        end
    end
    return nil
end

print('[TEOcean] 本地化模块 加载完成')
