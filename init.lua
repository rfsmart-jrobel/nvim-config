require("michael.core")
require("michael.lazy")

local function upload_to_netsuite()
	-- Get the absolute path of the current buffer
	local file_path = vim.fn.expand("%:p")
	local desired_path_start_index = string.find(file_path, "/FileCabinet/")
	local desired_file_path = string.sub(file_path, desired_path_start_index + 12)

	local cmd = string.format("suitecloud file:upload --paths '%s'", desired_file_path)

	require("toggleterm").exec(cmd, 6)
end

local function deploy_to_netsuite()
	local cmd = "suitecloud project:deploy"

	require("toggleterm").exec(cmd, 6)
end

local wk = require("which-key")
wk.add({
	{ "<leader>n", group = "NetSuite" },
	{ "<leader>nu", upload_to_netsuite, desc = "Upload active buffer" },
	{ "<leader>nd", deploy_to_netsuite, desc = "Deploy project" },
})
