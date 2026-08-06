local function action_button(button, label, colour)
    return UIBox_button({
        button = button,
        label = { label },
        minw = 2.8,
        minh = 0.8,
        scale = 0.4,
        colour = colour
    })
end

local function option_row(mod, option)
    local callback = option.callback or function()
        TEO_save_configs()
    end

    return {
        n = G.UIT.R,
        config = { align = 'cm' },
        nodes = {
            {
                n = G.UIT.C,
                config = { align = 'cl', padding = 0.05 },
                nodes = {
                    create_toggle({
                        label = localize(option.label_key) or option.fallback,
                        ref_table = mod.config,
                        ref_value = option.ref_value,
                        active_colour = option.active_colour,
                        callback = callback
                    })
                }
            },
            TEO_create_hover_tooltip({ tooltip_key = option.label_key })
        }
    }
end

local function build_actions(mod)
    local teo_alert = mod.mod_button_alert == true
    local adapted_button = action_button(
        'TEOcean_adapted_mods_button',
        localize('teo_adapted_mods') or '适配的模组',
        teo_alert and G.C.RED or G.C.BOOSTER
    )

    local rows = {
        {
            action_button('TEOcean_manual_reload', localize('teo_reload') or '手动重载'),
            action_button('TEOcean_ask_api_key', localize('teo_set_api_key') or '设置 AI 接口', HEX('0096C7'))
        },
        {
            action_button('TEOcean_ai_cache_manager', localize('teo_ai_cache_manager') or 'AI缓存管理', HEX('2A9D8F')),
            adapted_button
        }
    }

    local nodes = {}
    for _, buttons in ipairs(rows) do
        local columns = {}
        for _, button in ipairs(buttons) do
            columns[#columns + 1] = {
                n = G.UIT.C,
                config = { align = 'cm', minw = 3, maxw = 3, padding = 0.05 },
                nodes = { button }
            }
        end
        nodes[#nodes + 1] = {
            n = G.UIT.R,
            config = { align = 'cm', padding = 0.05 },
            nodes = columns
        }
    end

    return {
        n = G.UIT.R,
        config = { align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = HEX('586E82'), minw = 6.2, maxw = 6.2 },
        nodes = nodes
    }
end

function TEO_build_config_tab(mod)
    local options = {
        { label_key = 'teo_show_original', fallback = '显示原版翻译', ref_value = 'show_original_translation' },
        { label_key = 'teo_show_original_blind', fallback = '显示盲注原版翻译', ref_value = 'show_original_blind_translation' },
        {
            label_key = 'teo_runtime_override',
            fallback = '运行时覆盖',
            ref_value = 'use_runtime_override',
            callback = function()
                TEO_save_configs()
                TEO_dbg_print(mod.config.use_runtime_override and
                    '[TEOcean] 已切换到运行时模式（内存中覆盖）' or
                    '[TEOcean] 已切换到磁盘模式（写入文件）')
            end
        },
        {
            label_key = 'teo_enable_ai',
            fallback = '启用 AI 翻译',
            ref_value = 'enable_ai_translation',
            active_colour = TEO_has_required_ai_config(mod.config) and G.C.RED or G.C.UI.BACKGROUND_INACTIVE,
            callback = function()
                if TEO_has_required_ai_config(mod.config) then
                    TEO_save_configs()
                    print(mod.config.enable_ai_translation and '[TEOcean] AI 翻译功能已启用' or
                        '[TEOcean] AI 翻译功能已禁用')
                else
                    mod.config.enable_ai_translation = false
                    TEO_save_configs()
                    print('[TEOcean] AI 配置不完整（需要 URL/Model/API Key），跳转至设置页面')
                    G.FUNCS.TEOcean_ask_api_key()
                end
            end
        },
        { label_key = 'teo_disable_edge_sidebar', fallback = '关闭侧边栏', ref_value = 'disable_edge_sidebar' },
        {
            label_key = 'teo_enable_debug',
            fallback = '启用 DEBUG 模式',
            ref_value = 'enable_debug',
            callback = function()
                TEO_save_configs()
                TEO_set_debug_mode(mod.config.enable_debug)
                print(mod.config.enable_debug and '[TEOcean] DEBUG 模式已启用' or '[TEOcean] DEBUG 模式已禁用')
            end
        }
    }

    local option_nodes = {}
    for _, option in ipairs(options) do
        option_nodes[#option_nodes + 1] = option_row(mod, option)
    end

    return {
        n = G.UIT.ROOT,
        config = { align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = G.C.BLACK, minw = 10 },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = HEX('3E4C59'), minh = 3.2 },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { align = 'cm', minh = 0.1, padding = 0.05 },
                        nodes = { { n = G.UIT.T, config = { text = localize('teo_actions') or 'Actions', colour = G.C.WHITE, scale = 0.5 } } }
                    },
                    build_actions(mod)
                }
            },
            { n = G.UIT.R, config = { minh = 0.05 } },
            {
                n = G.UIT.R,
                config = { align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = HEX('3E4C59') },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { align = 'cm', minh = 1, padding = 0.1 },
                        nodes = { { n = G.UIT.T, config = { text = localize('teo_optional_config') or 'Optional Config', colour = G.C.WHITE, scale = 0.5 } } }
                    },
                    {
                        n = G.UIT.R,
                        config = { align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = HEX('586E82'), minw = 6 },
                        nodes = option_nodes
                    }
                }
            }
        }
    }
end
