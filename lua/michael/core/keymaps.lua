-- set leader key to space
vim.g.mapleader = " "

vim.opt.startofline = true

vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>", { desc = "Open netrw project view" })

-- clear search highlights
vim.keymap.set("n", "<leader><leader>", ":nohl<CR>", { desc = "Clear search highlights" })

-- Search and replace word under cursor
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- prevent ctrl-z from suspending neovim
vim.keymap.set({ "n", "v", "s" }, "<C-z>", "<Nop>")

vim.keymap.set("n", "<leader>du", function()
	vim.cmd("windo diffupdate")
	vim.cmd("windo redraw")
end, { desc = "Fix diff view alignment" })

vim.keymap.set("n", "<C-j>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<C-k>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })

vim.keymap.set("n", "<leader>gr", "<Cmd>DiffviewOpen HEAD<CR>", { desc = "Git Review (w/ HEAD)" })
vim.keymap.set("n", "<leader>gR", function()
	vim.cmd("DiffviewOpen " .. vim.fn.system("git merge-base master HEAD"))
end, { desc = "Git Review (w/ master)" })
vim.keymap.set("n", "<leader>gu", "<Cmd>DiffviewOpen<CR>", { desc = "Git Untracked review" })
vim.keymap.set("n", "<leader>gh", ":DiffviewOpen ", { desc = "Git review (w/ Hash)" })
vim.keymap.set("n", "<leader>gc", "<Cmd>DiffviewClose<CR>", { desc = "Git Close review" })

vim.keymap.set("n", "<leader>s", "<Cmd>w<CR>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>S", "<Cmd>wall<CR>", { desc = "Save all buffers" })

vim.keymap.set("n", "<leader>by", function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	print("Yanked " .. path)
end, { desc = "Buffer Yank path" })
