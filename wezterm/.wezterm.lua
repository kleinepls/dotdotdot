local wezterm = require("wezterm")

local config = {
	default_cwd = "~/code",
	initial_cols = 150,
	initial_rows = 40,
	window_padding = { left = 5, right = 5, top = 5, bottom = 0 },
	window_background_opacity = 0.8,
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = true,
	switch_to_last_active_tab_when_closing_tab = true,
	show_new_tab_button_in_tab_bar = false,
	enable_tab_bar = true,
	debug_key_events = true,
	use_ime = false,

	font_size = 18,
	line_height = 1.3,

	keys = {
		{ key = "Backspace", mods = "CTRL", action = wezterm.action.SendKey({ key = "w", mods = "CTRL" }) },

		{ key = ";", mods = "CTRL", action = wezterm.action.SendString("\x1b[59;5u") },
		{ key = "6", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
		{ key = ";", mods = "CTRL", action = wezterm.action.SendString("\x1b[59;5u") },
		{ key = "^", mods = "CTRL", action = wezterm.action.SendString("\x1e") },
		{ key = "6", mods = "CTRL", action = wezterm.action.SendString("\x1e") },

		{ key = "h", mods = "ALT", action = wezterm.action.SendKey({ key = "h", mods = "ALT" }) }, -- enables <A-h|j|k|l> mappings for nvim and tmux
		{ key = "j", mods = "ALT", action = wezterm.action.SendKey({ key = "j", mods = "ALT" }) },
		{ key = "k", mods = "ALT", action = wezterm.action.SendKey({ key = "k", mods = "ALT" }) },
		{ key = "l", mods = "ALT", action = wezterm.action.SendKey({ key = "l", mods = "ALT" }) },

		{ key = "q", mods = "ALT", action = wezterm.action.SendKey({ key = "q", mods = "ALT" }) },
		{ key = "w", mods = "ALT", action = wezterm.action.SendKey({ key = "w", mods = "ALT" }) },
		{ key = "e", mods = "ALT", action = wezterm.action.SendKey({ key = "e", mods = "ALT" }) },
		{ key = "r", mods = "ALT", action = wezterm.action.SendKey({ key = "r", mods = "ALT" }) },
		{ key = "t", mods = "ALT", action = wezterm.action.SendKey({ key = "t", mods = "ALT" }) },
	},

	window_close_confirmation = "NeverPrompt",

	-- font = wezterm.font('FiraMono Nerd Font Mono'),
	font = wezterm.font("CommitMono Nerd Font Mono"),
	front_end = "WebGpu",
}

return config
