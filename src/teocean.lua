local mod = SMODS.current_mod

-- 加载工具函数
assert(SMODS.load_file('src/utils.lua'), "Failed to load utils file. ")()
TEO_init_configs()

-- 加载本地化函数
assert(SMODS.load_file('src/localization.lua'), "Failed to load localization file. ")()

assert(SMODS.load_file('src/ui.lua'), "Failed to load UI file. ")()
assert(SMODS.load_file('src/original_translation.lua'), "Failed to load original translation file. ")()
assert(SMODS.load_file('src/llm_demo.lua'), "Failed to load LLM demo file. ")()
assert(SMODS.load_file('src/ai_manager.lua'), "Failed to load AI Manager. ")()
assert(SMODS.load_file('src/ai_translation.lua'), "Failed to load AI Translation UI. ")()
-- 手动重载回调：在模组配置中调用以立即触发合并/备份/写入操作
G.FUNCS = G.FUNCS or {}
G.FUNCS.TEOcean_manual_reload = function(e)
    local teo_mod = TEO_get_mod()
    if teo_mod.config and teo_mod.config.use_runtime_override == true then
        TEO_dbg_print('[TEOcean Runtime] 检测到运行时模式已启用，自动应用内存覆盖')
        local ok, err = pcall(TEO_apply_all_runtime_localizations)
        if ok then
            print('[TEOcean Runtime] 手动重载时自动应用运行时覆盖成功')
        else
            print(('[TEOcean Runtime] 手动重载时自动应用失败: %s'):format(tostring(err)))
        end
    else
        TEO_dbg_print('[TEOcean Language Packs] 手动重载触发')
        local ok, err = pcall(merge_impl_mod_localizations, false)
        if ok then
            TEO_dbg_print('[TEOcean Language Packs] 手动重载完成')
        else
            print(('[TEOcean Language Packs] 手动重载失败: %s'):format(tostring(err)))
        end
        -- 给玩家一点可见反馈（控制台日志即可）；如需弹窗，可在这里增加 UI 提示
        TEO_quick_reload_lang(G.LANG or {})
    end
end


