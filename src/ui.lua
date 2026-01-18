-- 现在UI界面大部分都是改自smod
TEO = TEO_get_mod()
if TEO then
    TEO.GUI = TEO.GUI or {}
    TEO.LAST_VIEWED_MODS_PAGE = TEO.LAST_VIEWED_MODS_PAGE or nil
end


function G.FUNCS.update_teo_mod_list(args)
    if not args or not args.cycle_config then return end
    SMODS.GUI.DynamicUIManager.updateDynamicAreas({
        ["modsList"] = TEO.GUI.dynamicModListContent(args.cycle_config.current_option)
    })
end

function G.FUNCS.openAdaptedModsDirectory(options)
    love.system.openURL(TEO.path .. 'impl/mods/')
end

local function createTextColNode(text, scale, colour, node)
    return {
        n = node or G.UIT.R,
        config = { padding = 0, align = "lc", maxw = 2.8, maxh = 1.5, },
        nodes = {
            { n = G.UIT.T, config = { text = text, colour = colour or G.C.UI.TEXT_LIGHT, scale = scale * 0.7 } },
        }
    }
end

-- 获取已适配并已安装的Mod列表
local function get_adapted_mods_list()
    local adapted_mods = {}
    for _, modInfo in ipairs(SMODS.mod_list or {}) do
        if (modInfo and modInfo.id and modInfo.path) then
            -- 检查是否在 impl/mods/<modid>/ 下存在对应文件夹
            local impl_mod_dir = TEO.path .. 'impl/mods/' .. modInfo.id .. '/'
            if NFS.getInfo(impl_mod_dir) then
                table.insert(adapted_mods, modInfo)
            end
        end
    end
    return adapted_mods
end


