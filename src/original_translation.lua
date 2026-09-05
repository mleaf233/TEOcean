local TEO = SMODS.current_mod

-- 缓存已读取的原版本地化，避免重复读取文件
local original_loc_cache = {}

if not TEO then
    TEO = TEO_get_mod()
end

function TEO_get_original_localization(mod_id, loc_type, loc_key, preserve_structure, lookup_mode)
    preserve_structure = preserve_structure == true
    lookup_mode = lookup_mode or (preserve_structure and "source" or "display")
    if lookup_mode ~= "source" then
        lookup_mode = "display"
    end

    local lang = TEO_get_cur_language() or 'en-us'
    if lang == nil or type(lang) ~= "string" then
        lang = G and G.SETTINGS and G.SETTINGS.language or 'en-us'
    end
    local cache_lang = lookup_mode == "source" and "source" or lang
    local cache_key = string.format("%s:%s:%s:%s:%s:%s", lookup_mode, mod_id or "base", cache_lang or "",
        loc_type or "", loc_key or "",
        preserve_structure and "raw" or "flat")

    if original_loc_cache[cache_key] then
        TEO_dbg_print('[TEOcean] 从缓存获取原版翻译:', cache_key)
        return original_loc_cache[cache_key]
    end

    TEO_dbg_print('[TEOcean] 开始查找原版翻译 Mod:', tostring(mod_id), 'Type:', tostring(loc_type), 'Key:', tostring(loc_key))

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
    local teo_path = TEO_ensure_slash(TEO_mod.path)
    local target_path = nil
    if target_mod and target_mod.path then
        target_path = target_mod.path
        if target_path:sub(-1) ~= '/' and target_path:sub(-1) ~= '\\' then
            target_path = target_path .. '/'
        end
    end

    local function flexible_lookup(loc_table, c_type, c_key)
        if not loc_table or type(loc_table) ~= 'table' then
            TEO_dbg_print('[TEOcean]   - 表内容异常:', type(loc_table))
            return nil
        end


        local top_keys = {}
        for k, _ in pairs(loc_table) do table.insert(top_keys, tostring(k)) end

        local search_bases = {}
        if loc_table.descriptions then
            table.insert(search_bases, loc_table.descriptions)
        end
        table.insert(search_bases, loc_table)

        for i, base in ipairs(search_bases) do
            -- TEO_dbg_print('[TEOcean]   - 尝试在第', i, '层基础表中查找:', c_type)
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

    local function lookup_loc_paths(paths, log_label, found_label)
        for _, path in ipairs(paths) do
            TEO_dbg_print('[TEOcean ' .. lookup_mode .. '] 尝试读取' .. log_label .. ':', path)
            if NFS.getInfo(path) then
                local loc_tbl = TEO_read_loc_file(path)
                if loc_tbl then
                    local found_text = flexible_lookup(loc_tbl, loc_type, loc_key)
                    if found_text then
                        TEO_dbg_print('[TEOcean ' .. lookup_mode .. '] 在' .. found_label .. '中找到目标文本!')
                        return found_text
                    end
                else
                    TEO_dbg_print('[TEOcean ' .. lookup_mode .. '] 警告: ' .. found_label .. '文件载入结果为空')
                end
            else
                TEO_dbg_print('[TEOcean ' .. lookup_mode .. '] 路径不存在:', path)
            end
        end
        return nil
    end

    if lookup_mode == "display" then
        -- UI 对照只显示当前语言的原 mod 翻译，不回退到英文。
        local backup_paths = {
            teo_path .. 'impl/backup/' .. mod_id .. '/localization/' .. lang .. '.lua'
        }
        original_text = lookup_loc_paths(backup_paths, '原版翻译备份', '原版翻译备份')

        if not original_text and target_path then
            local current_lang_paths = {
                target_path .. 'localization/' .. lang .. '.lua'
            }
            original_text = lookup_loc_paths(current_lang_paths, '目标当前语言本地化', '目标当前语言本地化')
        end
    else
        -- AI 源文本优先使用英文/default，不读取当前语言翻译。
        if target_path then
            local source_paths = {
                target_path .. 'localization/en-us.lua',
                target_path .. 'localization/default.lua',
            }
            original_text = lookup_loc_paths(source_paths, 'AI 源文本', 'AI 源文本')
        end

        if not original_text then
            local backup_source_paths = {
                teo_path .. 'impl/backup/' .. mod_id .. '/localization/en-us.lua',
                teo_path .. 'impl/backup/' .. mod_id .. '/localization/default.lua',
            }
            original_text = lookup_loc_paths(backup_source_paths, 'AI 源文本备份', 'AI 源文本备份')
        end
    end

    if lookup_mode == "source" then
        -- 3) 从 SMODS.Centers 读取内联的 loc_txt (AI 源文本回退)
        -- 适用于像 Bloonlatro 这样直接在代码中定义 loc_txt 的 mod
        if not original_text and loc_key and SMODS.Centers and SMODS.Centers[loc_key] then
            local center = SMODS.Centers[loc_key]
            if center.loc_txt then
                TEO_dbg_print('[TEOcean source] 从 SMODS.Centers 读取内联 loc_txt:', loc_key)
                original_text = center.loc_txt
            end
        end

        -- 4) 对于 Blind 类型，额外尝试从 G.P_BLINDS 读取
        if not original_text and loc_type == 'Blind' and G and G.P_BLINDS and G.P_BLINDS[loc_key] then
            local blind_obj = G.P_BLINDS[loc_key]
            if blind_obj.loc_txt then
                TEO_dbg_print('[TEOcean source] 从 G.P_BLINDS 读取内联 loc_txt:', loc_key)
                original_text = blind_obj.loc_txt
            elseif blind_obj.name and type(blind_obj.name) == 'table' then
                -- 有些 blind 直接在 name 字段存储本地化数据
                TEO_dbg_print('[TEOcean source] 从 G.P_BLINDS.name 读取内联本地化:', loc_key)
                original_text = { name = blind_obj.name, text = blind_obj.text }
            end
        end

        -- 5) 对于 Tag 类型，额外尝试从 G.P_TAGS 或 SMODS.Tags 读取
        if not original_text and loc_type == 'Tag' then
            -- 首先尝试 G.P_TAGS（游戏运行时标签表）
            if G and G.P_TAGS and G.P_TAGS[loc_key] then
                local tag_obj = G.P_TAGS[loc_key]
                if tag_obj.loc_txt then
                    TEO_dbg_print('[TEOcean source] 从 G.P_TAGS 读取内联 loc_txt:', loc_key)
                    original_text = tag_obj.loc_txt
                end
            end
            -- 如果 G.P_TAGS 未找到，尝试 SMODS.Tags
            if not original_text and SMODS and SMODS.Tags and SMODS.Tags[loc_key] then
                local tag_obj = SMODS.Tags[loc_key]
                if tag_obj.loc_txt then
                    TEO_dbg_print('[TEOcean source] 从 SMODS.Tags 读取内联 loc_txt:', loc_key)
                    original_text = tag_obj.loc_txt
                end
            end
        end

        -- 6) 对于 Sticker 类型（显示为 Other set），额外尝试从 SMODS.Stickers 读取
        if not original_text and loc_type == 'Other' and SMODS and SMODS.Stickers and SMODS.Stickers[loc_key] then
            local sticker_obj = SMODS.Stickers[loc_key]
            if sticker_obj.loc_txt then
                TEO_dbg_print('[TEOcean source] 从 SMODS.Stickers 读取内联 loc_txt:', loc_key)
                original_text = sticker_obj.loc_txt
            elseif sticker_obj.name then
                -- 有些 sticker 使用 name 字段存储英文名称（字符串）
                -- 构造标准的本地化数据格式
                TEO_dbg_print('[TEOcean source] 从 SMODS.Stickers.name 读取内联本地化:', loc_key, sticker_obj.name)
                original_text = { name = sticker_obj.name, text = sticker_obj.text or {} }
            end
        end

        -- 7) 对于 Seal 类型（显示为 Other set，key 以 _seal 结尾），尝试从 G.P_SEALS 或 SMODS.Seals 读取
        if not original_text and loc_type == 'Other' and string.sub(loc_key, -5) == '_seal' then
            -- 尝试 G.P_SEALS（游戏运行时表）
            if G and G.P_SEALS then
                -- Seal 的 key 存储时不带 _seal 后缀，需要去掉
                local seal_key_base = string.sub(loc_key, 1, -6)  -- 去掉 '_seal'
                local seal_obj = G.P_SEALS[seal_key_base]
                if seal_obj then
                    if seal_obj.loc_txt then
                        TEO_dbg_print('[TEOcean source] 从 G.P_SEALS 读取内联 loc_txt:', loc_key)
                        original_text = seal_obj.loc_txt
                    elseif seal_obj.key and SMODS.Seals and SMODS.Seals[seal_obj.key] then
                        -- 如果 G.P_SEALS 没有 loc_txt，尝试从 SMODS.Seals 读取
                        local s_mod_seal = SMODS.Seals[seal_obj.key]
                        if s_mod_seal and s_mod_seal.loc_txt then
                            TEO_dbg_print('[TEOcean source] 从 SMODS.Seals 读取内联 loc_txt:', loc_key)
                            original_text = s_mod_seal.loc_txt
                        end
                    end
                end
            end
            -- 如果 G.P_SEALS 未找到，尝试直接从 SMODS.Seals 读取
            if not original_text and SMODS and SMODS.Seals then
                for seal_key, seal_obj in pairs(SMODS.Seals) do
                    -- 检查 key 是否匹配（seal_key + '_seal' == loc_key）
                    if seal_key and seal_key:lower() .. '_seal' == loc_key then
                        if seal_obj.loc_txt then
                            TEO_dbg_print('[TEOcean source] 从 SMODS.Seals 读取内联 loc_txt:', loc_key)
                            original_text = seal_obj.loc_txt
                            break
                        end
                    end
                end
            end
            -- 如果仍然没有找到，使用 key 生成默认英文名称
            if not original_text and loc_key then
                local seal_name = string.sub(loc_key, 1, -6)  -- 去掉 '_seal'
                seal_name = seal_name:gsub("^%l", string.upper)  -- 首字母大写
                TEO_dbg_print('[TEOcean source] Seal 无 loc_txt，使用默认名称:', loc_key, seal_name)
                original_text = { name = seal_name .. " Seal", text = {} }
            end
        end

        -- 8) 对于 Back 类型（卡背牌组），尝试从 G.P_CENTERS 读取
        if not original_text and loc_type == 'Back' then
            -- Back 对象存储在 G.P_CENTERS 中
            if G and G.P_CENTERS and G.P_CENTERS[loc_key] then
                local back_obj = G.P_CENTERS[loc_key]
                if back_obj.loc_txt then
                    TEO_dbg_print('[TEOcean source] 从 G.P_CENTERS 读取 Back loc_txt:', loc_key)
                    original_text = back_obj.loc_txt
                elseif back_obj.name and type(back_obj.name) == 'string' then
                    -- 如果没有 loc_txt，尝试直接使用 name 和 text 字段
                    TEO_dbg_print('[TEOcean source] 从 G.P_CENTERS.name 读取 Back 本地化:', loc_key, back_obj.name)
                    original_text = { name = back_obj.name, text = back_obj.text or {} }
                end
            end
            -- 如果 G.P_CENTERS 未找到，尝试从 SMODS.Centers 读取（再次检查，因为 Back 是 Center 的子类）
            if not original_text and SMODS and SMODS.Centers and SMODS.Centers[loc_key] then
                local center = SMODS.Centers[loc_key]
                if center.loc_txt then
                    TEO_dbg_print('[TEOcean source] 从 SMODS.Centers 读取 Back loc_txt:', loc_key)
                    original_text = center.loc_txt
                elseif center.name and type(center.name) == 'string' then
                    TEO_dbg_print('[TEOcean source] 从 SMODS.Centers.name 读取 Back 本地化:', loc_key, center.name)
                    original_text = { name = center.name, text = center.text or {} }
                end
            end
            -- 如果仍然没有找到，使用 key 生成默认英文名称
            if not original_text and loc_key then
                local back_name = loc_key:gsub("^%l", string.upper)  -- 首字母大写
                TEO_dbg_print('[TEOcean source] Back 无 loc_txt，使用默认名称:', loc_key, back_name)
                original_text = { name = back_name .. " Deck", text = {} }
            end
        end
    end

    if preserve_structure then
        original_loc_cache[cache_key] = original_text
        return original_text
    end

    -- 数据规范化：确保返回的数据格式安全
    if original_text and type(original_text) == 'table' then
        local normalized = {}

        -- 确保 name 是字符串
        if original_text.name then
            if type(original_text.name) == 'string' then
                normalized.name = original_text.name
            elseif type(original_text.name) == 'table' then
                -- 如果 name 是 table，提取文本
                local name_parts = {}
                local function extract_name(t)
                    if type(t) == 'string' then
                        table.insert(name_parts, t)
                    elseif type(t) == 'table' then
                        if #t > 0 then
                            for i = 1, #t do
                                extract_name(t[i])
                            end
                        else
                            for _, v in pairs(t) do
                                extract_name(v)
                            end
                        end
                    end
                end
                extract_name(original_text.name)
                normalized.name = table.concat(name_parts, " ")
            else
                normalized.name = tostring(original_text.name)
            end
        end

        -- 确保 text 是字符串数组
        if original_text.text then
            if type(original_text.text) == 'string' then
                normalized.text = { original_text.text }
            elseif type(original_text.text) == 'table' then
                normalized.text = {}
                local function extract_text(t, target)
                    if type(t) == 'string' then
                        table.insert(target, t)
                    elseif type(t) == 'table' then
                        if #t > 0 then
                            for i = 1, #t do
                                extract_text(t[i], target)
                            end
                        else
                            -- 可能是嵌套的控制结构，尝试展平
                            for _, v in pairs(t) do
                                if type(v) == 'string' then
                                    table.insert(target, v)
                                elseif type(v) == 'table' then
                                    extract_text(v, target)
                                end
                            end
                        end
                    elseif t ~= nil then
                        table.insert(target, tostring(t))
                    end
                end
                extract_text(original_text.text, normalized.text)
            end
        end

        -- 保留其他字段
        for k, v in pairs(original_text) do
            if k ~= 'name' and k ~= 'text' then
                normalized[k] = v
            end
        end

        original_text = normalized
    end

    original_loc_cache[cache_key] = original_text
    return original_text
