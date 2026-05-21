return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")
			local opts = { buffer = bufnr }

			opts.desc = "Gitsigns: diff current buffer"
			vim.keymap.set("n", "<leader>gd", gitsigns.diffthis, opts)

			opts.desc = "Gitsigns: toggle current line blame"
			vim.keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame, opts)

			opts.desc = "Gitsigns: toggle full current line blame"
			vim.keymap.set("n", "<leader>gB", function()
				gitsigns.blame_line({ full = true })
			end, opts)

			opts.desc = "Gitsigns: stage current hunk"
			vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, opts)

			opts.desc = "Gitsigns: stage current buffer"
			vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, opts)
		end,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 100,
			ignore_whitespace = false,
			virt_text_priority = 100,
			use_focus = true,
		},
	},
}