local function recalculateModsList(page)
    page = page or TEO.LAST_VIEWED_MODS_PAGE or 1
    TEO.LAST_VIEWED_MODS_PAGE = page
    local adapted_mods = get_adapted_mods_list()
    local modsRowPerPage = 2
    local modsColPerRow = 3
    local startIndex = (page - 1) * modsRowPerPage * modsColPerRow + 1
    local endIndex = startIndex + modsRowPerPage * modsColPerRow - 1
    local totalPages = math.ceil(#adapted_mods / (modsRowPerPage * modsColPerRow))
    local currentPage = localize('k_page') .. ' ' .. page .. "/" .. totalPages
    local pageOptions = {}
    for i = 1, totalPages do
        table.insert(pageOptions, (localize('k_page') .. ' ' .. tostring(i) .. "/" .. totalPages))
    end
    local showingList = #adapted_mods > 0

    return currentPage, pageOptions, showingList, startIndex, endIndex, modsRowPerPage, modsColPerRow, adapted_mods
end

local function concatAuthors(authors)
    if type(authors) == "table" then
        return table.concat(authors, ", ")
    end
    return authors or localize('b_unknown')
end

local function createClickableModBox(modInfo, scale)
    local function invert(c)
        return { 1 - c[1], 1 - c[2], 1 - c[3], c[4] }
    end
    TEO_init_UI_configs()
    -- 修改默认值为false，即初始状态下所有mod都不勾选
    if modInfo.should_teo_localize == nil then
        modInfo.should_teo_localize = false
    end
    if SMODS.full_restart == nil then
        SMODS.full_restart = 0
    end
    if TEO.need_reload == nil then
        TEO.need_reload = false
    end

    local col, text_col, bg_col
    if modInfo.can_load then
        col = mix_colours(G.C.UI.TEXT_DARK, { 0.7, 0.8, 0.9, 1 }, 0.8)
    elseif modInfo.disabled then
        col = mix_colours(G.C.UI.BACKGROUND_INACTIVE, { 0, 0, 0, 1 }, 0.6)
    else
        col = G.C.RED
        text_col = G.C.TEXT_DARK
    end
    bg_col = mix_colours({ 0.5, 0.5, 0.5, 0.2 }, col, 0.5)
    local label_nodes = {}
    local modname_split = SMODS.smart_line_splitter(modInfo.name, 18, true)
    for _, v in ipairs(modname_split) do
        table.insert(label_nodes, createTextColNode(v, scale * 1.2, text_col))
    end
    local version_col = copy_table(G.C.WHITE)
    version_col[4] = 0.6
    if modInfo.lovely_only then
        table.insert(label_nodes, createTextColNode(localize('b_lovely_mod'), scale, version_col))
    end
    local sub_node_1 = {}
    local under_checkbox_nodes = {}
    if modInfo.version and modInfo.version ~= '0.0.0' then
        table.insert(sub_node_1, createTextColNode(('%s'):format(modInfo.version), scale, version_col, G.UIT.C))
    end
    if modInfo.config_tab then
        local is_config_func = type(modInfo.config_tab) == "function"
        table.insert(under_checkbox_nodes, {
            n = G.UIT.R,
            config = {
                page = is_config_func and "config",
                padding = 0.1,
                align = "cm",
                colour = is_config_func and G.C.BLUE,
                button = is_config_func and ("openModUI_" .. modInfo.id),
                shadow = is_config_func,
                shadow_height = 0.5,
                r = 0.1,
                hover = is_config_func
            },
            nodes = {
                {
                    n = G.UIT.O,
                    config = {
                        object = SMODS.create_sprite(0, 0, 0.3, 0.3, 'mod_tags', { x = 2, y = 0 })
                    }
                }
            }
        })
    end
    if #sub_node_1 > 0 then
        table.insert(label_nodes, {
            n = G.UIT.R,
            config = {

            },
            nodes = sub_node_1
        })
    end
    if not modInfo.lovely_only then
        local translators = TEO_get_translators(modInfo, TEO_get_cur_language())
        local tx = concatAuthors(translators)
        local the_colour = mix_colours(G.C.BLACK, G.C.WHITE, 0.2)
        the_colour[4] = 0.8
        local authorDynatext = DynaText {
            string = tx,
            scale = scale * 0.7,
            colours = { the_colour },
            shadow = true,
            maxw = 2.4,
            marquee = false,
        }
        table.insert(label_nodes,
            {
                n = G.UIT.R,
                config = { padding = 0, align = "lc", maxw = 4.5, maxh = 1.5, },
                nodes = {
                    { n = G.UIT.T, config = { text = localize('b_t_by'), scale = scale * 0.7, colour = the_colour } },
                    {
                        n = G.UIT.O, config = { object = authorDynatext }
                    }
                }
            })
    end
    if not _RELEASE_MODE and modInfo.priority then
        table.insert(label_nodes,
            createTextColNode(('%s%s'):format(localize('b_priority'), number_format(modInfo.priority)), scale,
                version_col))
    end

    return {
        n = G.UIT.C,
        config = { align = "cm", padding = 0.05 },
        nodes = {
            {
                n = G.UIT.C,
                config = { padding = 0.05, align = "cm", colour = bg_col, r = 0.1, minw = 1.5, minh = 1 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = {
                            padding = 0.1,
                            align = "lc",
                            button = "openModUI_" .. modInfo.id,
                            minw = 4.25,
                            minh = 1.4,
                            maxh = 1.4,
                            r = 0.1,
                            colour = col,
                            shadow = true,
                            shadow_height = 0.5,
                            hover = true,
                        },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = { align = "cm" },
                                nodes = {
                                    buildModtag(modInfo),
                                }
                            },
                            {
                                n = G.UIT.C,
                                config = { align = "lc", },
                                nodes = label_nodes
                            },
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = { padding = 0.05, align = "cm" },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = "cm" },
                                nodes = {
                                    create_toggle({
                                        label = '',
                                        ref_table = modInfo,
                                        ref_value = 'should_teo_localize',
                                        col = true,
                                        hide_label = true,
                                        w = 0,
                                        h = 0.2,
                                        scale = 1,
                                        callback = (
                                            function(_set_toggle)
                                                -- 检查是否启用运行时覆盖模式
                                                local use_runtime = TEO.config and TEO.config.use_runtime_override or
                                                    false

                                                if modInfo.should_teo_localize then
                                                    -- 勾选：根据模式执行不同操作
                                                    if use_runtime then
                                                        -- 运行时模式：内存中覆盖
                                                        TEO_dbg_print(('[TEOcean Runtime] 为 %s 应用内存覆盖'):format(modInfo
                                                            .id))
                                                        local ok, err = pcall(TEO_apply_runtime_localization, modInfo.id)
                                                        if ok then
                                                            TEO_dbg_print(('[TEOcean Runtime] %s 内存覆盖完成'):format(modInfo
                                                                .id))
                                                        else
                                                            TEO_dbg_print(('[TEOcean Runtime] %s 内存覆盖失败: %s'):format(
                                                                modInfo.id, tostring(err)))
                                                        end
                                                    else
                                                        -- 磁盘模式：写入文件
                                                        print(('[TEOcean] 开始为 %s 执行本地化合并'):format(modInfo.id))
                                                        local ok, err = pcall(merge_impl_mod_localizations_for_mod,
                                                            modInfo)
                                                        if ok then
                                                            print(('[TEOcean] %s 本地化合并完成'):format(modInfo.id))
                                                        else
                                                            print(('[TEOcean] %s 本地化合并失败: %s'):format(modInfo.id,
                                                                tostring(err)))
                                                        end
                                                    end
                                                else
                                                    -- 取消勾选：根据模式执行不同操作
                                                    if use_runtime then
                                                        -- 运行时模式：移除内存覆盖
                                                        TEO_dbg_print(('[TEOcean Runtime] 为 %s 移除内存覆盖'):format(modInfo
                                                            .id))
                                                        local ok, err = pcall(TEO_remove_runtime_localization, modInfo
                                                            .id)
                                                        if ok then
                                                            TEO_dbg_print(('[TEOcean Runtime] %s 内存覆盖已移除'):format(
                                                                modInfo.id))
                                                        else
                                                            TEO_dbg_print(('[TEOcean Runtime] %s 移除失败: %s'):format(
                                                                modInfo.id, tostring(err)))
                                                        end
                                                    else
                                                        -- 磁盘模式：恢复原始本地化
                                                        print(('[TEOcean] 开始为 %s 恢复原始本地化'):format(modInfo.id))
                                                        local ok, err = pcall(restore_original_localization_for_mod,
                                                            modInfo)
                                                        if ok then
                                                            print(('[TEOcean] %s 本地化恢复完成'):format(modInfo.id))
                                                        else
                                                            print(('[TEOcean] %s 本地化恢复失败: %s'):format(modInfo.id,
                                                                tostring(err)))
                                                        end
                                                    end
                                                end

                                                -- 保存配置
                                                if modInfo.should_teo_localize ~= nil then
                                                    TEO.config.clicked_list[modInfo.id] = modInfo.should_teo_localize
                                                end
                                                TEO_save_configs()
                                            end)
                                    })
                                }
                            },
                            unpack(under_checkbox_nodes)
                        }
                    }
                }
            }
        }
    }
