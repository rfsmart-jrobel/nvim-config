return {
	"chentoast/marks.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		require("marks").setup({
			builtin_marks = { ".", "<", ">", "^" },
		})
	end,
}
