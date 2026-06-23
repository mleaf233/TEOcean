-- Edge widget: a compact right-edge control surface for quick translation actions.

TEO_EDGE_WIDGET_STATE = TEO_EDGE_WIDGET_STATE or {}

local state = TEO_EDGE_WIDGET_STATE

local EDGE_TRIGGER = 0.35
local EDGE_MARGIN = 0.12
local EDGE_HANDLE_W = 0.34
local EDGE_HANDLE_H = 0.92
local EDGE_OPEN_HOLD = 0.25
local EDGE_ANIM_SPEED = 12
local LOG_PREFIX = '[TEOcean Edge]'

state.log_times = state.log_times or {}
state.status_text = state.status_text or "无目标"

local function log_throttled(key, interval, ...)
    local now = G and G.TIMERS and G.TIMERS.REAL or 0
    if not state.log_times[key] or now - state.log_times[key] >= interval then
        state.log_times[key] = now
        print(LOG_PREFIX, ...)
        return true
    end
    return false
end

local function set_feedback(text, duration)
    state.status_text = text
    state.status_until = (G and G.TIMERS and G.TIMERS.REAL or 0) + (duration or 1.5)
end

local function get_default_status_text()
    local target = TEO_get_last_hovered_translation_target and TEO_get_last_hovered_translation_target() or nil
    return target and "有目标" or "无目标"
end

local function is_edge_widget_disabled()
    local mod = TEO_get_mod and TEO_get_mod() or TEO
    return mod and mod.config and mod.config.disable_edge_sidebar == true
end

local function refresh_status_text()
    local now = G and G.TIMERS and G.TIMERS.REAL or 0
    if state.status_until and now < state.status_until then return end
    state.status_until = nil
    state.status_text = get_default_status_text()
end

local function get_window_size()
    local window = G and G.WINDOWTRANS or nil
    local room = G and G.ROOM and G.ROOM.T or nil
    local fallback_w = (room and room.w or 20) + 2
    local fallback_h = (room and room.h or 11.5) + 1.4

    local scale = G and G.TILESCALE and G.TILESIZE and (G.TILESCALE * G.TILESIZE) or nil
    if scale and scale > 0 then
        local real_w = window and window.real_window_w or
            (love and love.graphics and love.graphics.getWidth and love.graphics.getWidth()) or nil
        local real_h = window and window.real_window_h or
            (love and love.graphics and love.graphics.getHeight and love.graphics.getHeight()) or nil
        if real_w and real_h then
            return real_w / scale, real_h / scale
        end
    end

    return window and window.w or fallback_w, window and window.h or fallback_h
end

local function get_room_offset()
    local room = G and G.ROOM and G.ROOM.T or nil
    return room and room.x or 0, room and room.y or 0
end

local function get_window_signature()
    local window = G and G.WINDOWTRANS or {}
    local room_x, room_y = get_room_offset()
    local window_w, window_h = get_window_size()
    return table.concat({
        tostring(window.real_window_w or ''),
        tostring(window.real_window_h or ''),
        tostring(window_w),
        tostring(window_h),
        tostring(G and G.TILESCALE or ''),
        tostring(room_x),
        tostring(room_y)
    }, ':')
end

local function get_block_reason()
    if not G then return 'missing G' end
    if not G.UIT then return 'missing G.UIT' end
    if not Moveable then return 'missing Moveable' end
    if not UIBox then return 'missing UIBox' end
    if not UIBox_button then return 'missing UIBox_button' end
    if not G.I then return 'missing G.I' end
    if not G.I.POPUP then return 'missing G.I.POPUP' end
    if G.OVERLAY_TUTORIAL then return 'tutorial overlay is open' end
    if G.screenwipe then return 'screenwipe is active' end
    return nil
end

