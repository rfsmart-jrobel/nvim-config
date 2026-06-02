return {
	"sindrets/diffview.nvim",
	event = "VeryLazy",
	config = function()
		require("diffview").setup({
			file_panel = {
				win_config = { position = "right" },
			},
		})
	end,
}
