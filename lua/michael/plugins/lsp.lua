return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp", -- facilitates communication between lsp and autocompletion
		{ "antosha417/nvim-lsp-file-operations", config = true }, -- modify imports when files have been renamed
		{ "folke/neodev.nvim", opts = {} }, -- add improved lua lsp functionality
	},
	event = { "BufReadPre", "BufNewFile" },
	--[[
	   Context:
	   - Mason is reponsible for downloading LSP (as well as linters, formatters, etc.)
	   - mason-lspconfig acts as a bridge between mason by:
	     1. mapping package names from mason to nvim-lspconfig
	     2. can automatically setup installed lsp servers
	       - I elect out of this because I wish to extend capabilities with manual config.
	       - Failing to recognize this at first lead to multiple LSP instances running, the active one
	         being the one mason-lspconfig automatically setup without custom config (specifying "vim"
	         keyword as a globally recognized keyword)
	  - nvim-lspconfig is the core plugin that configures and connects LSP servers with Neovim's built-in
	    LSP client
	 ]]
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"ts_ls",
				"lua_ls",
				"jsonls",
				"html",
				"cssls",
				"marksman",
				"eslint",
			},
			automatic_enable = true, -- nvim's native lsp client seems to prevent duplicate servers from running that I was experiencing before
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		---------------- setup LSPs with default configs -------------
		local standard_config_servers = {
			"ts_ls",
			"eslint",
			"jsonls",
			"cssls",
			"marksman",
		}

		for _, server in ipairs(standard_config_servers) do
			vim.lsp.config(server, {
				capabilities = capabilities, -- allows autocompletion to source LSP data
			})
		end

		------------------------ setup LSPs with custom configs --------------------
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		vim.lsp.config("html", {
			capabilities = capabilities,
			settings = {
				html = {
					format = {
						extraLiners = "", -- Empty string prevents extra lines around html tags
					},
				},
			},
		})
		----------------------------------------------------------------------------
		vim.diagnostic.config({
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			-- add persistent trailing diagnostic information to the end of line
			-- virtual_text = {
			-- 	prefix = "●",
			-- },
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
			-- Change the Diagnostic symbols in the sign column (gutter) - working on mac but not on linux
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
				-- changes entire line highlight to metch tye type of diagnostic
				-- linehl = {
				-- 	[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
				-- 	[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
				-- 	[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
				-- 	[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
				-- },
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local bufnr = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id) or { name = "" }
				local opts = { buffer = bufnr, silent = true }

				opts.desc = "LSP: Show definitions"
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

				opts.desc = "LSP: Go to declaration"
				vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "LSP: Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "LSP: Show documentation for what is under cursor"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "LSP: Show implementations"
				vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "LSP: Show type definitions"
				vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "LSP: See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "LSP: Smart rename"
				vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "LSP: View line diagnostics"
				vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts) -- view diagnostics for line

				opts.desc = "LSP: View buffer diagnostics"
				vim.keymap.set("n", "<leader>vD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- view  diagnostics for file

				opts.desc = "LSP: Go to previous diagnostic"
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "LSP: Go to next diagnostic"
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "LSP: Restart LSP"
				vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

				-- client.server_capabilities.semanticTokensProvider = nil -- prevent LSP highlighting

				-- Disable formatting capability for ts_ls so as to not conflict with eslint
				-- if client.name == "ts_ls" then
				-- 	client.server_capabilities.documentFormattingProvider = false
				-- vim.api.nvim_create_autocmd("BufWritePre", {
				-- 	callback = function()
				-- 		vim.lsp.buf.format()
				-- 	end,
				-- })
				-- end
			end,
		})
	end,
}
