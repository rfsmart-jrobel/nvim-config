require("michael.core.options")
require("michael.core.keymaps")

local jira_status = require("michael.functions.jira_status")

local timer = vim.loop.new_timer()
timer:start(0, 600000, vim.schedule_wrap(jira_status.update_jira_status))

vim.keymap.set("n", "<leader>jr", jira_status.update_jira_status, { desc = "Jira Refresh" })
vim.keymap.set("n", "<leader>jo", function()
	vim.ui.open(jira_status.jira_ticket_url)
end, { desc = "Jira Open ticket" })
vim.keymap.set("n", "<leader>jg", function()
	vim.ui.open("https://github.com/stars/rfsmart-jrobel/lists/common")
end, { desc = "Jira Github" })
vim.keymap.set("n", "<leader>jy", function()
	vim.fn.setreg("+", jira_status.jira_raw_text)
	print("Yanked " .. jira_status.jira_raw_text)
end, { desc = "Jira Yank ticket" })
