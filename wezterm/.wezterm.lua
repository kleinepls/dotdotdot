local wezterm = require("wezterm")
return {
	initial_cols = 150,
	initial_rows = 40,
	window_padding = { left = 5, right = 5, top = 5, bottom = 0 },
	window_background_opacity = 0.8,
	enable_tab_bar = false,
	debug_key_events = true,
	front_end = "WebGpu",
	warn_about_missing_glyphs = false,

	font = wezterm.font("JuliaMono Nerd Font Mono"),
	font_size = 16,
	line_height = 1.1,

	harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- turn off the disgusting ligatures

	keys = {
		{ key = "Backspace",  mods = "CTRL", action = wezterm.action.SendKey({ key = "w", mods = "CTRL" }) },

		{ key = 'LeftArrow',  mods = 'OPT',  action = wezterm.action.SendString '\x1b[1;5D' },
		{ key = 'RightArrow', mods = 'OPT',  action = wezterm.action.SendString '\x1b[1;5C' },
	},
}
