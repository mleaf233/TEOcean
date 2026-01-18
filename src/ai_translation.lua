-- AI Translation UI logic
-- 功能：Hook 游戏 UI 函数，仅用于检测并触发后台翻译请求
-- 不再直接注入 UI，而是等待 ai_manager 更新 G.localization

-- Hook generate_card_ui
-- 检查当前卡牌是否已翻译/已请求，如果未请求则发起请求
local generate_card_ui_ai_ref = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    -- 跳过非卡牌对象 - 在调用原函数之前检查
    if not _c or type(_c) ~= 'table' or not _c.key or not _c.set then
        return generate_card_ui_ai_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    end

    -- 1. 执行原逻辑
    local result = generate_card_ui_ai_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start,
        main_end, card)

    local TEO_mod = TEO_get_mod()
    if not TEO_mod or not TEO_mod.config or not TEO_mod.config.enable_ai_translation then
        return result
    end

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
    end

    if not mod_id or mod_id == 'base' then return result end

    -- 使用统一的卡牌本地化解析函数（包含3级优先级）
    if TEO_resolve_card_localization then
        TEO_resolve_card_localization(mod_id, _c.set, _c.key)
    end

    -- Debug: 输出当前显示的翻译文本
    if TEO_DEBUG == true and G.localization and G.localization.descriptions then
        local loc_data = G.localization.descriptions[_c.set] and
            G.localization.descriptions[_c.set][_c.key]
        if loc_data then
            local debug_text = {}
            if loc_data.name then
                table.insert(debug_text, "Name: " .. tostring(loc_data.name))
            end
            if loc_data.text then
                if type(loc_data.text) == 'table' then
                    for i, line in ipairs(loc_data.text) do
                        table.insert(debug_text, "Text[" .. i .. "]: " .. tostring(line))
                    end
                else
                    table.insert(debug_text, "Text: " .. tostring(loc_data.text))
                end
            end
            TEO_dbg_print(string.format("[TEOcean AI Debug] Card hover: %s.%s.%s\n%s",
                mod_id, _c.set, _c.key, table.concat(debug_text, "\n")))
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

    -- 在原函数调用之前触发AI翻译（因为原函数会通过localize()读取G.localization）
    if ai_enabled and mod_id and mod_id ~= 'base' and blind_key then
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
                table.insert(debug_text, "Name: " .. tostring(loc_data.name))
            end
            if loc_data.text then
                if type(loc_data.text) == 'table' then
                    for i, line in ipairs(loc_data.text) do
                        table.insert(debug_text, "Text[" .. i .. "]: " .. tostring(line))
                    end
                else
                    table.insert(debug_text, "Text: " .. tostring(loc_data.text))
                end
            end
            TEO_dbg_print(string.format("[TEOcean AI Debug] Blind hover: %s.Blind.%s\n%s",
                mod_id or 'unknown', blind_key or 'unknown', table.concat(debug_text, "\n")))
        end
    end

    return result
end

print('[TEOcean AI] AI 翻译模块已加载')
