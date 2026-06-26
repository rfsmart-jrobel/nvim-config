return {
	{
		"https://codeberg.org/andyg/leap.nvim.git",
		config = function()
			require("leap").opts.safe_labels = ""
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
		end,
	},
}
