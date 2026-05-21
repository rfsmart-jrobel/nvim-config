local M = {}

function M.upload_to_netsuite()
	-- Get the absolute path of the current buffer
	local file_path = vim.fn.expand("%:p")

	-- Construct the command
	-- Using 'suitecloud file:upload --paths' (standard CLI syntax)
	local cmd = string.format("suitecloud file:upload --paths %s", file_path)

	-- Send it to ToggleTerm (assuming you use terminal 1 for builds/uploads)
	-- If you'd rather see the output in a floating window, use snacks.terminal
	require("toggleterm").exec(cmd)
end

-- Bind it using which-key style for easy discovery
local wk = require("which-key")
wk.add({
	{ "<leader>n", group = "NetSuite" },
	{ "<leader>nu", upload_to_netsuite, desc = "Upload file" },
})

return M