end

function TEO.GUI.dynamicModListContent(page)
    local scale = 0.75
    local _, __, showingList, startIndex, endIndex, modsRowPerPage, modsColPerRow, adapted_mods = recalculateModsList(
        page)

    local modNodes = {}

    -- If no mods are loaded, show a default message
    if showingList == false then
        table.insert(modNodes, {
            n = G.UIT.R,
            config = {
                padding = 0,
                align = "cm"
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        text = localize('b_no_mods'),
                        shadow = true,
                        scale = scale * 0.5,
                        colour = G.C.UI.TEXT_DARK
                    }
                }
            }
        })
    else
        local modCount = 0
        local id = 0
        local current_row = {}

        for _, condition in ipairs({
            function(m) return not m.can_load and not m.disabled end,
            function(m) return m.can_load and m.config_tab end,
            function(m) return m.can_load and not m.config_tab end,
            function(m) return m.disabled end,
        }) do
            for _, modInfo in ipairs(adapted_mods) do
                if modCount >= modsRowPerPage * modsColPerRow then break end
                if condition(modInfo) then
                    id = id + 1
                    if id >= startIndex and id <= endIndex then
                        table.insert(current_row, createClickableModBox(modInfo, scale * 0.5))
                        modCount = modCount + 1
                        if math.fmod(modCount, modsColPerRow) == 0 then
                            table.insert(modNodes, {
                                n = G.UIT.R,
                                config = { padding = 0, align = "lc" },
                                nodes = current_row
                            })
                            current_row = {}
                        end
                    end
                end
            end
        end
        if #current_row > 0 then
            table.insert(modNodes, {
                n = G.UIT.R,
                config = { padding = 0, align = "lc" },
                nodes = current_row
            })
        end
    end

    return {
        n = G.UIT.C,
        config = {
            r = 0.1,
            align = "cm",
            padding = 0,
        },
        nodes = modNodes
    }
