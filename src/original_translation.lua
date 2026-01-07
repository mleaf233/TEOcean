local TEO = SMODS.current_mod

-- 缓存已读取的原版本地化，避免重复读取文件
local original_loc_cache = {}

if not TEO then
    TEO = TEO_get_mod()
end

function TEO_get_original_localization(mod_id, loc_type, loc_key)
    local cache_key = string.format("%s:%s:%s", mod_id or "base", loc_type or "", loc_key or "")

    if original_loc_cache[cache_key] then
        TEO_dbg_print('[TEOcean] 从缓存获取原版翻译:', cache_key)
        return original_loc_cache[cache_key]
    end

    TEO_dbg_print('[TEOcean] 开始查找原版翻译. Mod:', tostring(mod_id), 'Type:', tostring(loc_type), 'Key:', tostring(loc_key))

    TEO_dbg_print('[TEOcean] 查找原版翻译 Key:', cache_key)

    local original_text = nil

    -- 如果是基础游戏内容（没有 mod_id），直接返回 nil
    if not mod_id or mod_id == "base" then
        original_loc_cache[cache_key] = nil
        return nil
    end

    local target_mod = nil
    for _, m in ipairs(SMODS.mod_list or {}) do
        if m.id == mod_id then
            target_mod = m
            break
        end
    end

    local TEO_mod = TEO_get_mod()
    if not TEO_mod or not TEO_mod.path then return nil end
    local lang = TEO_get_cur_language() or 'en-us'
    local teo_path = TEO_ensure_slash(TEO_mod.path)

    local function flexible_lookup(loc_table, c_type, c_key)
        if not loc_table or type(loc_table) ~= 'table' then
            TEO_dbg_print('[TEOcean]   - 表内容异常:', type(loc_table))
            return nil
        end


        local top_keys = {}
        for k, _ in pairs(loc_table) do table.insert(top_keys, tostring(k)) end
        TEO_dbg_print('[TEOcean]   - 表顶层 Key:', table.concat(top_keys, ', '))

        local search_bases = {}
        if loc_table.descriptions then
            TEO_dbg_print('[TEOcean]   - 找到 descriptions 层级')
            table.insert(search_bases, loc_table.descriptions)
        end
        table.insert(search_bases, loc_table)

        for i, base in ipairs(search_bases) do
            TEO_dbg_print('[TEOcean]   - 尝试在第', i, '层基础表中查找:', c_type)
            if type(base) == 'table' then
                -- 尝试匹配分类 (例如 Joker) 及其复数和大小写形式
                local cat_names = { c_type, c_type .. 's', c_type:lower(), c_type:lower() .. 's' }
                for _, cat_name in ipairs(cat_names) do
                    local category = base[cat_name]
                    if not category then
                        -- 进一步尝试在 base 中遍历查找忽略大小写的 key
                        for k, v in pairs(base) do
                            if type(k) == 'string' and k:lower() == cat_name:lower() then
                                category = v
                                break
                            end
                        end
                    end

                    if type(category) == 'table' then
                        TEO_dbg_print('[TEOcean]   - 进入分类:', cat_name)
                        -- 针对 Balatro 的多种 Key 命名习惯进行模糊匹配
                        local keys_to_try = { c_key }
                        if c_key:match('^j_') then table.insert(keys_to_try, c_key:sub(3)) end
                        if not c_key:match('^j_') and (cat_name:lower():match('joker')) then
                            table.insert(keys_to_try, 'j_' .. c_key)
                        end
                        -- 针对带 mod 前缀的 key
                        local stripped_key = c_key:match('_(.*)$')
                        if stripped_key then table.insert(keys_to_try, stripped_key) end

                        for _, try_key in ipairs(keys_to_try) do
                            local res = category[try_key]
                            if not res then
                                -- 忽略大小写的 key 匹配
                                for k, v in pairs(category) do
                                    if type(k) == 'string' and k:lower() == try_key:lower() then
                                        res = v
                                        break
                                    end
                                end
                            end

                            if res then
                                TEO_dbg_print('[TEOcean]   - !!! 找到翻译 !!!分类:', cat_name, 'Key:', try_key)
                                return res
                            end
                        end
                    end
                end
            end
        end
        TEO_dbg_print('[TEOcean]   - 未能在表中匹配到目标卡片')
        return nil
    end

    -- 1) 从备份文件读取 (原版对应语言尚未合并覆盖前的翻译)
    local backup_paths = {
        teo_path .. 'impl/backup/' .. mod_id .. '/localization/' .. lang .. '.lua'
    }

    if lang ~= 'en-us' then
        table.insert(backup_paths, teo_path .. 'impl/backup/' .. mod_id .. '/localization/en-us.lua')
    end

    for _, path in ipairs(backup_paths) do
        TEO_dbg_print('[TEOcean] 尝试读取备份:', path)
        if NFS.getInfo(path) then
            local loc_tbl = TEO_read_loc_file(path)
            if loc_tbl then
                TEO_dbg_print('[TEOcean] 成功载入备份文件内容')
                original_text = flexible_lookup(loc_tbl, loc_type, loc_key)
                if original_text then
                    TEO_dbg_print('[TEOcean] 在备份中找到目标文本!')
                    break
                end
            else
                TEO_dbg_print('[TEOcean] 警告: 备份文件載入结果为空')
            end
        else
            TEO_dbg_print('[TEOcean] 备份路径不存在')
        end
    end

    -- 2) 从 mod 原始目录读取 (回退方案)
    if not original_text and target_mod and target_mod.path then
        local target_path = target_mod.path
        if target_path:sub(-1) ~= '/' and target_path:sub(-1) ~= '\\' then
            target_path = target_path .. '/'
        end

        if lang == nil or type(lang) ~= "string" then
            lang = G.SETTINGS.language or 'en-us'
        end
        local loc_path_in_teo_impl = TEO_mod.path .. 'impl/mods/' .. target_mod.id .. '/localization/' .. lang .. '.lua'

        local src_paths = {
            loc_path_in_teo_impl, -- 优先检查 TEOcean 内部的 mod 原始本地化
            target_path .. 'localization/' .. lang .. '.lua',
            target_path .. 'localization/en-us.lua',
            target_path .. 'localization/default.lua',
        }

        for _, path in ipairs(src_paths) do
            TEO_dbg_print('[TEOcean] 尝试读取源码本地化:', path)
            if NFS.getInfo(path) then
                local loc_tbl = TEO_read_loc_file(path)
                if loc_tbl then
                    original_text = flexible_lookup(loc_tbl, loc_type, loc_key)
                    if original_text then
                        TEO_dbg_print('[TEOcean] 在源码本地化中找到目标文本!')
                        break
                    end
                end
            end
        end
    end

    original_loc_cache[cache_key] = original_text
    return original_text
