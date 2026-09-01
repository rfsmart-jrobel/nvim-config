-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.enable_kitty_keyboard = true

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.font_size = 12
config.color_scheme = "Afterglow"

config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.keys = {
	{
		key = "T",
		mods = "CMD|SHIFT", -- Change to 'CTRL|SHIFT' for Linux/Windows
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab:",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "K",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "+",
		mods = "CMD",
		action = wezterm.action.IncreaseFontSize,
	},
	{
		key = "Delete",
		mods = "NONE",
		action = wezterm.action.SendString("\x1b[3~"),
	},
}

-- Finally, return the configuration to wezterm:
return config
