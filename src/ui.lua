-- 现在UI界面大部分都是改自smod，所以有很多按钮都是不对的，目前只有勾选框是正常工作的，TODO：改UI对应按钮的回调逻辑

TEO = SMODS.current_mod
TEO.GUI = {}
TEO.LAST_VIEWED_MODS_PAGE = nil


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
    local modsRowPerPage = 1
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
    TEO_init_configs()
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
                                                if modInfo.should_teo_localize then
                                                    -- 勾选：执行合并
                                                    print(('[TEOcean] 开始为 %s 执行本地化合并'):format(modInfo.id))
                                                    local ok, err = pcall(merge_impl_mod_localizations_for_mod, modInfo)
                                                    if ok then
                                                        print(('[TEOcean] %s 本地化合并完成'):format(modInfo.id))
                                                    else
                                                        print(('[TEOcean] %s 本地化合并失败: %s'):format(modInfo.id,
                                                            tostring(err)))
                                                    end
                                                else
                                                    -- 取消勾选：恢复原始本地化
                                                    print(('[TEOcean] 开始为 %s 恢复原始本地化'):format(modInfo.id))
                                                    local ok, err = pcall(restore_original_localization_for_mod, modInfo)
                                                    if ok then
                                                        print(('[TEOcean] %s 本地化恢复完成'):format(modInfo.id))
                                                    else
                                                        print(('[TEOcean] %s 本地化恢复失败: %s'):format(modInfo.id,
                                                            tostring(err)))
                                                    end
                                                end
                                                -- 保存配置
                                                -- 更新配置表
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
    -- 检查当前配置与初始配置是否一致
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
        -- 也要检查反向，防止从nil变为false/true的情况（虽然这里主要是clicked_list变动）
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
        -- 执行手动重载
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

G.FUNCS.TEOcean_adapted_mods_button = function()
    G.SETTINGS.paused = true
    SMODS.LAST_SELECTED_MOD_TAB = nil
    -- 保存初始配置状态以供退出时对比
    TEO.initial_config_state = copy_table(TEO.config.clicked_list or {})

    G.FUNCS.overlay_menu({
        definition = TEO_create_UIBox_mods_button()
    })
end
