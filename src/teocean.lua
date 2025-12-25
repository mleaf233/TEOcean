local mod = SMODS.current_mod

-- 加载工具函数
assert(SMODS.load_file('src/utils.lua'), "Failed to load utils file. ")()

-- 加载本地化函数
assert(SMODS.load_file('src/localization.lua'), "Failed to load localization file. ")()

-- print('[TEOcean Language Packs] 正在合并 impl/mods 下的本地化文件...')
-- if mod then
--     mod.process_loc_text = merge_impl_mod_localizations
--     print('[TEOcean Language Packs] 已注册本地化合并函数，将在本地化注入阶段运行')
-- else
--     print('[TEOcean Language Packs] 当前 mod 未就绪，无法注册本地化合并函数')
-- end


assert(SMODS.load_file('src/ui.lua'), "Failed to load UI file. ")()
-- 手动重载回调：在模组配置中调用以立即触发合并/备份/写入操作
G.FUNCS = G.FUNCS or {}
G.FUNCS.TEOcean_manual_reload = function(e)
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


if mod then
    mod.config_tab = function()
        local adapted_mods_Button = UIBox_button({
            id = "TEOcean_adapted_mods_button",
            minh = 1.55,
            minw = 1.85,
            col = true,
            button = "TEOcean_adapted_mods_button",
            colour = SMODS.mod_button_alert and (G.SETTINGS.reduced_motion and G.C.RED or SMODS.Gradients.warning_bg) or
            G.C.BOOSTER,
            text_colour = (SMODS.mod_button_alert and not G.SETTINGS.reduced_motion) and SMODS.Gradients.warning_text or
            G.C.TEXT_LIGHT,
            label = { localize('teo_adapted_mods') or '适配的模组' }, 
            scale = 0.45 * 1.2
        })
        return {
            n = G.UIT.ROOT,
            config = { align = "cm", padding = 0.05, colour = G.C.CLEAR },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm", scale = 0.5 },
                    nodes = {
                        UIBox_button({ button = 'TEOcean_manual_reload', label = { localize('teo_reload') or '手动重载' }, minw = 3.0, minh = 1.2, scale = 0.5 })
                    }
                },
                {
                    n = G.UIT.R,
                    config = { align = "cm", scale = 0.5 },
                    nodes = {
                        adapted_mods_Button,
                    }
                },


            }
        }
    end
end

print('[TEOcean Language Packs] TEOcean 本地化框架 mod加载完成')
print('[TEOcean Language Packs] TEOcean 适配的汉化语言包预处理完成 尽情享受游戏吧！')