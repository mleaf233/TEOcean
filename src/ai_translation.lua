-- AI Translation UI logic
-- 功能：Hook 游戏 UI 函数，仅用于检测并触发后台翻译请求
-- 不再直接注入 UI，而是等待 ai_manager 更新 G.localization

-- Hook generate_card_ui
-- 检查当前卡牌是否已翻译/已请求，如果未请求则发起请求
local generate_card_ui_ai_ref = generate_card_ui

local function TEO_debug_loc_lines(value, lines)
    lines = lines or {}
    if type(value) == 'string' then
        lines[#lines + 1] = value
        return lines
    end
    if type(value) == 'number' or type(value) == 'boolean' then
        lines[#lines + 1] = tostring(value)
        return lines
    end
    if type(value) ~= 'table' then
        return lines
    end

    if #value > 0 then
        local only_scalars = true
        for i = 1, #value do
            if type(value[i]) == 'table' then
                only_scalars = false
                break
            end
        end

        if only_scalars then
            local parts = {}
            for i = 1, #value do
                parts[#parts + 1] = tostring(value[i] or "")
            end
            lines[#lines + 1] = table.concat(parts, " ")
            return lines
        end

        for i = 1, #value do
            TEO_debug_loc_lines(value[i], lines)
        end
    end
    return lines
end

local function TEO_append_debug_loc_text(debug_text, label, value)
    local lines = TEO_debug_loc_lines(value, {})
    if #lines == 0 then
        table.insert(debug_text, label .. ": " .. tostring(value))
        return
    end

    for i = 1, #lines do
        local prefix = (i == 1) and (label .. ": ") or (label .. "[" .. i .. "]: ")
        table.insert(debug_text, prefix .. tostring(lines[i]))
    end
end

function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    -- 跳过非卡牌对象 - 在调用原函数之前检查
    if not _c or type(_c) ~= 'table' or not _c.key or not _c.set then
        return generate_card_ui_ai_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    end

    local TEO_mod = TEO_get_mod()
    local ai_enabled = TEO_mod and TEO_mod.config and TEO_mod.config.enable_ai_translation

    -- 探测 Mod ID
    local mod_id = nil
    if _c.mod and _c.mod.id then
        mod_id = _c.mod.id
    elseif _c.mod_id then
        mod_id = _c.mod_id
    elseif SMODS.Centers[_c.key] and SMODS.Centers[_c.key].mod then
        mod_id = SMODS.Centers[_c.key].mod.id
    elseif _c.config and _c.config.mod and _c.config.mod.id then
        mod_id = _c.config.mod.id
    elseif _c.set == 'Other' and SMODS.Stickers and SMODS.Stickers[_c.key] and SMODS.Stickers[_c.key].mod then
        mod_id = SMODS.Stickers[_c.key].mod.id
    elseif _c.set == 'Other' and string.sub(_c.key or '', -5) == '_seal' then
        -- 对于 Seal 类型（key 以 _seal 结尾），尝试从 G.P_SEALS 或 SMODS.Seals 获取 Mod ID
        local seal_key_base = string.sub(_c.key, 1, -6)  -- 去掉 '_seal'
        if G and G.P_SEALS and G.P_SEALS[seal_key_base] and G.P_SEALS[seal_key_base].mod then
            mod_id = G.P_SEALS[seal_key_base].mod.id
        elseif SMODS and SMODS.Seals and SMODS.Seals[seal_key_base] and SMODS.Seals[seal_key_base].mod then
            mod_id = SMODS.Seals[seal_key_base].mod.id
        end
    elseif _c.set == 'Back' and G and G.P_CENTERS and G.P_CENTERS[_c.key] and G.P_CENTERS[_c.key].mod then
        -- 对于 Back 类型（卡背牌组），从 G.P_CENTERS 获取 Mod ID
        mod_id = G.P_CENTERS[_c.key].mod.id
    end

    if mod_id and mod_id ~= 'base' and TEO_set_last_hovered_translation_target then
        TEO_set_last_hovered_translation_target(mod_id, _c.set, _c.key, _c.name or _c.key)
    end

    -- 在原函数调用之前触发 AI 翻译，确保 G.localization 已更新
    if ai_enabled and mod_id and mod_id ~= 'base' and not TEO_suspend_ai_resolve then
        if TEO_resolve_card_localization then
            TEO_resolve_card_localization(mod_id, _c.set, _c.key)
        end
    end

    -- 1. 执行原逻辑（此时 G.localization 已更新）
    local result = generate_card_ui_ai_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start,
        main_end, card)

    -- Debug: 输出当前显示的翻译文本
    if TEO_DEBUG == true and G.localization and G.localization.descriptions then
        local loc_data = G.localization.descriptions[_c.set] and
            G.localization.descriptions[_c.set][_c.key]
        if loc_data then
            local debug_text = {}
            if loc_data.name then
                TEO_append_debug_loc_text(debug_text, "Name", loc_data.name)
            end
            if loc_data.text then
                TEO_append_debug_loc_text(debug_text, "Text", loc_data.text)
            end
            TEO_dbg_print(string.format("[TEOcean AI Debug] Card hover: %s.%s.%s\n%s",
                mod_id or 'unknown', _c.set, _c.key, table.concat(debug_text, "\n")))
        end
    end

    return result
end

-- Hook create_UIBox_blind_popup for AI translation
local create_UIBox_blind_popup_ai_ref = create_UIBox_blind_popup
function create_UIBox_blind_popup(blind, discovered, vars)
    local TEO_mod = TEO_get_mod()
    local ai_enabled = TEO_mod and TEO_mod.config and TEO_mod.config.enable_ai_translation

    -- 探测 Mod ID 和盲注key
    local mod_id = nil
    local blind_key = nil

    if blind then
        blind_key = blind.key
        mod_id = blind.mod and blind.mod.id
    end

    if mod_id and mod_id ~= 'base' and blind_key and TEO_set_last_hovered_translation_target then
        TEO_set_last_hovered_translation_target(mod_id, 'Blind', blind_key, blind.name or blind_key)
    end

    -- 在原函数调用之前触发AI翻译（因为原函数会通过localize()读取G.localization）
    if ai_enabled and mod_id and mod_id ~= 'base' and blind_key and not TEO_suspend_ai_resolve then
        if TEO_resolve_card_localization then
            TEO_resolve_card_localization(mod_id, 'Blind', blind_key)
        end
    end

    -- 执行原逻辑（此时G.localization可能已被更新）
    local result = create_UIBox_blind_popup_ai_ref(blind, discovered, vars)

    -- Debug: 输出当前显示的盲注翻译文本
    if TEO_DEBUG == true and G.localization and G.localization.descriptions then
        local loc_data = G.localization.descriptions.Blind and
            G.localization.descriptions.Blind[blind_key]
        if loc_data then
            local debug_text = {}
            if loc_data.name then
                TEO_append_debug_loc_text(debug_text, "Name", loc_data.name)
            end
            if loc_data.text then
                TEO_append_debug_loc_text(debug_text, "Text", loc_data.text)
            end
            TEO_dbg_print(string.format("[TEOcean AI Debug] Blind hover: %s.Blind.%s\n%s",
                mod_id or 'unknown', blind_key or 'unknown', table.concat(debug_text, "\n")))
        end
    end

    return result
end

-- Hook G.FUNCS.change_viewed_back for Back AI translation
-- 当用户在收藏界面切换卡背时触发
local change_viewed_back_ref = nil
local function hook_change_viewed_back()
    if not change_viewed_back_ref and G.FUNCS and G.FUNCS.change_viewed_back then
        change_viewed_back_ref = G.FUNCS.change_viewed_back
        G.FUNCS.change_viewed_back = function(args)
            local TEO_mod = TEO_get_mod()
            local ai_enabled = TEO_mod and TEO_mod.config and TEO_mod.config.enable_ai_translation

            -- 在原函数调用之前触发AI翻译
            if ai_enabled and args and args.to_key then
                -- 获取目标 Back 对象
                local deck_pool = SMODS.collection_pool(G.P_CENTER_POOLS.Back)
                local target_back = deck_pool[args.to_key]
                if target_back and target_back.mod and target_back.mod.id and target_back.mod.id ~= 'base' then
                    local mod_id = target_back.mod.id
                    local back_key = target_back.key
                    if TEO_set_last_hovered_translation_target then
                        TEO_set_last_hovered_translation_target(mod_id, 'Back', back_key, target_back.name or back_key)
                    end
                    if TEO_resolve_card_localization then
                        TEO_dbg_print('[TEOcean AI] Back 切换，触发 AI 翻译:', mod_id, back_key)
                        TEO_resolve_card_localization(mod_id, 'Back', back_key)
                    end
                end
            end

            -- 执行原逻辑
            local result = change_viewed_back_ref(args)

            -- 执行后再次触发，确保 UI 更新后翻译已应用
            if ai_enabled and G and G.GAME and G.GAME.viewed_back and G.GAME.viewed_back.effect and G.GAME.viewed_back.effect.center then
                local viewed_back = G.GAME.viewed_back.effect.center
                if viewed_back.mod and viewed_back.mod.id and viewed_back.mod.id ~= 'base' then
                    -- 翻译已经在上面的 resolve_card_localization 中完成并缓存
                    -- 这里只需要触发 UI 重新生成
                end
            end

            return result
        end
        TEO_dbg_print('[TEOcean AI] G.FUNCS.change_viewed_back Hook 已安装')
    end
end

-- 延迟安装 Hook，因为 G.FUNCS 可能在之后才初始化
hook_change_viewed_back()
if not change_viewed_back_ref then
    local init_ref = G.FUNCS and G.FUNCS.openModUI
    if init_ref then
        local openModUI_original = init_ref
        G.FUNCS.openModUI = function(mod_id)
            local result = openModUI_original(mod_id)
            hook_change_viewed_back()
            return result
        end
    end
end

print('[TEOcean AI] AI 翻译模块已加载')