end

function TEO_build_original_translation_ui(original_data, vars)
    local t = {}
    if original_data.name then
        table.insert(t,
            { { n = G.UIT.T, config = { text = original_data.name, scale = 0.4, colour = G.C.WHITE, shadow = true } } })
    end
    local function process_text_lines(lines, target_table)
        if type(lines) == 'string' then
            table.insert(target_table, lines)
        elseif type(lines) == 'table' then
            for _, part in ipairs(lines) do
                process_text_lines(part, target_table)
            end
        end
    end

    if original_data.text and type(original_data.text) == 'table' then
        local flat_lines = {}
        for _, line in ipairs(original_data.text) do
            process_text_lines(line, flat_lines)
        end

        for _, line in ipairs(flat_lines) do
            if line and line ~= "" then
                table.insert(t,
                    { { n = G.UIT.T, config = { text = line, scale = 0.32, colour = G.C.UI.TEXT_LIGHT, shadow = true } } })
            end
        end
    end

    local nodes = {}
    for k, v in ipairs(t) do
        table.insert(nodes, { n = G.UIT.R, config = { align = "cm" }, nodes = v })
    end

    local theme_color = G.C.BLACK
    local header_color = mix_colours(G.C.BLACK, G.C.ORANGE, 0.2)

    return {
        n = G.UIT.R,
        config = { align = "cm", colour = header_color, r = 0.1, padding = 0.05, emboss = 0.05 },
        nodes = {
            -- 标题栏
            {
                n = G.UIT.R,
                config = { align = "tm", minh = 0.36, padding = 0.03 },
                nodes = { { n = G.UIT.T, config = { text = localize('teo_original_tooltip') or "ORIGINAL", scale = 0.32, colour = G.C.UI.TEXT_LIGHT, shadow = true } } }
            },
            {
                n = G.UIT.R,
                config = { align = "cm", minw = 1.5, minh = 0.4, r = 0.1, padding = 0.05, colour = theme_color },
                nodes = { { n = G.UIT.R, config = { align = "cm", padding = 0.03 }, nodes = nodes } }
            }
        }
    }
