local mod = assert(SMODS.current_mod, 'TEOcean must be loaded through SMODS')

-- Existing modules use TEO as their shared mod state and UI namespace.
TEO = mod

if SMODS.Atlas then
    SMODS.Atlas({
        key = 'modicon',
        path = 'logo.png',
        px = 32,
        py = 32
    })
end

local function load_module(path)
    local chunk, err = SMODS.load_file('src/' .. path .. '.lua')
    assert(chunk, ('Failed to load TEOcean module %s: %s'):format(path, tostring(err)))
    return chunk()
end

load_module('utils')
TEO_init_configs()

load_module('localization_compat')
load_module('localization')
load_module('ai_provider_adapter')
load_module('ui')
load_module('original_translation')
load_module('story')
load_module('ai_manager')
load_module('ai_translation')
load_module('edge_widget')
load_module('llm_demo')
load_module('config_ui')
load_module('lifecycle')

TEO_install_lifecycle(mod)

print('[TEOcean Language Packs] TEOcean 适配的汉化语言包预处理完成 尽情享受游戏吧！')
