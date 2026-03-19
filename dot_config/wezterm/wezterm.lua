local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"

config.window_background_opacity = 0.9

config.use_ime = false
-- config.enable_wayland = false

config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.font = wezterm.font_with_fallback({
	{ family = "UDEV Gothic 35NF" },
	"JetBrains Mono",
	"Noto Color Emoji",
})
config.font_size = 14
-- config.dpi = 96.0

config.disable_default_key_bindings = true

local act = wezterm.action
config.keys = {
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = act.PasteFrom("Clipboard"),
	},
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = act.CopyTo("ClipboardAndPrimarySelection"),
	},
	{
		key = "n",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SpawnWindow,
	},
	{
		key = "f",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ToggleFullScreen,
	},
}

return config
