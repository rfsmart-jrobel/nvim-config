return {
	{
		"https://codeberg.org/andyg/leap.nvim.git",
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
		end,
	},
}
