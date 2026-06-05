return {
	"folke/snacks.nvim",
	opts = {
		bigfile = { enabled = false },
		notifier = { enabled = false },
		quickfile = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		styles = {},

		picker = {
			enabled = true,
			win = {
				input = {
					keys = {
						["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
						["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
					},
				},
			},
		},
	},
	keys = {
		-- {
		-- 	"<leader>gB",
		-- 	function()
		-- 		Snacks.picker.git_branches()
		-- 	end,
		-- 	desc = "Git Branches",
		-- },
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log (current file)",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Buffer Delete",
		},
		{
			"<leader>bD",
			function()
				Snacks.bufdelete.other()
			end,
			desc = "Buffer Delete (inverse)",
		},
	},
}