end

function TEO_build_original_translation_ui(original_data, vars, title_key)
    title_key = title_key or 'teo_original_tooltip'
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
                nodes = { { n = G.UIT.T, config = { text = localize(title_key) or "ORIGINAL", scale = 0.32, colour = G.C.UI.TEXT_LIGHT, shadow = true } } }
            },
            {
                n = G.UIT.R,
                config = { align = "cm", minw = 1.5, minh = 0.4, r = 0.1, padding = 0.05, colour = theme_color },
                nodes = { { n = G.UIT.R, config = { align = "cm", padding = 0.03 }, nodes = nodes } }
            }
        }
    }
end

-- 探测卡牌所属 mod 的 id（兼容多种命名习惯）
local function TEO_detect_center_mod_id(_c)
    if _c.mod and _c.mod.id then return _c.mod.id end
    if _c.mod_id then return _c.mod_id end
    if _c.key and SMODS.Centers and SMODS.Centers[_c.key] and SMODS.Centers[_c.key].mod then
        return SMODS.Centers[_c.key].mod.id
    end
    if _c.config and _c.config.mod and _c.config.mod.id then return _c.config.mod.id end
    return nil
end

-- 构建卡牌"原版翻译" info_queue 条目列表（SMODS 延迟渲染机制）：
--   启用开关（enabled）时生成：
--   1) 英文原版（source 模式：目标 mod 的 en-us.lua / default.lua，始终尝试显示）
--   2) 当前语言原版（display 模式：备份/目标mod当前语言，按需显示）
-- 各条目找不到对应文本就不生成（"没有就不显示"）
local function TEO_original_info_queue_entries(mod_id, loc_type, loc_key, vars, enabled)
    local entries = {}
    if not enabled then return entries end
    local en_data = TEO_get_original_localization(mod_id, loc_type, loc_key, false, "source")
    if en_data then
        entries[#entries + 1] = {
            key = 'teo_original_en_' .. loc_key,
            set = 'Other',
            vars = {},
            generate_ui = function(info_queue_card)
                return TEO_build_original_translation_ui(en_data, vars, 'teo_original_en_tooltip')
            end
        }
    end
    local display_data = TEO_get_original_localization(mod_id, loc_type, loc_key, false, "display")
    if display_data then
        entries[#entries + 1] = {
            key = 'teo_original_' .. loc_key,
            set = 'Other',
            vars = {},
            generate_ui = function(info_queue_card)
                return TEO_build_original_translation_ui(display_data, vars)
            end
        }
    end
    return entries
