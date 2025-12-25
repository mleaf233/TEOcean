local TEO = SMODS.current_mod

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

function merge_impl_mod_localizations(in_memory)
    if in_memory == nil or type(in_memory) ~= 'boolean' then
        in_memory = false
    end
    if not TEO or not TEO.path then return end
    local mod = TEO

    -- languages to process (原 mod 文件 + impl 覆盖)
    local langs = {}

    if G and G.SETTINGS and G.SETTINGS.language then TEO_insert_unique_first(langs, G.SETTINGS.language) end
    if G and G.SETTINGS and G.SETTINGS.real_language then TEO_insert_unique_first(langs, G.SETTINGS.real_language) end

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
            merge_single_mod_localization(target_mod, mod)
        else
            print(('[TEOcean Language Packs] 跳过未勾选 mod: %s'):format(target_mod.id))
        end
        ::continue::
    end
end

local function recurse(target, ref_table, force)
    if type(target) ~= 'table' then return end
    for k, v in pairs(target) do
        print("当前key=", k)
        if (not ref_table[k] and type(k) ~= 'number') or (force and ((type(v) ~= 'table') or type(v[1]) == 'string')) then
            ref_table[k] = v
        else
            recurse(v, ref_table[k], force)
        end
    end
end

-- 为单个mod执行本地化合并的辅助函数
function merge_single_mod_localization(target_mod, mod)
    if not mod or not mod.path then return end
    TEO_dbg_print(('[TEOcean] 开始为 %s 执行本地化操作'):format(target_mod.id))

    local langs = {} -- 默认处理的语言
    local cur_lang = G.SETTINGS.language

    if G and G.SETTINGS and G.SETTINGS.language then
        TEO_insert_unique_first(langs, G.SETTINGS.language)
    end
    if G and G.SETTINGS and G.SETTINGS.real_language then
        cur_lang = G.SETTINGS.real_language
        TEO_insert_unique_first(langs, G.SETTINGS.real_language)
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
            TEO_dbg_print('read base file', file_lua, '->', type(t), 'keys=', TEO_tbl_count(t))
        end
        if not t and NFS.getInfo(file_json) then
            t = TEO_read_loc_file(file_json)
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
                TEO_dbg_print('read impl file', file_lua, '->', type(t), 'keys=', TEO_tbl_count(t))
            end
            if not t and NFS.getInfo(file_json) then
                t = TEO_read_loc_file(file_json)
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
        TEO_dbg_print('read orig default lua', orig_default_lua, '->', type(orig_en), 'keys=', TEO_tbl_count(orig_en))
    end
    if not orig_en and NFS.getInfo(orig_en_lua) then
        orig_en = TEO_read_loc_file(orig_en_lua)
        TEO_dbg_print('read orig en lua', orig_en_lua, '->', type(orig_en), 'keys=', TEO_tbl_count(orig_en))
    end
    if not orig_en and NFS.getInfo(orig_default_json) then
        orig_en = TEO_read_loc_file(orig_default_json)
        TEO_dbg_print('read orig default json', orig_default_json, '->', type(orig_en), 'keys=', TEO_tbl_count(orig_en))
    end
    if not orig_en and NFS.getInfo(orig_en_json) then
        orig_en = TEO_read_loc_file(orig_en_json)
        TEO_dbg_print('read orig en json', orig_en_json, '->', type(orig_en), 'keys=', TEO_tbl_count(orig_en))
    end
    if orig_en and type(orig_en) == 'table' then
        local todo_root = mod.path .. 'impl/todo/'
        if not NFS.getInfo(todo_root) then pcall(NFS.createDirectory, todo_root) end
        local todo_mod_dir = todo_root .. target_mod.id .. '/'
        if not NFS.getInfo(todo_mod_dir) then pcall(NFS.createDirectory, todo_mod_dir) end
        for lang, merged_tbl in pairs(merged_by_lang) do
            -- 对每个目标语言，找出原 en 中存在但合并后缺失的键
            TEO_dbg_print('computing missing for', target_mod.id, 'lang', lang, 'orig_en_keys=', TEO_tbl_count(orig_en),
                'merged_keys=', TEO_tbl_count(merged_tbl))
            local missing = diff_table(orig_en, merged_tbl)
            if missing and next(missing) then
                local out_path = todo_mod_dir .. 'missing_' .. tostring(lang) .. '.lua'
                local content = 'return ' .. TEO_table_to_lua(missing, '') .. '\n'
                TEO_dbg_print('missing table for', target_mod.id, lang, 'top_keys=', TEO_tbl_count(missing))
                local okw, errw = pcall(NFS.write, out_path, content)
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
    if not NFS.getInfo(out_dir) then pcall(NFS.createDirectory, out_dir) end
    local backup_root = mod.path .. 'impl/backup/'
    if not NFS.getInfo(backup_root) then pcall(NFS.createDirectory, backup_root) end
    local backup_mod_dir = mod.path .. 'impl/backup/' .. target_mod.id .. '/'
    if not NFS.getInfo(backup_mod_dir) then pcall(NFS.createDirectory, backup_mod_dir) end
    local backup_base = backup_root .. target_mod.id .. '/localization/'
    if not NFS.getInfo(backup_base) then pcall(NFS.createDirectory, backup_base) end



    for lang, tbl in pairs(merged_by_lang) do
        local orig_path = out_dir .. lang .. '.lua'
        local out_path = orig_path
        local backup_path = backup_base .. lang .. '.lua'
        local content = 'return ' .. TEO_table_to_lua(tbl, '') .. '\n'

        if type(tbl) == 'table' then
            -- 先检查是否已有备份，如果没有则创建备份
            if not NFS.getInfo(backup_path) then
                -- 尝试读取原始文件进行备份
                if NFS.getInfo(orig_path) then
                    local okr, raw = pcall(NFS.read, orig_path)
                    if okr and raw and raw ~= "" then
                        -- 成功读取原始文件，写入备份
                        local okw, errw = pcall(NFS.write, backup_path, raw)
                        if okw then
                            print(('[TEOcean Language Packs] 备份原始本地化: %s -> %s'):format(orig_path, backup_path))
                        else
                            print(('[TEOcean Language Packs] 备份写入失败: %s (%s)'):format(backup_path, tostring(errw)))
                        end
                    else
                        -- 原始文件不存在或读取失败，创建空备份
                        pcall(NFS.write, backup_path, "return {}")
                        print(('[TEOcean Language Packs] 原始文件不存在或为空，创建空备份: %s'):format(backup_path))
                    end
                else
                    -- 原始文件不存在，创建空备份
                    pcall(NFS.write, backup_path, "return {}")
                    print(('[TEOcean Language Packs] 原始文件不存在，创建空备份: %s'):format(backup_path))
                end
            else
                print(('[TEOcean Language Packs] 备份已存在，跳过: %s'):format(backup_path))
            end

            -- 写入合并后的内容
            local okw, errw = pcall(NFS.write, out_path, content)
            if okw then
                print(('[TEOcean Language Packs] 写入合并本地化: %s -> %s'):format(target_mod.id, out_path))
            else
                print(('[TEOcean Language Packs] 写入失败: %s -> %s (%s)'):format(target_mod.id, out_path, tostring(errw)))
            end
        end
    end