end

-- copy from smods GUI
function TEO.GUI.staticModListContent()
    local scale = 0.75
    local currentPage, pageOptions, showingList = recalculateModsList()
    return {
        n = G.UIT.R,
        config = {
            minh = 8.5,
            r = 0.1,
            minw = 17,
            align = "cm",
            padding = 0.05,
            colour = G.C.BLACK
        },
        nodes = {
            -- row container
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    -- column container
                    {
                        n = G.UIT.C,
                        config = { align = "cm", minw = 5, padding = 0.05, r = 0.1, colour = G.C.CLEAR },
                        nodes = {
                            -- title row
                            {
                                n = G.UIT.R,
                                config = {
                                    padding = 0.05,
                                    align = "cm"
                                },
                                nodes = {
                                    UIBox_button({
                                        label = { localize('teo_adapted_mods3') },
                                        shadow = true,
                                        scale = scale * 0.85,
                                        colour = G.C.BOOSTER,
                                        button = "openAdaptedModsDirectory",
                                        minh = scale,
                                        minw = 9
                                    }),
                                }
                            },

                            -- add some empty rows for spacing
                            {
                                n = G.UIT.R,
                                config = { align = "cm", padding = 0.05 },
                                nodes = {}
                            },
                            {
                                n = G.UIT.R,
                                config = { align = "cm", padding = 0.05 },
                                nodes = {}
                            },
                            {
                                n = G.UIT.R,
                                config = { align = "cm", padding = 0.05 },
                                nodes = {}
                            },
                            {
                                n = G.UIT.R,
                                config = { align = "cm", padding = 0.05 },
                                nodes = {}
                            },

                            -- dynamic content rendered in this row container
                            -- list of 4 x 4 mods on the current page
                            {
                                n = G.UIT.R,
                                config = {
                                    padding = 0.05,
                                    align = "cm",
                                    minh = 5,
                                    minw = 5
                                },
                                nodes = {
                                    { n = G.UIT.O, config = { align = "cm", id = 'modsList', object = Moveable() } },
                                }
                            },

                            -- another empty row for spacing
                            {
                                n = G.UIT.R,
                                config = { align = "cm", padding = 0.8 },
                                nodes = {}
                            },
                            -- page selector
                            -- does not appear when list of mods is empty
                            showingList and
                            SMODS.GUI.createOptionSelector({
                                label = "",
                                scale = 0.8,
                                options = pageOptions,
                                opt_callback = 'update_teo_mod_list',
                                no_pips = true,
                                current_option = (
                                    currentPage
                                )
                            }) or nil
                        }
                    },
                }
            },
        }
    }
end

function TEO_create_UIBox_mods_button()
    local scale = 0.75
    SMODS.browse_search = SMODS.browse_search or ''
    return (create_UIBox_generic_options({
        back_func = 'exit_teo_mods',
        contents = {
            {
                n = G.UIT.R,
                config = {
                    padding = 0,
                    align = "cm"
                },
                nodes = {
                    create_tabs({
                        snap_to_nav = true,
                        colour = G.C.BOOSTER,
                        tabs = {
                            {
                                label = localize('teo_adapted_mods2') or '已适配的模组',
                                chosen = true,
                                tab_definition_function = function()
                                    return SMODS.GUI.DynamicUIManager.initTab({
                                        updateFunctions = {
                                            modsList = G.FUNCS.update_teo_mod_list,
                                        },
                                        staticPageDefinition = TEO.GUI.staticModListContent()
                                    })
                                end
                            },

                        }
                    })
                }
            }
        }
    }))
end

