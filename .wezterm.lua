-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = "nord"
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 20

config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.default_prog = { "/opt/homebrew/bin/tmux" }

config.window_decorations = "RESIZE"

-- and finally, return the configuration to wezterm
return config
