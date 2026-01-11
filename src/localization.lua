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
end

-- ========================================================================================
-- 运行时本地化合并系统（内存操作，不修改磁盘文件）
-- ========================================================================================

-- 全局备份表，存储原始 G.localization 内容
TEO_localization_backup = TEO_localization_backup or {}

-- 记录当前已应用合并的 mod 列表
TEO_active_overrides = TEO_active_overrides or {}

-- 深拷贝函数（避免引用污染）
local function deep_copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end

    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res

    for k, v in pairs(obj) do
        res[deep_copy(k, s)] = deep_copy(v, s)
    end
    return res
end

-- 深度合并表（target 被 source 覆盖）
local function deep_merge(target, source)
    if type(target) ~= 'table' or type(source) ~= 'table' then
        return source
    end

    for k, v in pairs(source) do
        if type(v) == 'table' and type(target[k]) == 'table' then
            target[k] = deep_merge(target[k], v)
        else
            target[k] = deep_copy(v)
        end
    end

    return target
end

-- 识别某个 key 是否属于指定 mod
local function is_key_belongs_to_mod(key, mod_id)
    if not key or not mod_id then return false end

    -- 检查 SMODS.Centers
    if SMODS.Centers and SMODS.Centers[key] then
        local center = SMODS.Centers[key]
        if center.mod and center.mod.id == mod_id then
            return true
        end
    end

    -- 检查 G.P_CENTERS
    if G.P_CENTERS and G.P_CENTERS[key] then
        local center = G.P_CENTERS[key]
        if center.mod and center.mod.id == mod_id then
            return true
        end
    end

    return false
end

-- 备份指定 mod 的原始本地化数据
local function backup_mod_localization(mod_id)
    if TEO_localization_backup[mod_id] then
        TEO_dbg_print('[TEOcean Runtime] 备份已存在，跳过:', mod_id)
        return
    end

    TEO_dbg_print('[TEOcean Runtime] 开始备份 mod 本地化:', mod_id)

    local backup = {
        descriptions = {}
    }

    -- 备份 G.localization.descriptions 中属于该 mod 的所有条目
    if G.localization and G.localization.descriptions then
        for set_name, set_table in pairs(G.localization.descriptions) do
            if type(set_table) == 'table' then
                for key, data in pairs(set_table) do
                    if is_key_belongs_to_mod(key, mod_id) then
                        backup.descriptions[set_name] = backup.descriptions[set_name] or {}
                        backup.descriptions[set_name][key] = deep_copy(data)
                        -- TEO_dbg_print('[TEOcean Runtime] 备份:', set_name, key)
                    end
                end
            end
        end
    end

    TEO_localization_backup[mod_id] = backup
    TEO_dbg_print('[TEOcean Runtime] 备份完成:', mod_id)
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
    local impl_base = TEO_mod.path .. 'impl/mods/' .. mod_id .. '/localization/'
    local impl_file = impl_base .. lang .. '.lua'

    if not NFS.getInfo(impl_file) then
        TEO_dbg_print('[TEOcean Runtime] 未找到 impl 文件:', impl_file)
        return false
    end

    -- 首次应用时创建备份
    backup_mod_localization(mod_id)

    -- 读取数据
    local override_data = TEO_read_loc_file(impl_file)
    if not override_data or type(override_data) ~= 'table' then
        print(('[TEOcean Runtime] 读取 impl 文件失败: %s'):format(impl_file))
        return false
    end

    TEO_dbg_print('[TEOcean Runtime] 开始进行合并操作:', mod_id, '语言:', lang)

    -- 深度合并到 G.localization
    if not G.localization then
        G.localization = {}
    end

    if override_data.descriptions then
        G.localization.descriptions = G.localization.descriptions or {}
        deep_merge(G.localization.descriptions, override_data.descriptions)
    end

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
function TEO_remove_runtime_localization(mod_id)
    if not mod_id then return false end

    local backup = TEO_localization_backup[mod_id]
    if not backup then
        TEO_dbg_print('[TEOcean Runtime] 无备份数据，跳过恢复:', mod_id)
        return false
    end

    TEO_dbg_print('[TEOcean Runtime] 开始恢复原始本地化:', mod_id)

    -- 从备份中恢复
    if backup.descriptions and G.localization and G.localization.descriptions then
        for set_name, set_data in pairs(backup.descriptions) do
            if G.localization.descriptions[set_name] then
                for key, data in pairs(set_data) do
                    G.localization.descriptions[set_name][key] = deep_copy(data)
                end
            end
        end
    end

    -- 移除合并覆盖标记
    TEO_active_overrides[mod_id] = nil

    -- 重新解析本地化文本
    if init_localization then
        pcall(init_localization)
    end

    print(('[TEOcean Runtime] 成功恢复原始本地化: %s'):format(mod_id))
    return true
end

-- 批量应用运行时本地化合并操作
function TEO_apply_all_runtime_localizations()
    local TEO_mod = TEO_get_mod()
    if not TEO_mod or not TEO_mod.config then return end

    local clicked_list = TEO_mod.config.clicked_list or {}
    local count = 0

    -- 批量应用时跳过每个 mod 的 init_localization
    for mod_id, is_checked in pairs(clicked_list) do
        if is_checked == true then
            if TEO_apply_runtime_localization(mod_id, true) then -- skip_init = true
                count = count + 1
            end
        end
    end

    -- 所有 mod 应用完成后，统一调用一次 init_localization
    if count > 0 and init_localization then
        TEO_dbg_print('[TEOcean Runtime] 批量应用完成，重新初始化本地化')
        pcall(init_localization)
    end

    print(('[TEOcean Runtime] 批量应用完成，已进行合并操作 %d 个 mod'):format(count))
end

-- 批量恢复运行时本地化
function TEO_restore_all_runtime_localizations()
    local count = 0

    for mod_id, _ in pairs(TEO_active_overrides) do
        if TEO_remove_runtime_localization(mod_id) then
            count = count + 1
        end
    end

    print(('[TEOcean Runtime] 批量恢复完成，已恢复 %d 个 mod'):format(count))
end

print('[TEOcean] 运行时本地化合并系统已加载')
