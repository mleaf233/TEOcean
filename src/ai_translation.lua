-- AI Translation UI logic
-- 功能：Hook 游戏 UI 函数，仅用于检测并触发后台翻译请求
-- 不再直接注入 UI，而是等待 ai_manager 更新 G.localization

local TEO = SMODS.current_mod

-- 仍然保留 TEO_build_ai_translation_ui 用于占位或调试（可选）
-- 但主要逻辑是触发

-- Hook generate_card_ui
-- 只做一件事：检查当前卡牌是否已翻译/已请求，如果未请求则发起请求
local generate_card_ui_ai_ref = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
    -- 1. 执行原逻辑
    local result = generate_card_ui_ai_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start,
        main_end)

    local TEO_mod = TEO_get_mod()
    if not TEO_mod or not TEO_mod.config or not TEO_mod.config.enable_ai_translation then
        return result
    end

    if not _c or not _c.key or not _c.set then return result end

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

    -- 使用统一的卡牌本地化获取函数（包含4层优先级）
    if TEO_get_card_localization_with_ai then
        TEO_get_card_localization_with_ai(mod_id, _c.set, _c.key)
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

print('[TEOcean AI] AI 翻译模块已加载 (需同时开启 "运行时动态覆盖"配置)')
