local wezterm = require("wezterm")
return {
	initial_cols = 150,
	initial_rows = 40,
	window_padding = { left = 5, right = 5, top = 5, bottom = 0 },
	window_background_opacity = 0.8,
	enable_tab_bar = false,
	debug_key_events = true,
	front_end = "WebGpu",

	font = wezterm.font("CommitMono Nerd Font Mono"),
	font_size = 16,
	line_height = 1.3,

	keys = {
		{ key = "Backspace", mods = "CTRL", action = wezterm.action.SendKey({ key = "w", mods = "CTRL" }) },
	},
}
