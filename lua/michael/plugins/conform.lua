return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
			format_after_save = {
				-- prefer conform formatters for file types (immediately falls back to LSP if a formatter doesn't exist for file type so no lag)
				lsp_format = "fallback", -- prefer formatting with configured formatters_by_ft above
				timeout_ms = 200,
				filter = function(client) -- only run on LSP fallback to decide which LSP to format with
					local bufnr = vim.api.nvim_get_current_buf()
					local clients = vim.lsp.get_clients({ bufnr = bufnr })
					local eslint_lsp_is_attached_to_buffer = vim.iter(clients):any(function(c)
						return c.name == "eslint"
					end)

					-- prevent ts_ls LSP from formatting on save if we can instead use eslint
					if client.name == "ts_ls" and eslint_lsp_is_attached_to_buffer then
						return false
					end

					-- allow LSP formatting for all other LSPs and for ts_ls if no eslint
					return true
				end,
			},
		})

		-- vim.keymap.set("n", "<leader>mp", function()
		-- 	conform.format({
		-- 		lsp_fallback = true,
		-- 		async = false,
		-- 		timeout_ms = 200,
		-- 	})
		-- end, { desc = "Format file or range (in visual mode)" })
	end,
}
