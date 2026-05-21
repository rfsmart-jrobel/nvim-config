-- adds fuzzy finder/search capabilities
return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"sharkdp/fd",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{
			"nvim-telescope/telescope-frecency.nvim",
			version = "*",
		},
		-- "folke/todo-comments.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				layout_strategy = "horizontal",
				-- show preview no matter the terminal column width
				layout_config = {
					prompt_position = "top",
					horizontal = {
						preview_cutoff = 0,
					},
				},
				sorting_strategy = "ascending",
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist, -- "smart" will add everything to quickfix if nothing is selected or just selections if they are present
						["<C-h>"] = "which_key",
					},
					n = {
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
				frecency = {
					enable_prompt_mappings = true,
					matcher = "default", -- options: "fuzzy" | "default"
					show_scores = false,
					show_unindexed = true, -- Shows files not yet in the database
					db_root = vim.fn.stdpath("data"), -- Explicitly set database location
					workspaces = {
						--  utilize with syntax: ":code:"
						--  alternatively, ":<tab>" to open list
						["code"] = vim.fn.expand("~/Code/RF-SMART/netsuite"),
						["unit"] = vim.fn.expand("~/Code/RF-SMART/test/unit"),
						["int"] = vim.fn.expand("~/Code/RF-SMART/test/integration"),
					},
				},
			},
		})

		telescope.load_extension("fzf") -- fuzzy finder sorting algorithm that replace default lua sorter
		telescope.load_extension("frecency") -- applies frequency-based scoring (using internal frequency database) prior to handing off results to fzf
		telescope.load_extension("live_grep_args") -- allows you to pass arguments (for file types, directories, etc.) to ripgrep during global searches

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		vim.keymap.set("n", "<leader>ff", function()
			telescope.extensions.frecency.frecency({
				workspace = "CWD",
			})
		end, { desc = "Find File (by name)" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		-- keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find grep string in cwd" })
		-- run "Man rg" to see params to pass to live_grep
		vim.keymap.set("n", "<leader>fG", function()
			require("telescope").extensions.live_grep_args.live_grep_args()
		end, { desc = "Find with Grep (Advanced)" })
		vim.keymap.set("n", "<leader>fg", function()
			builtin.live_grep()
		end, { desc = "Find with Grep" })
		vim.keymap.set("n", "<leader>fd", function()
			builtin.live_grep({
				search_dirs = { vim.fn.expand("%:p:h") },
			})
		end, { desc = "Find in current Directory" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find document symbols" })
		keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope: view git status for all files" })
		-- keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
	end,
}
