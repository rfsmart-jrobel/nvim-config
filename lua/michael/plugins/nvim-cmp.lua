-- setup autocompletion
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				-- ["<Tab>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- source suggestions from lsp
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})

		-- load default vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- define custom snippets
		local snippetFileTypes = {
			"javascript",
			"typescript",
			"typescriptreact",
		}

		for _, fileType in ipairs(snippetFileTypes) do
			luasnip.add_snippets(fileType, {
				luasnip.snippet("tne", {
					luasnip.text_node("throw new Error("),
					luasnip.insert_node(1),
					luasnip.text_node(")"),
				}),
			})
		end

		for _, fileType in ipairs(snippetFileTypes) do
			luasnip.add_snippets(fileType, {
				luasnip.snippet("jsf", {
					luasnip.text_node("JSON.stringify("),
					luasnip.insert_node(1),
					luasnip.text_node(")"),
				}),
			})
		end

		for _, fileType in ipairs(snippetFileTypes) do
			luasnip.add_snippets(fileType, {
				luasnip.snippet("clg", {
					luasnip.text_node("console.log("),
					luasnip.insert_node(1),
					luasnip.text_node(")"),
				}),
			})
		end

		for _, fileType in ipairs(snippetFileTypes) do
			luasnip.add_snippets(fileType, {
				luasnip.snippet("dnl", {
					luasnip.text_node("// eslint-disable-next-line @stylistic/js/max-len"),
				}),
			})
		end
	end,
}