end

-- 为单个mod恢复原始本地化
function restore_original_localization_for_mod(target_mod)
    local mod = TEO -- 使用TEO作为当前mod引用
    if not mod or not mod.path then return end

    -- languages to process
    local langs = {}
    local cur_lang = G.SETTINGS.language
    if G and G.SETTINGS and G.SETTINGS.language then
        TEO_insert_unique_first(langs, G.SETTINGS.language)
    end
    if G and G.SETTINGS and G.SETTINGS.real_language then
        cur_lang = G.SETTINGS.real_language
        TEO_insert_unique_first(langs, G.SETTINGS.real_language)
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

    for _, lang in ipairs(langs) do
        local backup_lua = backup_loc_dir .. lang .. '.lua'
        local out_path = out_dir .. lang .. '.lua'
        -- 先删除之前合并的
        if NFS.getInfo(out_path) then
            -- lang == en-us / default 不执行， 防止删除默认语言
            local ok_delete, err = pcall(NFS.remove, out_path)
            if ok_delete then
                print(('[TEOcean Language Packs] 删除合并本地化: %s'):format(out_path))
            else
                print(('[TEOcean Language Packs] 删除失败: %s (%s)'):format(out_path, tostring(err)))
            end
        end
        if NFS.getInfo(backup_lua) then
            -- 读取备份的lua文件并写入目标目录
            local ok_read, content = pcall(NFS.read, backup_lua)
            if ok_read and content then
                local ok_write, err = pcall(NFS.write, out_path, content)
                if ok_write then
                    print(('[TEOcean Language Packs] 恢复原始本地化: %s -> %s'):format(backup_lua, out_path))
                else
                    print(('[TEOcean Language Packs] 恢复失败: %s -> %s (%s)'):format(backup_lua, out_path, tostring(err)))
                end
            else
                print(('[TEOcean Language Packs] 读取备份文件失败: %s'):format(backup_lua))
            end
        end
    end
end

-- 为单个mod执行本地化合并
function merge_impl_mod_localizations_for_mod(target_mod)
    merge_single_mod_localization(target_mod, TEO)
    -- TEO_quick_reload_lang()
    -- G:set_language()
    -- G:delete_run()
    -- init_localization()
    -- G:init_item_prototypes()
    -- G:main_menu()
end
