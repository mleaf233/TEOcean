local function has_selected_mod(config)
    for _, selected in pairs((config and config.clicked_list) or {}) do
        if selected == true then return true end
    end
    return false
end

local function run_manual_reload()
    local mod = TEO_get_mod()
    if not mod then return end

    if mod.config and mod.config.use_runtime_override == true then
        local ok, err = pcall(TEO_apply_all_runtime_localizations)
        if ok then
            print('[TEOcean Runtime] 手动重载时自动应用运行时覆盖成功')
        else
            print(('[TEOcean Runtime] 手动重载时自动应用失败: %s'):format(tostring(err)))
        end
        return
    end

    local ok, err = pcall(merge_impl_mod_localizations, false)
    if not ok then
        print(('[TEOcean Language Packs] 手动重载失败: %s'):format(tostring(err)))
        return
    end

    TEO_dbg_print('[TEOcean Language Packs] 手动重载完成')
    TEO_quick_reload_lang(G.LANG or {})
end

local function install_runtime_localization_stage(mod)
    if not (SMODS.GameObject and SMODS.GameObject.extend) then
        print('[TEOcean Runtime] 当前 SMODS 缺少 GameObject API，无法安装启动时运行时覆盖')
        return
    end
    if SMODS.TEOceanRuntimeLocalization then return end

    -- This subclass is registered after SMODS._Loc_Post, so target mod localization
    -- files have already populated G.localization when this callback runs.
    SMODS.TEOceanRuntimeLocalization = SMODS.GameObject:extend({
        obj_table = {},
        obj_buffer = {},
        set = '[INTERNAL]',
        silent = true,
        register = function() error('TEOcean internal class cannot be registered') end,
        pre_inject_class = function()
            if not (mod.config and mod.config.use_runtime_override == true and has_selected_mod(mod.config)) then
                return
            end

            local ok, err = pcall(TEO_apply_all_runtime_localizations, true)
            if not ok then
                print(('[TEOcean Runtime] 启动时自动应用失败: %s'):format(tostring(err)))
            else
                print('[TEOcean Runtime] 启动时自动应用运行时覆盖成功')
            end
        end
    })
end

function TEO_install_lifecycle(mod)
    assert(mod, 'TEOcean lifecycle requires a mod instance')
    G.FUNCS = G.FUNCS or {}
    G.FUNCS.TEOcean_manual_reload = run_manual_reload

    -- Disk mode writes before SMODS._Loc_Post reads each target localization file.
    mod.process_loc_text = function()
        if not (mod.config and mod.config.use_runtime_override == true) then
            merge_impl_mod_localizations()
        end
    end

    mod.config_tab = function()
        return TEO_build_config_tab(mod)
    end

    install_runtime_localization_stage(mod)
end
