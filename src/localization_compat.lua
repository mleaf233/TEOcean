-- Localization compatibility adapters
--
-- Some mods pass lightweight localization targets to generate_card_ui:
--     { set = "...", key = "...", vars = {...} }
--
-- These targets may not carry center.mod / mod_id and may not be registered in
-- SMODS.Centers. Other mods select a different localization key at render time.
-- Keep those known exceptions here so the normal AI translation path remains
-- independent from individual mod implementations.

local localization_compat_resolvers = {}

local function is_mod_active(mod_id)
    local target_mod = SMODS and SMODS.Mods and SMODS.Mods[mod_id]
    return target_mod and target_mod.can_load == true
end

-- Menthol optionally renders <base_key>_flavor instead of the Center's base key.
local function resolve_menthol_localization(center, target)
    if target.mod_id ~= 'Menthol' then return end

    local flavor_key = tostring(target.loc_key) .. '_flavor'
    local descriptions = G and G.localization and G.localization.descriptions
    local set_descriptions = descriptions and descriptions[target.set_key]

    if MINTY and MINTY.config and MINTY.config.flavor_text and
        set_descriptions and set_descriptions[flavor_key] then
        target.loc_key = flavor_key
        target.reason = 'menthol_flavor_key'
    end
end

-- Aikoyori's Shenanigans creates some info_queue entries as unregistered
-- { set, key, vars } tables. Their unique akyrs namespace is the only ownership
-- information available when generate_card_ui receives the nested entry.
local function resolve_aikoyori_localization(center, target)
    if target.mod_id ~= nil or not is_mod_active('aikoyorisshenanigans') then return end

    local key = center and center.key
    if type(key) ~= 'string' then return end

    local belongs_to_aikoyori = key:sub(1, 6) == 'akyrs_' or key:find('_akyrs_', 1, true) ~= nil
    if belongs_to_aikoyori then
        target.mod_id = 'aikoyorisshenanigans'
        target.reason = 'aikoyori_key_namespace'
    end
end

localization_compat_resolvers[#localization_compat_resolvers + 1] = resolve_menthol_localization
localization_compat_resolvers[#localization_compat_resolvers + 1] = resolve_aikoyori_localization

--- Apply known mod compatibility rules to a standard localization target.
--- Adapters only resolve identity/set/key. They must not read localization files,
--- issue AI requests, mutate G.localization, or call arbitrary mod loc_vars.
--- @param center table generate_card_ui Center or lightweight info_queue target
--- @param target table|nil { mod_id = string|nil, set_key = string|nil, loc_key = string|nil }
--- @return table resolved_target
function TEO_resolve_localization_compat(center, target)
    target = target or {}
    target.set_key = target.set_key or (center and center.set)
    target.loc_key = target.loc_key or (center and center.key)

    for _, resolver in ipairs(localization_compat_resolvers) do
        resolver(center, target)
    end

    if target.reason and TEO_dbg_print then
        TEO_dbg_print(
            '[TEOcean Compat] Resolved localization target:',
            target.reason,
            tostring(target.mod_id),
            tostring(target.set_key),
            tostring(target.loc_key)
        )
    end

    return target
end
