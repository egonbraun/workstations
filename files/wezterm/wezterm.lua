local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ----------------------------------------------------------------------------
-- GENERAL
-- ----------------------------------------------------------------------------

config.audible_bell = "Disabled"
config.check_for_updates = true
config.window_close_confirmation = "NeverPrompt"

-- ----------------------------------------------------------------------------
-- FONT
-- ----------------------------------------------------------------------------

config.font = wezterm.font("Inconsolata LGC Nerd Font")
config.font_size = 12.0

config.adjust_window_size_when_changing_font_size = false
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
config.warn_about_missing_glyphs = false

config.harfbuzz_features = {
    "zero", -- Use a slashed zero '0' (instead of dotted)
    "kern", -- kerning
    "liga", -- ligatures
    "clig", -- contextual ligatures
}

-- ----------------------------------------------------------------------------
-- KEY BINDINGS
-- ----------------------------------------------------------------------------
--
config.keys = {
    {
        key = "d",
        mods = "CMD",
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "D",
        mods = "CMD",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
}

for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "ALT",
        action = wezterm.action.ActivateTab(i - 1),
    })
end

-- ----------------------------------------------------------------------------
-- APPEARANCE
-- ----------------------------------------------------------------------------

config.color_scheme = "Dracula"
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"

config.inactive_pane_hsb = {
    saturation = 0.6,
    brightness = 0.3,
}

config.window_padding = {
    left = 30,
    right = 30,
    top = 30,
    bottom = 30,
}

config.colors = {
    tab_bar = {
        background = "#282a36",

        active_tab = {
            bg_color = "#bd93f9",
            fg_color = "#282a36",
        },

        inactive_tab = {
            bg_color = "#282a36",
            fg_color = "#f8f8f2",
        },

        inactive_tab_hover = {
            bg_color = "#6272a4",
            fg_color = "#f8f8f2",
            italic = true,
        },

        new_tab = {
            bg_color = "#282a36",
            fg_color = "#f8f8f2",
        },

        new_tab_hover = {
            bg_color = "#ff79c6",
            fg_color = "#f8f8f2",
            italic = true,
        },
    },
}

-- ----------------------------------------------------------------------------

return config
