-- adds file explorer
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation. Seems to remove netrw. Not cool.
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- Default mappings
			api.config.mappings.default_on_attach(bufnr)

			vim.schedule(function()
				vim.opt_local.wrap = true
			end)

			-- Override TAB to open the file WITHOUT switching focus to the editor
			-- 'edit' normally switches focus, so we jump back immediately
			vim.keymap.set("n", "<Tab>", function()
				api.node.open.edit()
				vim.cmd("wincmd p")
			end, opts("Open and Keep Focus"))

			vim.keymap.set("n", "fg", function()
				local node = api.tree.get_node_under_cursor()
				-- If it's a file, get the parent directory; if it's a directory, use it
				local path = node.type == "directory" and node.absolute_path
					or vim.fn.fnamemodify(node.absolute_path, ":h")

				-- Launch telescope live_grep in that specific path
				require("telescope.builtin").live_grep({
					search_dirs = { path },
					prompt_title = "Grep in " .. vim.fn.fnamemodify(path, ":t"),
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--sort",
						"path",
					},
				})
			end, opts("Grep in Directory"))
		end

		nvimtree.setup({
			view = {
				width = 50,
				relativenumber = true,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							-- arrow_closed = "", -- arrow when folder is closed
							arrow_closed = "", -- arrow when folder is closed
							-- arrow_open = "", -- arrow when folder is open
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
			on_attach = my_on_attach,
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