end

-- Hook generate_card_ui
local generate_card_ui_ref = generate_card_ui
if not generate_card_ui_ref then
    TEO_dbg_print('[TEOcean] 警告: generate_card_ui 尚未定义，可能导致 Hook 失败或游戏崩溃')
end

function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
    local TEO_mod = TEO_get_mod()
    TEO_dbg_print('[TEOcean] generate_card_ui Hook 触发 - Key:', tostring(_c and _c.key), 'Set:', tostring(_c and _c.set))

    local result = generate_card_ui_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start,
        main_end)

    -- 关键检测：是否启用了功能
    local lang = TEO_get_cur_language() or 'en-us'

    if not TEO_mod or not TEO_mod.config or not TEO_mod.config.show_original_translation then
        return result
    end

    if lang == 'en-us' or lang == 'default' then
        return result
    end

    -- 提取关键信息
    if not _c or not _c.key or not _c.set then
        return result
    end

    -- 探测 Mod ID
    local mod_id = nil
    local detection_method = "none"
    if _c.mod and _c.mod.id then
        mod_id = _c.mod.id
        detection_method = "center.mod.id"
    elseif _c.mod_id then
        mod_id = _c.mod_id
        detection_method = "center.mod_id"
    elseif _c.key and SMODS.Centers and SMODS.Centers[_c.key] and SMODS.Centers[_c.key].mod then
        mod_id = SMODS.Centers[_c.key].mod.id
        detection_method = "SMODS.Centers.mod"
    elseif _c.config and _c.config.mod and _c.config.mod.id then
        mod_id = _c.config.mod.id
        detection_method = "center.config.mod.id"
    end

    TEO_dbg_print('[TEOcean] Mod 探测结果:', tostring(mod_id), '方式:', detection_method)

    if not mod_id or mod_id == 'base' then
        return result
    end

    TEO_dbg_print('[TEOcean] Hover!', _c.key, 'Mod:', mod_id)

    -- 获取原文数据
    local original_data = TEO_get_original_localization(mod_id, _c.set, _c.key)

    if original_data then
        TEO_dbg_print('[TEOcean] 找到原文数据，准备插入 UI. ModID:', mod_id, 'Key:', _c.key)

        local vars = specific_vars

        local target_queue = nil
        if type(result) == 'table' then
            result.info_queue = result.info_queue or {}
            target_queue = result.info_queue
        elseif type(full_UI_table) == 'table' then
            full_UI_table.info_queue = full_UI_table.info_queue or {}
            target_queue = full_UI_table.info_queue
        end

        if target_queue then
            table.insert(target_queue, {
                key = 'teo_original_' .. _c.key,
                set = 'Other',
                vars = {},
                generate_ui = function(info_queue_card)
                    TEO_dbg_print('[TEOcean] 正在渲染 info_queue 节点...')
                    return TEO_build_original_translation_ui(original_data, vars)
                end
            })
        end
    end

    return result
end

-- Hook create_UIBox_blind_popup
local create_UIBox_blind_popup_ref = create_UIBox_blind_popup
function create_UIBox_blind_popup(blind, discovered, vars)
    local result = create_UIBox_blind_popup_ref(blind, discovered, vars)

    local TEO_mod = TEO_get_mod()
    if not TEO_mod or not TEO_mod.config or not TEO_mod.config.show_original_blind_translation then
        return result
    end

    local lang = TEO_get_cur_language() or 'en-us'
    if lang == 'en-us' or lang == 'default' then
        return result
    end

    if not blind or not blind.children then return result end
    local mod_id = blind.config and blind.config.blind and blind.config.blind.mod and blind.config.blind.mod.id
    if not mod_id and blind.mod then mod_id = blind.mod.id end

    if mod_id and mod_id ~= 'base' then
        local original_data = TEO_get_original_localization(mod_id, 'Blind', blind.config.blind.key)
        if original_data then
            TEO_dbg_print('[TEOcean] 找到 Blind 原文数据:', blind.config.blind.key)
            -- 传入 vars (blind popup 的 vars 通常在调用时传入)
            table.insert(result.nodes, {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.05 },
                nodes = { TEO_build_original_translation_ui(original_data, vars) }
            })
        end
    end

    return result
