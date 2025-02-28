local wezterm = require 'wezterm'

local config = wezterm.config_builder()



-- font appearance
config.color_scheme = 'Gruvbox Dark (Gogh)'
config.font = wezterm.font('EnvyCodeR Nerd Font', { weight = 'Regular', italic = false })
config.font = wezterm.font_with_fallback {
    'Envy Code R',
    'Consolas',
}
config.font_size = 17.0
config.line_height = 1.0
config.bold_brightens_ansi_colors = false
-- no bold
config.font_rules = {
    {
        intensity = 'Bold',
        font = wezterm.font 'EnvyCodeR Nerd Font',
    }
}


-- window appearance
config.window_padding = {
    left = 0, right = 0,
    top = 10, bottom = 0,
}

config.use_fancy_tab_bar = false
config.window_decorations = 'RESIZE'
config.window_close_confirmation = 'NeverPrompt'
config.tab_max_width = 32
config.window_frame = {
    font = wezterm.font { family = 'Roboto', weight = 'Bold' },
    font_size = 12.0,
    active_titlebar_bg = '#333333',
    inactive_titlebar_bg = '#333333',
}

config.colors = {
    tab_bar = {
        background = '#101010',
        active_tab = {
            bg_color = '#282828',
            fg_color = '#ebdbb2',
            intensity = 'Normal',
            underline = 'None',
            italic = false,
            strikethrough = false,
        },
        inactive_tab = {
            bg_color = '#101010',
            fg_color = '#a89984',
        },
        inactive_tab_hover = {
            bg_color = '#181818',
            fg_color = '#bdae93',
            italic = false,
        },
        new_tab = {
            bg_color = '#101010',
            fg_color = '#a89984',
        },
        new_tab_hover = {
            bg_color = '#181818',
            fg_color = '#bdae93',
            italic = false,
        },
    },
}


config.keys = {
    {
        key = 'w',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
        key = 'w',
        mods = 'ALT|SHIFT',
        action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
        key = 'phys:1',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SpawnTab 'DefaultDomain',
    },
    {
        key = 'phys:2',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SpawnTab { DomainName = 'WSL:Ubuntu' },
    },
}
config.enable_kitty_keyboard = true

for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

config.wsl_domains = {
    {
        name = 'WSL:Ubuntu',
        distribution = 'Ubuntu',
    },
}

for _, dom in ipairs(config.wsl_domains) do
    dom.default_cwd = '~'
end

return config