local function rounded_polygon_points(vertices, radius, steps, dx, dy)
    local out = {}
    local count = #vertices
    steps = steps or 4
    dx = dx or 0
    dy = dy or 0

    for i = 1, count do
        local prev = vertices[((i - 2) % count) + 1]
        local cur = vertices[i]
        local next_v = vertices[(i % count) + 1]
        local to_prev_x = prev.x - cur.x
        local to_prev_y = prev.y - cur.y
        local to_next_x = next_v.x - cur.x
        local to_next_y = next_v.y - cur.y
        local prev_len = math.sqrt(to_prev_x * to_prev_x + to_prev_y * to_prev_y)
        local next_len = math.sqrt(to_next_x * to_next_x + to_next_y * to_next_y)

        if prev_len > 0 and next_len > 0 then
            local cut = math.min(radius, prev_len * 0.45, next_len * 0.45)
            local p1x = cur.x + to_prev_x / prev_len * cut
            local p1y = cur.y + to_prev_y / prev_len * cut
            local p2x = cur.x + to_next_x / next_len * cut
            local p2y = cur.y + to_next_y / next_len * cut

            out[#out + 1] = p1x + dx
            out[#out + 1] = p1y + dy

            for step = 1, steps do
                local t = step / steps
                local inv = 1 - t
                local x = inv * inv * p1x + 2 * inv * t * cur.x + t * t * p2x
                local y = inv * inv * p1y + 2 * inv * t * cur.y + t * t * p2y
                out[#out + 1] = x + dx
                out[#out + 1] = y + dy
            end
        else
            out[#out + 1] = cur.x + dx
            out[#out + 1] = cur.y + dy
        end
    end

    return out
end

local TEO_EdgeHandle = nil

local function create_edge_handle_object()
    if not TEO_EdgeHandle and Moveable then
        TEO_EdgeHandle = Moveable:extend()

        function TEO_EdgeHandle:init()
            Moveable.init(self, { T = { x = 0, y = 0, w = EDGE_HANDLE_W, h = EDGE_HANDLE_H } })
            self.states.drag.can = false
            self.states.collide.can = false
        end

        function TEO_EdgeHandle:draw()
            if not love or not love.graphics or not prep_draw then return end

            prep_draw(self, 1)
            love.graphics.scale(1 / G.TILESIZE)

            local w = self.VT.w * G.TILESIZE
            local h = self.VT.h * G.TILESIZE
            local left_top = h * 0.24
            local left_bottom = h * 0.76
            local radius = math.min(5, w * 0.38, h * 0.14)
            local vertices = {
                { x = 0, y = left_top },
                { x = w, y = 0 },
                { x = w, y = h },
                { x = 0, y = left_bottom }
            }

            if G.SETTINGS and G.SETTINGS.GRAPHICS and G.SETTINGS.GRAPHICS.shadows == 'On' then
                love.graphics.setColor(0, 0, 0, 0.28)
                love.graphics.polygon('fill', rounded_polygon_points(vertices, radius, 4, 2, 2))
            end

            love.graphics.setColor(G.C.UI.BACKGROUND_DARK)
            love.graphics.polygon('fill', rounded_polygon_points(vertices, radius, 4))

            love.graphics.setColor(G.C.UI.OUTLINE_LIGHT)
            love.graphics.setLineWidth(1.2)
            love.graphics.polygon('line', rounded_polygon_points(vertices, radius, 4))

            love.graphics.setColor(G.C.UI.TEXT_LIGHT)
            if state.open then
                love.graphics.polygon('fill',
                    w * 0.38, h * 0.35,
                    w * 0.38, h * 0.65,
                    w * 0.68, h * 0.50)
            else
                love.graphics.polygon('fill',
                    w * 0.64, h * 0.35,
                    w * 0.64, h * 0.65,
                    w * 0.34, h * 0.50)
            end

            love.graphics.pop()
        end
    end

    if TEO_EdgeHandle then
        return TEO_EdgeHandle()
    end
    return nil
end

local function build_edge_widget_definition()
    local handle_object = create_edge_handle_object()
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", colour = G.C.CLEAR, padding = 0 },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm", colour = G.C.CLEAR, padding = 0 },
                nodes = {
                    handle_object and {
                        n = G.UIT.O,
                        config = {
                            object = handle_object,
                            w = EDGE_HANDLE_W,
                            h = EDGE_HANDLE_H,
                            colour = G.C.WHITE,
                            can_collide = false
                        }
                    } or {
                        n = G.UIT.B,
                        config = {
                            w = EDGE_HANDLE_W,
                            h = EDGE_HANDLE_H,
                            colour = G.C.UI.BACKGROUND_DARK
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = {
                            align = "cm",
                            padding = 0.06,
                            r = 0.08,
                            colour = G.C.UI.BACKGROUND_DARK,
                            shadow = true
                        },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = "cm", padding = 0 },
                                nodes = {
                                    UIBox_button({
                                        label = { "重译" },
                                        button = "TEOcean_edge_retranslate",
                                        minw = 1.15,
                                        maxw = 1.0,
                                        minh = 0.58,
                                        scale = 0.36,
                                        colour = G.C.BLUE
                                    })
                                }
                            },
                            {
                                n = G.UIT.R,
                                config = { align = "cm", padding = 0.01, minw = 1.15 },
                                nodes = {
                                    {
                                        n = G.UIT.T,
                                        config = {
                                            text = state.status_text,
                                            scale = 0.22,
                                            colour = G.C.UI.TEXT_LIGHT,
                                            ref_table = state,
                                            ref_value = 'status_text',
                                            no_recalc = true
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
end

local function remove_edge_widget()
    if state.box and not state.box.REMOVED then
        state.box:remove()
    end
    if state.anchor and not state.anchor.REMOVED then
        state.anchor:remove()
    end
    state.box = nil
    state.anchor = nil
    state.open = false
    state.slide_offset = nil
end

local function update_anchor()
    if not Moveable then return nil end

    local window_w, window_h = get_window_size()
    local room_x, room_y = get_room_offset()
    local x = window_w - room_x
    local y = window_h * 0.5 - room_y

    if not state.anchor or state.anchor.REMOVED then
        state.anchor = Moveable({ T = { x = x, y = y, w = 0, h = 0 } })
        state.anchor.states.visible = false
        state.anchor.states.collide.can = false
        state.anchor.states.hover.can = false
        state.anchor.states.click.can = false
    elseif state.anchor.hard_set_T then
        state.anchor:hard_set_T(x, y, 0, 0)
    else
        state.anchor.T.x = x
        state.anchor.T.y = y
        state.anchor.VT.x = x
        state.anchor.VT.y = y
    end

    return state.anchor, window_w, window_h
end

local function get_slide_offsets(box)
    local shown_offset = -EDGE_MARGIN
    local hidden_offset = math.max(0, (box and box.T and box.T.w or 1.5) - EDGE_HANDLE_W)
    return shown_offset, hidden_offset
end

local function apply_widget_alignment(box, slide_offset, force_realign)
    if not box or not state.anchor then return end

    box:set_alignment({
        major = state.anchor,
        type = "cl",
        offset = { x = slide_offset, y = 0 },
        bond = 'Weak'
    })
    if force_realign and box.alignment then
        box.alignment.prev_type = ''
    end
    box:align_to_major()

    if box.hard_set_T then
        box:hard_set_T(box.T.x, box.T.y, box.T.w, box.T.h)
    else
        box.VT.x = box.T.x
        box.VT.y = box.T.y
    end

    if box.UIRoot and box.UIRoot.initialize_VT then
        box.UIRoot:initialize_VT()
    end
end

local function ensure_edge_widget()
    if state.box and not state.box.REMOVED then return state.box end
    if is_edge_widget_disabled() then return nil end

    local reason = get_block_reason()
    if reason then
        return nil
    end

    local anchor = update_anchor()
    if not anchor then return nil end

    local ok, box_or_err = pcall(function()
        return UIBox({
            T = { x = 0, y = 0, w = 1, h = 1 },
            definition = build_edge_widget_definition(),
            config = {
                parent = anchor,
                align = 'cl',
                offset = { x = 0, y = 0 },
                instance_type = 'POPUP',
                can_collide = false
            }
        })
    end)
    if not ok then
        log_throttled('create_error', 1.0, 'create failed:', tostring(box_or_err))
        return nil
    end

    state.box = box_or_err
    local _, hidden_offset = get_slide_offsets(state.box)
    state.slide_offset = hidden_offset
    apply_widget_alignment(state.box, state.slide_offset, true)
    return state.box
end

local function promote_edge_widget_popup()
    if not state.box or state.box.REMOVED or not G or not G.I or not G.I.POPUP then return end

    local current_index = nil
    for i, popup in ipairs(G.I.POPUP) do
        if popup == state.box then
            current_index = i
            break
        end
    end

    if current_index and current_index < #G.I.POPUP then
        table.remove(G.I.POPUP, current_index)
        table.insert(G.I.POPUP, state.box)
    elseif not current_index then
        table.insert(G.I.POPUP, state.box)
    end
end

local function get_widget_hit_state(box, cursor)
    if not box or not cursor then
        return false, false, false
    end

    local room_x, room_y = get_room_offset()
    local left = box.T.x + room_x
    local top = box.T.y + room_y
    local right = left + box.T.w
    local bottom = top + box.T.h
    local handle_right = left + EDGE_HANDLE_W
    local over_handle = cursor.x >= left and cursor.x <= handle_right and cursor.y >= top and cursor.y <= bottom
    local over_panel = cursor.x > handle_right and cursor.x <= right and cursor.y >= top and cursor.y <= bottom
    return over_handle or over_panel, over_handle, over_panel
end

local function invoke_retranslate(source)
    local now = G and G.TIMERS and G.TIMERS.REAL or 0
    if state.last_click_at and now - state.last_click_at < 0.2 then return end
    state.last_click_at = now

    if play_sound then pcall(play_sound, 'button', 1, 0.3) end
    if G and G.ROOM then G.ROOM.jiggle = (G.ROOM.jiggle or 0) + 0.25 end
    local target = TEO_get_last_hovered_translation_target and TEO_get_last_hovered_translation_target() or nil
    if not target then
        set_feedback("无目标", 1.8)
        return
    end

    set_feedback("请求中", 1.2)
    local ok = false
    if TEO_retranslate_last_hovered_card then
        ok = TEO_retranslate_last_hovered_card() == true
    else
        print('[TEOcean AI] 重译功能尚未加载')
    end

    if ok then
        set_feedback("已发送", 2.0)
    else
        set_feedback("未发送", 2.0)
    end
end

function TEO_edge_widget_update(dt)
    state.update_count = (state.update_count or 0) + 1
    refresh_status_text()

    if is_edge_widget_disabled() then
        remove_edge_widget()
        return
    end

    local reason = get_block_reason()
    if reason then
        remove_edge_widget()
        return
    end

    local anchor, window_w, window_h = update_anchor()
    local box = ensure_edge_widget()
    local cursor = G and G.CURSOR and G.CURSOR.T or nil
    if not anchor or not box then return end
    if not cursor then return end

    local shown_offset, hidden_offset = get_slide_offsets(box)
    local threshold = window_w - EDGE_TRIGGER
    local over_widget, _, over_panel = get_widget_hit_state(box, cursor)
    local near_edge = cursor.x >= threshold
    local window_signature = get_window_signature()
    local layout_changed = state.window_signature and state.window_signature ~= window_signature
    state.window_signature = window_signature

    local now = G and G.TIMERS and G.TIMERS.REAL or 0
    if near_edge or over_widget then
        state.last_active_at = now
    end

    local should_open = near_edge or over_widget or
        (state.last_active_at and now - state.last_active_at <= EDGE_OPEN_HOLD)
    local target_offset = should_open and shown_offset or hidden_offset

    state.open = should_open
    box.states.collide.can = should_open

    state.slide_offset = state.slide_offset or hidden_offset
    if layout_changed then
        state.slide_offset = target_offset
    else
        local move_dt = dt or (G and G.real_dt) or 1 / 60
        local t = 1
        if not (G and G.SETTINGS and G.SETTINGS.reduced_motion) then
            t = math.min(1, math.max(0, move_dt * EDGE_ANIM_SPEED))
        end
        state.slide_offset = state.slide_offset + (target_offset - state.slide_offset) * t
        if math.abs(state.slide_offset - target_offset) < 0.01 then state.slide_offset = target_offset end
    end
    apply_widget_alignment(box, state.slide_offset, layout_changed)
    promote_edge_widget_popup()

    local mouse_down = love and love.mouse and love.mouse.isDown and love.mouse.isDown(1)
    if should_open and over_panel and mouse_down and not state.mouse_down then
        invoke_retranslate('fallback')
    end
    state.mouse_down = mouse_down == true
end

G.FUNCS = G.FUNCS or {}

G.FUNCS.TEOcean_edge_retranslate = function()
    invoke_retranslate('button')
end

if Game and Game.update and not state.hooked then
    state.update_ref = Game.update
    Game.update = function(self, dt)
        local result = state.update_ref(self, dt)
        if TEO_edge_widget_update then
            local ok, err = pcall(TEO_edge_widget_update, dt)
            if not ok then
                log_throttled('update_error', 1.0, 'update error:', tostring(err))
            end
        end
        return result
    end
    state.hooked = true
elseif not state.hooked then
    log_throttled('hook_missing', 1.0, 'Game.update hook not installed')
end