G.FUNCS.exit_teo_mods = function()
    -- 检查是否使用运行时模式
    local use_runtime = TEO.config and TEO.config.use_runtime_override or false

    if use_runtime then
        -- 运行时模式：不需要重载，直接返回
        -- 因为内存覆盖已经即时生效了
        TEO_dbg_print('[TEOcean] 运行时模式，无需重载')
        if TEO and TEO.id and G.FUNCS["openModUI_" .. TEO.id] then
            G.FUNCS["openModUI_" .. TEO.id]()
        else
            G.FUNCS.exit_overlay_menu()
        end
    else
        -- 磁盘模式：检查是否有配置变化
        local current_config = TEO.config.clicked_list
        local initial_config = TEO.initial_config_state
        local need_reload = false

        if initial_config then
            for k, v in pairs(current_config) do
                if initial_config[k] ~= v then
                    need_reload = true
                    break
                end
            end
            -- 也要检查反向，防止从nil变为false/true的情况
            if not need_reload then
                for k, v in pairs(initial_config) do
                    if current_config[k] ~= v then
                        need_reload = true
                        break
                    end
                end
            end
        end

        if need_reload then
            -- 执行手动重载（磁盘模式需要）
            print('[TEOcean] 磁盘模式检测到配置变化，执行重载')
            G.FUNCS.TEOcean_manual_reload()
        else
            -- 返回之前的配置页面 (TEO Config Tab)
            if TEO and TEO.id and G.FUNCS["openModUI_" .. TEO.id] then
                G.FUNCS["openModUI_" .. TEO.id]()
            else
                G.FUNCS.exit_overlay_menu()
            end
        end
    end
end

G.FUNCS.TEOcean_adapted_mods_button = function()
    G.SETTINGS.paused = true
    SMODS.LAST_SELECTED_MOD_TAB = nil
    -- 保存初始配置状态以供退出时对比
    TEO.initial_config_state = copy_table(TEO.config.clicked_list or {})

    G.FUNCS.overlay_menu({
        definition = TEO_create_UIBox_mods_button()
    })
end

