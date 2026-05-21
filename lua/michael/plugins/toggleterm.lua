return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			direction = "float",
			float_opts = {
				border = "rounded",
			},
			start_in_insert = false,
			auto_scroll = false,
		})

		-- Make <Esc> leave terminal mode
		vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

		vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Terminal Toggle" })
		vim.keymap.set("n", "<leader>tf", "<cmd>1ToggleTerm<CR>", { desc = "Terminal Floating (toggle)" })
		vim.keymap.set("n", "<leader>tF2", "<cmd>2ToggleTerm<CR>", { desc = "Terminal Floating (toggle)" })
		vim.keymap.set("n", "<leader>tF3", "<cmd>3ToggleTerm<CR>", { desc = "Terminal Floating (toggle)" })
		vim.keymap.set("n", "<leader>tF4", "<cmd>4ToggleTerm<CR>", { desc = "Terminal Floating (toggle)" })
		vim.keymap.set("n", "<leader>tF5", "<cmd>5ToggleTerm<CR>", { desc = "Terminal Floating (toggle)" })
		vim.keymap.set("n", "<leader>ts", function()
			vim.cmd("9ToggleTerm direction=vertical size=60")
		end, { desc = "Terminal Sidebar (toggle)" })
	end,
}