end

-- Hook create_UIBox_blind_choice
local create_UIBox_blind_choice_ref = create_UIBox_blind_choice
function create_UIBox_blind_choice(type, run_info)
    local result = create_UIBox_blind_choice_ref(type, run_info)

    local TEO_mod = TEO_get_mod()
    if not TEO_mod or not TEO_mod.config or not TEO_mod.config.show_original_blind_translation then
        return result
    end

    local lang = TEO_get_cur_language() or 'en-us'
    if lang == 'en-us' or lang == 'default' then
        return result
    end

    local blind_key = G.GAME.round_resets.blind_choices[type]
    local blind = G.P_BLINDS[blind_key]

    if blind and blind.mod then
        local mod_id = blind.mod.id
        local original_data = TEO_get_original_localization(mod_id, 'Blind', blind_key)
        if original_data then
            TEO_dbg_print('[TEOcean] 找到 Blind Choice 原文数据:', blind_key)
            -- 这里 vars 不太容易获取，暂传 nil
            if result.nodes[1] and result.nodes[1].nodes[2] and result.nodes[1].nodes[2].nodes then
                table.insert(result.nodes[1].nodes[2].nodes, TEO_build_original_translation_ui(original_data))
            end
        end
    end

    return result
end

-- Hook G.UIDEF.card_h_popup
if not G.UIDEF.card_h_popup_teo_ref then
    G.UIDEF.card_h_popup_teo_ref = G.UIDEF.card_h_popup
    function G.UIDEF.card_h_popup(card)
        local ret_val = G.UIDEF.card_h_popup_teo_ref(card)

        local TEO_mod = TEO_get_mod()
        if not TEO_mod or not TEO_mod.config or not TEO_mod.config.show_original_translation then
            return ret_val
        end

        local lang = TEO_get_cur_language() or 'en-us'
        if lang == 'en-us' or lang == 'default' then
            return ret_val
        end

        -- 探测 Mod ID
        local _c = card.config.center or (card.config.tag and G.P_TAGS[card.config.tag.key])

        if not _c or not _c.key then return ret_val end

        local mod_id = nil
        if _c.mod and _c.mod.id then
            mod_id = _c.mod.id
        elseif _c.mod_id then
            mod_id = _c.mod_id
        elseif SMODS.Centers[_c.key] and SMODS.Centers[_c.key].mod then
            mod_id = SMODS.Centers[_c.key].mod.id
        elseif _c.config and _c.config.mod and _c.config.mod.id then
            mod_id = _c.config.mod.id
        end

        if not mod_id or mod_id == 'base' then return ret_val end

        local original_data = TEO_get_original_localization(mod_id, _c.set, _c.key)

        if original_data then
            -- 尝试获取 vars
            -- card.ability.extra 或者是 SMODS 提供的 loc_vars
            local vars = nil
            if card.ability and card.ability.extra and type(card.ability.extra) == 'table' then
                -- 这是一个常见的模式，但不一定准确，先不做复杂映射
            end

            -- SMODS 标准方法获取 vars
            if SMODS.Centers[_c.key] and SMODS.Centers[_c.key].loc_vars then
                -- 注意：调用 loc_vars 可能有副作用或需要特定 context，这里需谨慎
                -- 安全起见，如果 card 存在，尝试调用
                local ok, res = pcall(function()
                    return SMODS.Centers[_c.key]:loc_vars(nil, card)
                end)
                if ok and res then vars = res end
            end

            local ui_node = TEO_build_original_translation_ui(original_data, vars)

            if ret_val and ret_val.nodes then
                -- 添加一个间距
                table.insert(ret_val.nodes, { n = G.UIT.R, config = { minh = 0.05 } })
                table.insert(ret_val.nodes, ui_node)
            end
        end

        return ret_val
    end
end

print('[TEOcean] 原版翻译模块加载 (Hooked: generate_card_ui, card_h_popup, blinds)')