end

-- 构建可直接插入的"原版翻译" UI 节点列表（用于 card_h_popup / 盲注弹窗）
--   启用开关（enabled）时生成：英文原版（始终尝试） + 当前语言原版（按需）
local function TEO_original_ui_nodes(mod_id, loc_type, loc_key, vars, enabled)
    local nodes = {}
    if not enabled then return nodes end
    local en_data = TEO_get_original_localization(mod_id, loc_type, loc_key, false, "source")
    if en_data then
        nodes[#nodes + 1] = { n = G.UIT.R, config = { minh = 0.05 } }
        nodes[#nodes + 1] = TEO_build_original_translation_ui(en_data, vars, 'teo_original_en_tooltip')
    end
    local display_data = TEO_get_original_localization(mod_id, loc_type, loc_key, false, "display")
    if display_data then
        nodes[#nodes + 1] = { n = G.UIT.R, config = { minh = 0.05 } }
        nodes[#nodes + 1] = TEO_build_original_translation_ui(display_data, vars)
    end
    return nodes
end

-- ============ 按 H 临时隐藏原版翻译框（与故事同款） ============

-- 隐藏状态标志（重新悬停卡牌后恢复显示）
TEO._original_hidden = false

-- 重建当前悬停弹窗（隐藏时移除原版翻译框）
local function rebuild_hover_popup(target)
    if not target or target.REMOVED then return end
    TEO_suspend_ai_resolve = true
    local ok, err = pcall(function()
        if target.generate_UIBox_ability_table then
            target.ability_UIBox_table = target:generate_UIBox_ability_table()
        end
        if target.config then
            target.config.h_popup = G.UIDEF.card_h_popup(target)
            if target.align_h_popup then
                target.config.h_popup_config = target:align_h_popup()
            end
        end
        if target.children and target.children.h_popup then
            target.children.h_popup:remove()
            target.children.h_popup = nil
        end
        Node.hover(target)
    end)
    TEO_suspend_ai_resolve = false
    if not ok then
        print('[TEOcean 原版翻译] 弹窗重建异常:', tostring(err))
    end
end

-- 每帧处理：按 H 临时隐藏原版翻译框（重新悬停卡牌后恢复显示）
local function original_update(dt)
    local controller = G and G.CONTROLLER
    local target = controller and controller.hovering and controller.hovering.target

    -- 悬停目标变化（含移开鼠标）→ 清除隐藏状态，下次悬停恢复显示
    if TEO._original_last_hover_target ~= target then
        TEO._original_last_hover_target = target
        TEO._original_hidden = false
    end

    if not target or TEO._original_hidden then return end

    -- 按 H：临时隐藏原版翻译框（重建弹窗移除它）
    local pressed = controller.pressed_keys and controller.pressed_keys['h']
    if pressed then
        TEO._original_hidden = true
        rebuild_hover_popup(target)
    end
end

-- 确保 Game.update 已被包装（链式、幂等，与 story 等其它模块的包装互不干扰）。
-- 若加载时 Game 不可用，将在首次悬停（ensure_original_update_hook）时补挂。
local function ensure_original_update_hook()
    if Game and Game.update and not TEO._original_update_hooked then
        TEO._original_update_hooked = true
        local original_update_ref = Game.update
        Game.update = function(self, dt)
            local ok, err = pcall(original_update, dt)
            if not ok then
                print('[TEOcean 原版翻译] 更新异常:', tostring(err))
            end
            return original_update_ref(self, dt)
        end
        print('[TEOcean 原版翻译] 更新钩子已激活')
    end
end

-- 挂到 Game.update（若加载时 Game 不可用，首次悬停时由 hook 补挂）
ensure_original_update_hook()

-- Hook generate_card_ui
local generate_card_ui_ref = generate_card_ui
if not generate_card_ui_ref then
    TEO_dbg_print('[TEOcean] 警告: generate_card_ui 尚未定义，可能导致 Hook 失败或游戏崩溃')
end

function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    -- 跳过非卡牌对象 - 在调用原函数之前检查
    if not _c or type(_c) ~= 'table' or not _c.key or not _c.set then
        return generate_card_ui_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    end

    TEO_dbg_print('[TEOcean] generate_card_ui Hook 触发 - Key:', tostring(_c.key), 'Set:', tostring(_c.set))

    local result = generate_card_ui_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start,
        main_end, card)

    -- 仅非英文语言下生效：
    --   show_original_translation 启用时：英文原版始终尝试显示 + 当前语言原版按需显示
    --   关闭时：两者都不显示
    local TEO_mod = TEO_get_mod()
    local enabled = TEO_mod and TEO_mod.config and TEO_mod.config.show_original_translation
    local lang = TEO_get_cur_language() or 'en-us'
    if lang ~= 'en-us' and lang ~= 'default' then
        local mod_id = TEO_detect_center_mod_id(_c)
        TEO_dbg_print('[TEOcean] generate_card_ui ModID 探测结果:', tostring(mod_id), 'Key:', tostring(_c.key))

        if mod_id and mod_id ~= 'base' then
            -- 按 H 临时隐藏期间（TEO._original_hidden）不插入原版翻译条目
            ensure_original_update_hook()
            if TEO._original_hidden then
                return result
            end
            local entries = TEO_original_info_queue_entries(mod_id, _c.set, _c.key, specific_vars, enabled)
            if #entries > 0 then
                local target_queue = nil
                if type(result) == 'table' then
                    result.info_queue = result.info_queue or {}
                    target_queue = result.info_queue
                elseif type(full_UI_table) == 'table' then
                    full_UI_table.info_queue = full_UI_table.info_queue or {}
                    target_queue = full_UI_table.info_queue
                end

                if target_queue then
                    for _, entry in ipairs(entries) do
                        table.insert(target_queue, entry)
                    end
                end
            end
        end
    end

    return result
end

-- Hook create_UIBox_blind_popup
local create_UIBox_blind_popup_ref = create_UIBox_blind_popup
function create_UIBox_blind_popup(blind, discovered, vars)
    local result = create_UIBox_blind_popup_ref(blind, discovered, vars)

    local TEO_mod = TEO_get_mod()
    local enabled = TEO_mod and TEO_mod.config and TEO_mod.config.show_original_blind_translation
    local lang = TEO_get_cur_language() or 'en-us'
    if lang == 'en-us' or lang == 'default' then return result end
    if not result or not result.nodes then return result end
    if not blind or not blind.children then return result end

    local mod_id = blind.config and blind.config.blind and blind.config.blind.mod and blind.config.blind.mod.id
    if not mod_id and blind.mod then mod_id = blind.mod.id end
    local blind_key = blind.config and blind.config.blind and blind.config.blind.key

    if mod_id and mod_id ~= 'base' and blind_key then
        local nodes = TEO_original_ui_nodes(mod_id, 'Blind', blind_key, vars, enabled)
        if #nodes > 0 then
            for _, node in ipairs(nodes) do
                table.insert(result.nodes, node)
            end
        end
    end

    return result
end

-- Hook create_UIBox_blind_choice
local create_UIBox_blind_choice_ref = create_UIBox_blind_choice
function create_UIBox_blind_choice(type, run_info)
    local result = create_UIBox_blind_choice_ref(type, run_info)

    local TEO_mod = TEO_get_mod()
    local enabled = TEO_mod and TEO_mod.config and TEO_mod.config.show_original_blind_translation
    local lang = TEO_get_cur_language() or 'en-us'
    if lang == 'en-us' or lang == 'default' then return result end

    local blind_key = G.GAME.round_resets.blind_choices[type]
    local blind = G.P_BLINDS[blind_key]

    if blind and blind.mod then
        local mod_id = blind.mod.id
        if mod_id and mod_id ~= 'base' then
            local nodes = TEO_original_ui_nodes(mod_id, 'Blind', blind_key, nil, enabled)
            if #nodes > 0 and result.nodes[1] and result.nodes[1].nodes[2] and result.nodes[1].nodes[2].nodes then
                for _, node in ipairs(nodes) do
                    table.insert(result.nodes[1].nodes[2].nodes, node)
                end
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
        local enabled = TEO_mod and TEO_mod.config and TEO_mod.config.show_original_translation
        local lang = TEO_get_cur_language() or 'en-us'
        if ret_val and ret_val.nodes and lang ~= 'en-us' and lang ~= 'default' then
            local _c = card.config.center or (card.config.tag and G.P_TAGS[card.config.tag.key])

            if _c and _c.key then
                local mod_id = TEO_detect_center_mod_id(_c)
                if mod_id and mod_id ~= 'base' then
                    -- 按 H 临时隐藏期间（TEO._original_hidden）不追加原版翻译面板
                    if TEO._original_hidden then
                        return ret_val
                    end
                    local nodes = TEO_original_ui_nodes(mod_id, _c.set, _c.key, nil, enabled)
                    for _, node in ipairs(nodes) do
                        table.insert(ret_val.nodes, node)
                    end
                    -- 确保按 H 隐藏的更新钩子已激活（首次悬停时补挂）
                    ensure_original_update_hook()
                end
            end
        end

        return ret_val
    end
end

print('[TEOcean] 原版翻译模块加载 (Hooked: generate_card_ui, card_h_popup, blinds)')
