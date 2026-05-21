return {
	"aug6th/cursoragent.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("cursoragent").setup({
			-- Terminal Window Settings
			terminal = {
				split_side = "right", -- "left" or "right"
				split_width_percentage = 0.4, -- Screen ratio (0.0 to 1.0)
				provider = "native", -- "auto", "snacks", "native", "external", "none"
				auto_close = true, -- Close terminal window when process exits
				show_native_term_exit_tip = true, -- Show tip about Ctrl-\ Ctrl-N
				git_repo_cwd = true, -- Set CWD to Git root when opening in a Git project
			},

			-- MCP Server Settings
			auto_start = true, -- Automatically start MCP server
			port_range = { min = 10000, max = 65535 },
			log_level = "info", -- "trace", "debug", "info", "warn", "error"

			-- Selection Tracking
			track_selection = true, -- Auto-track visual selections
			focus_after_send = false, -- Focus terminal after sending selection
			visual_demotion_delay_ms = 50, -- Delay before demoting visual selection

			-- Connection Settings
			connection_wait_delay = 600, -- Wait time after connection (ms)
			connection_timeout = 10000, -- Max time to wait for connection (ms)
			queue_timeout = 5000, -- Max time to keep @ mentions in queue (ms)

			-- Diff Settings
			diff_opts = {
				layout = "vertical", -- "vertical" or "horizontal"
				open_in_new_tab = false, -- Open diff in new tab
				keep_terminal_focus = false, -- Keep focus in terminal after diff opens
				hide_terminal_in_new_tab = false, -- Hide terminal in new diff tab
				on_new_file_reject = "keep_empty", -- "keep_empty" or "close_window"
			},

			-- Command Settings (optional)
			terminal_cmd = nil, -- Use default "cursor-agent" or specify custom path
			env = {}, -- Custom environment variables

			-- Command variants (for backward compatibility)
			command_variants = {
				agent = "agent",
				ask = "ask",
				plan = "plan",
				resume = "--resume",
			},
		})

		-- vim.keymap.set("n", "<leader>aa", "<cmd>CursorAgent<CR>", { noremap = true, silent = true })
	end,
}