if mod then
    mod.process_loc_text = function()
        -- 在游戏启动时（process_loc_text被调用时）自动应用运行时覆盖
        -- 这个函数在 SMODS 初始化后被调用，确保所有 mod 都已加载
        if mod.config and mod.config.use_runtime_override == true then
            -- 此处分支有bug，无法在启动游戏时运行，本地化覆盖会失败
            -- local clicked_list = mod.config.clicked_list or {}
            -- local has_checked_mods = false

            -- for _, is_checked in pairs(clicked_list) do
            --     if is_checked == true then
            --         has_checked_mods = true
            --         break
            --     end
            -- end

            -- if has_checked_mods then
            --     TEO_dbg_print('[TEOcean Runtime] 检测到运行时模式已启用，自动应用内存覆盖')
            --     local ok, err = pcall(TEO_apply_all_runtime_localizations)
            --     if ok then
            --         print('[TEOcean Runtime] 启动时自动应用运行时覆盖成功')
            --     else
            --         print(('[TEOcean Runtime] 自动应用失败: %s'):format(tostring(err)))
            --     end
            -- end
        else
            merge_impl_mod_localizations()
        end
    end
    -- 模组配置
    mod.config_tab = function()
        local adapted_mods_Button = UIBox_button({
            id = "TEOcean_adapted_mods_button",
            col = true,
            button = "TEOcean_adapted_mods_button",
            colour = SMODS.mod_button_alert and (G.SETTINGS.reduced_motion and G.C.RED or SMODS.Gradients.warning_bg) or
                G.C.BOOSTER,
            text_colour = (SMODS.mod_button_alert and not G.SETTINGS.reduced_motion) and SMODS.Gradients.warning_text or
                G.C.TEXT_LIGHT,
            label = { localize('teo_adapted_mods') or '适配的模组' },
            scale = 0.4
        })

        return {
            n = G.UIT.ROOT,
            config = { align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = G.C.BLACK, minw = 10 },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = HEX('3E4C59'), minh = 3.2},
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = 'cm', minh = 0.1, padding = 0.05 },
                            nodes = {
                                { n = G.UIT.T, config = { text = localize('teo_actions') or "Actions", colour = G.C.WHITE, scale = 0.5 } }
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = { align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = HEX('586E82'), minw = 6.2, maxw = 6.2 },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", padding = 0.05 },
                                    nodes = {
                                        {
                                            n = G.UIT.C,
                                            config = { align = "cm", minw = 3, maxw = 3, padding = 0.05 },
                                            nodes = {
                                                UIBox_button({ button = 'TEOcean_manual_reload', label = { localize('teo_reload') or '手动重载' }, minw = 2.8, minh = 0.8, scale = 0.4 })
                                            }
                                        },
                                        {
                                            n = G.UIT.C,
                                            config = { align = "cm", minw = 3, maxw = 3, padding = 0.05 },
                                            nodes = {
                                                UIBox_button({
                                                    button = 'TEOcean_ask_api_key',
                                                    label = { localize('teo_set_api_key') or '设置 API Key' },
                                                    minw = 2.8,
                                                    minh = 0.8,
                                                    scale = 0.4,
                                                    colour = HEX('0096C7') -- Ocean Blue
                                                })
                                            }
                                        }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", padding = 0.05 },
                                    nodes = {
                                        {
                                            n = G.UIT.C,
                                            config = { align = "cm", minw = 3, maxw = 3, padding = 0.05 },
                                            nodes = {
                                                UIBox_button({
                                                    button = 'TEOcean_ai_cache_manager',
                                                    label = { localize('teo_ai_cache_manager') or 'AI缓存管理' },
                                                    minw = 2.8,
                                                    minh = 0.8,
                                                    scale = 0.4,
                                                    colour = HEX('2A9D8F') -- Teal Ocean
                                                })
                                            }
                                        },
                                        {
                                            n = G.UIT.C,
                                            config = { align = "cm", minw = 3, maxw = 3, padding = 0.05 },
                                            nodes = {
                                                adapted_mods_Button
                                            }
                                        }
                                    }
                                }
                            }
                        },
                    }
                },
                { n = G.UIT.R, config = { minh = 0.05 } }, -- Spacer
                {
                    n = G.UIT.R,
                    config = { align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = HEX('3E4C59') },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = 'cm', minh = 1, padding = 0.1 },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = localize('teo_optional_config') or "Optional Config",
                                        colour = G.C.WHITE,
                                        scale = 0.5
                                    }
                                }
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = { align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = HEX('586E82'), minw = 6 },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        {
                                            n = G.UIT.C,
                                            config = { align = "cl", padding = 0.05 },
                                            nodes = {
                                                create_toggle({
                                                    label = localize('teo_show_original') or '显示原版翻译',
                                                    ref_table = mod.config,
                                                    ref_value = 'show_original_translation',
                                                    callback = function(_set_toggle)
                                                        TEO_save_configs()
                                                    end
                                                })
                                            }
                                        },
                                        TEO_create_hover_tooltip{ tooltip_key = "teo_show_original" }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        {
                                            n = G.UIT.C,
                                            config = { align = "cl", padding = 0.05 },
                                            nodes = {
                                                create_toggle({
                                                    label = localize('teo_show_original_blind') or '显示盲注原版翻译',
                                                    ref_table = mod.config,
                                                    ref_value = 'show_original_blind_translation',
                                                    callback = function(_set_toggle)
                                                        TEO_save_configs()
                                                    end
                                                })
                                            }
                                        },
                                        TEO_create_hover_tooltip{ tooltip_key = "teo_show_original_blind" }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        {
                                            n = G.UIT.C,
                                            config = { align = "cl", padding = 0.05 },
                                            nodes = {
                                                create_toggle({
                                                    label = localize('teo_runtime_override') or "Runtime Override",
                                                    ref_table = mod.config,
                                                    ref_value = 'use_runtime_override',
                                                    callback = function(_set_toggle)
                                                        -- 只保存配置，不执行任何业务逻辑
                                                        -- 业务逻辑由单个 mod 的勾选触发
                                                        TEO_save_configs()

                                                        -- 提示用户模式已切换
                                                        if mod.config.use_runtime_override then
                                                            TEO_dbg_print('[TEOcean] 已切换到运行时模式（内存中覆盖）')
                                                        else
                                                            TEO_dbg_print('[TEOcean] 已切换到磁盘模式（写入文件）')
                                                        end
                                                    end
                                                })
                                            }
                                        },
                                        TEO_create_hover_tooltip{ tooltip_key = "teo_runtime_override" }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        {
                                            n = G.UIT.C,
                                            config = { align = "cl", padding = 0.05 },
                                            nodes = {
                                                create_toggle({
                                                    label = localize('teo_enable_ai') or "Enable AI Translation",
                                                    ref_table = mod.config,
                                                    ref_value = 'enable_ai_translation',
                                                    active_colour = (mod.config.api_key ~= nil and mod.config.api_key ~= "") and
                                                        G.C.RED or G.C.UI.BACKGROUND_INACTIVE,
                                                    callback = function(_set_toggle)
                                                        if mod.config.api_key and mod.config.api_key ~= "" then
                                                            TEO_save_configs()
                                                            if mod.config.enable_ai_translation then
                                                                print('[TEOcean] AI 翻译功能已启用')
                                                            else
                                                                print('[TEOcean] AI 翻译功能已禁用')
                                                            end
                                                        else
                                                            -- Redirect to API Key setting
                                                            mod.config.enable_ai_translation = false
                                                            TEO_save_configs()
                                                            print('[TEOcean] 未设置 API Key，跳转至设置页面')
                                                            G.FUNCS.TEOcean_ask_api_key()
                                                        end
                                                    end
                                                })
                                            }
                                        },
                                        TEO_create_hover_tooltip{ tooltip_key = "teo_enable_ai" }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        {
                                            n = G.UIT.C,
                                            config = { align = "cl", padding = 0.05 },
                                            nodes = {
                                                create_toggle({
                                                    label = localize('teo_enable_debug') or "启用DEBUG模式",
                                                    ref_table = mod.config,
                                                    ref_value = 'enable_debug',
                                                    callback = function(_set_toggle)
                                                        TEO_save_configs()
                                                        TEO_set_debug_mode(mod.config.enable_debug)
                                                        if mod.config.enable_debug then
                                                            print('[TEOcean] DEBUG 模式已启用')
                                                        else
                                                            print('[TEOcean] DEBUG 模式已禁用')
                                                        end
                                                    end
                                                })
                                            }
                                        },
                                        TEO_create_hover_tooltip{ tooltip_key = "teo_enable_debug" }
                                    }
                                },
                            }
                        },
                    }
                }
            }
        }
    end
    print('[TEOcean Language Packs] TEOcean 适配的汉化语言包预处理完成 尽情享受游戏吧！')
end
