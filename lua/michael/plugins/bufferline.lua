-- improves tabs appearance
return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "buffers",
			separator_style = "slant",
			max_name_length = 30,
			min_name_length = 5,
		},
	},
}