G.FUNCS.TEOcean_ask_api_key = function()
    local mod = TEO_get_mod()
    if not mod.config.api_key then
        mod.config.api_key = ""
    end

    -- Create a temporary display config for the UI and store in TEO so save function can access it
    TEO._api_key_display_config = {
        -- Show masked version by default (only if there's content)
        display_key = mod.config.api_key ~= "" and string.rep("*", #mod.config.api_key) or ""
    }

    G.FUNCS.overlay_menu({
        definition = {
            n = G.UIT.ROOT,
            config = { align = "cm", padding = 0.05, colour = G.C.BLACK, r = 0.1 },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { align = "cm", padding = 0.05 },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.1 },
                            nodes = {
                                { n = G.UIT.T, config = { text = localize('teo_api_key_popup_title'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT } }
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.1 },
                            nodes = {
                                create_text_input({
                                    ref_table = TEO._api_key_display_config,
                                    ref_value = "display_key",
                                    max_length = 120,
                                    prompt_text = "sk-...",
                                    extended_corpus = true,
                                    w = 8,
                                    h = 0.8,
                                    callback = function()
                                        -- When user finishes editing (presses Enter), save to real config
                                        mod.config.api_key = TEO._api_key_display_config.display_key
                                    end
                                })
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.1 },
                            nodes = {
                                -- Clear button row
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", padding = 0.1 },
                                    nodes = {
                                        UIBox_button({
                                            button = "TEOcean_clear_api_key",
                                            label = { localize('teo_b_clear') or "Empty" },
                                            minw = 2,
                                            scale = 0.4,
                                            colour = G.C.RED
                                        })
                                    }
                                },
                                -- Paste button row
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", padding = 0.1 },
                                    nodes = {
                                        UIBox_button({
                                            button = "TEOcean_paste_api_key",
                                            label = { localize('teo_b_paste') or "Paste" },
                                            minw = 2,
                                            scale = 0.4,
                                            colour = G.C.GREEN
                                        })
                                    }
                                },
                                -- Get API Key URL row
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", padding = 0.1 },
                                    nodes = {
                                        UIBox_button({
                                            button = "TEOcean_get_api_key_url",
                                            label = { localize('teo_b_get_key') or "Get API Key" },
                                            minw = 2,
                                            scale = 0.4,
                                            colour = G.C.ORANGE
                                        })
                                    }
                                },
                                -- Confirm/Cancel buttons row
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", padding = 0.1 },
                                    nodes = {
                                        {
                                            n = G.UIT.C,
                                            config = { align = "cm" },
                                            nodes = {
                                                UIBox_button({
                                                    button = "TEOcean_save_api_key_display",
                                                    label = { localize('teo_b_set') or "Confirm" },
                                                    minw = 2,
                                                    scale = 0.4
                                                })
                                            }
                                        },
                                        { n = G.UIT.C, config = { align = "cm", padding = 0.1 }, nodes = { { n = G.UIT.B, config = { w = 0.2, h = 0.1 } } } }, -- Spacer
                                        {
                                            n = G.UIT.C,
                                            config = { align = "cm" },
                                            nodes = {
                                                UIBox_button({
                                                    button = "TEOcean_cancel_api_key",
                                                    label = { localize('teo_b_cancel') or "Cancel" },
                                                    minw = 2,
                                                    scale = 0.4
                                                })
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    })
end

G.FUNCS.TEOcean_save_api_key_display = function(e)
    -- Get the display config from TEO global
    if TEO._api_key_display_config and TEO._api_key_display_config.display_key then
        local mod = TEO_get_mod()
        local new_value = TEO._api_key_display_config.display_key

        -- Check if the value is just masked characters (user didn't edit)
        -- If it's all asterisks and has the same length as original, user didn't change it
        local is_unchanged_mask = (new_value:match("^%*+$") ~= nil)

        if not is_unchanged_mask then
            -- User actually typed something, save it
            mod.config.api_key = new_value
            TEO_save_configs()
            print("[TEOcean] API Key Saved: " .. (new_value ~= "" and "***hidden***" or "empty"))
        else
            -- User didn't modify the masked input, keep original key
            print("[TEOcean] API Key unchanged (masked input not modified)")
        end
    end
    if TEO and TEO.id and G.FUNCS["openModUI_" .. TEO.id] then
        G.FUNCS["openModUI_" .. TEO.id]()
    else
        G.FUNCS.exit_overlay_menu()
    end
end

G.FUNCS.TEOcean_save_api_key = function()
    -- Legacy function, redirect to new one
    G.FUNCS.TEOcean_save_api_key_display()
end

G.FUNCS.TEOcean_cancel_api_key = function()
    if TEO and TEO.id and G.FUNCS["openModUI_" .. TEO.id] then
        G.FUNCS["openModUI_" .. TEO.id]()
    else
        G.FUNCS.exit_overlay_menu()
    end
end

G.FUNCS.TEOcean_clear_api_key = function()
    local mod = TEO_get_mod()
    if mod and mod.config then
        mod.config.api_key = ""
        TEO_save_configs()
        -- Refresh the popup to show empty text
        G.FUNCS.TEOcean_ask_api_key()
    end
end

G.FUNCS.TEOcean_blur_input = function()
    G.CONTROLLER.text_input_hook = nil
end

G.FUNCS.TEOcean_get_api_key_url = function()
    if love and love.system then
        love.system.openURL("https://platform.deepseek.com/api_keys")
    end
end

G.FUNCS.TEOcean_paste_api_key = function()
    local mod = TEO_get_mod()
    if love and love.system and TEO._api_key_display_config then
        local clipboard_text = love.system.getClipboardText()
        if clipboard_text and clipboard_text ~= "" then
            -- Remove any leading/trailing whitespace
            clipboard_text = clipboard_text:match("^%s*(.-)%s*$")
            TEO._api_key_display_config.display_key = clipboard_text
            -- Also save immediately to real config
            mod.config.api_key = clipboard_text
            TEO_save_configs()
            print("[TEOcean] API Key pasted from clipboard")
            -- Refresh the popup to show the pasted content
            G.FUNCS.TEOcean_ask_api_key()
        else
            print("[TEOcean] Clipboard is empty")
        end
    end
end

-- AI缓存管理弹窗
G.FUNCS.TEOcean_ai_cache_manager = function()
    local scale = 0.4
    local cached_mods = TEO_get_ai_cached_mods and TEO_get_ai_cached_mods() or {}

    -- 创建Mod列表节点
    local mod_list_nodes = {}
    if #cached_mods == 0 then
        table.insert(mod_list_nodes, {
            n = G.UIT.R,
            config = { align = "cm", padding = 0.3 },
            nodes = {
                { n = G.UIT.T, config = { text = localize('teo_no_ai_cache') or '暂无AI缓存', scale = 0.5, colour = G.C.UI.TEXT_LIGHT } }
            }
        })
    else
        for _, mod_info in ipairs(cached_mods) do
            -- 为每个按钮创建动态回调函数
            local button_func_name = "TEOcean_clear_ai_cache_" .. mod_info.id
            G.FUNCS[button_func_name] = function()
                if TEO_clear_ai_cache_for_mod then
                    local success = TEO_clear_ai_cache_for_mod(mod_info.id)
                    if success then
                        print('[TEOcean] 已清除Mod AI缓存:', mod_info.id)
                        -- 刷新弹窗
                        G.FUNCS.TEOcean_ai_cache_manager()
                    else
                        print('[TEOcean] 清除Mod AI缓存失败:', mod_info.id)
                    end
                end
            end

            table.insert(mod_list_nodes, {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.05, minh = 0.6, r = 0.1, colour = G.C.BLACK, emboss = 0.05 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cl", padding = 0.1, minw = 8 },
                        nodes = {
                            { n = G.UIT.T, config = { text = mod_info.name, scale = 0.4, colour = G.C.WHITE, shadow = true } },
                            { n = G.UIT.T, config = { text = ' (' .. mod_info.card_count .. ')', scale = 0.35, colour = G.C.UI.TEXT_DARK } }
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = { align = "cr", padding = 0.1 },
                        nodes = {
                            UIBox_button({
                                button = button_func_name,
                                label = { localize('teo_clear_cache') or '清除' },
                                minw = 1.2,
                                minh = 0.5,
                                scale = 0.35,
                                colour = HEX('E76F51') -- Burnt Orange
                            })
                        }
                    }
                }
            })
        end
    end

    G.FUNCS.overlay_menu({
        definition = {
            n = G.UIT.ROOT,
            config = {
                align = "cm",
                minw = G.ROOM.T.w*5,
                minh = G.ROOM.T.h*5,
                padding = 0.1,
                r = 0.1,
                colour = G.C.BLACK
            },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { align = "cm", padding = 0.1, minh = 6, minw = 10 },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.2 },
                            nodes = {
                                { n = G.UIT.T, config = { text = localize('teo_ai_cache_manager') or 'AI缓存管理', scale = 0.5, colour = G.C.UI.TEXT_LIGHT } }
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.1 },
                            nodes = mod_list_nodes
                        },
                        #cached_mods > 0 and {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.2 },
                            nodes = {
                                UIBox_button({
                                    button = "TEOcean_clear_all_ai_cache",
                                    label = { localize('teo_clear_all_cache') or '清除全部AI缓存' },
                                    minw = 2.5,
                                    minh = 0.8,
                                    scale = 0.4,
                                    colour = HEX('E76F51') -- Burnt Orange
                                })
                            }
                        } or nil,
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.2 },
                            nodes = {
                                UIBox_button({
                                    button = "TEOcean_ai_cache_manager_exit",
                                    label = { localize('b_back') or '返回' },
                                    minw = 2.5,
                                    minh = 0.8,
                                    scale = 0.4,
                                    colour = HEX('2A9D8F') -- Teal Ocean
                                })
                            }
                        }
                    }
                }
            }
        }
    })
end

-- 退出AI缓存管理
G.FUNCS.TEOcean_ai_cache_manager_exit = function()
    if TEO and TEO.id and G.FUNCS["openModUI_" .. TEO.id] then
        G.FUNCS["openModUI_" .. TEO.id]()
    else
        G.FUNCS.exit_overlay_menu()
    end
end

-- 清除全部AI缓存
G.FUNCS.TEOcean_clear_all_ai_cache = function()
    if TEO_clear_all_ai_cache then
        local success = TEO_clear_all_ai_cache()
        if success then
            print('[TEOcean] 已清除全部AI缓存')
            -- 刷新弹窗
            G.FUNCS.TEOcean_ai_cache_manager()
        else
            print('[TEOcean] 清除全部AI缓存失败')
        end
    end
end
