return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" }, -- only need treesitter when opening a new or existing buffer
	build = ":TSUpdate", -- updates all language parsers update when this plugin is updated
	dependencies = {
		"windwp/nvim-ts-autotag", -- provides auto-closing functionality for tags
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			modules = {},
			sync_install = false,
			ignore_install = {},
			auto_install = true,
			highlight = {
				enable = true,
			},
			-- enable indentation (appears to mess around with fn layer indentation)
			-- indent = { enable = true },
			-- ensure these language parsers are installed
			ensure_installed = {
				"bash",
				"css",
				"diff",
				"gitignore",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"query",
				"sql",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})

		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = true, -- Auto close on trailing </
			},
		})
	end,
}
