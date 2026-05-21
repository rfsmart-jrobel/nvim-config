-- vim.cmd("let g:netrw_liststyle = 3")

vim.opt.number = true -- show numbers in gutter
vim.opt.relativenumber = true -- show numbers relative to current line

vim.opt.cursorline = true -- highlight current line number (and enable the below 2 options to only highlight number)
vim.opt.cursorlineopt = "number"
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff9e64", bold = true })

vim.opt.startofline = true -- gg defaults to column 1 (among other things)

-- vim.opt.hlsearch = false -- controls search results highlighting

-- prevent keymapping timeout
-- vim.opt.timeout = false

-- or simply increase timeout
vim.opt.timeout = true
-- opt.timeoutlen = 300

-- tabs & indentation
vim.opt.tabstop = 4 -- width (in columns) used to display an actual tabulation character
vim.opt.shiftwidth = 4 -- amount of whitespace used for one level of indentation (e.g., >>)
-- vim.opt.expandtab = true -- indentation done using spaces only
vim.opt.list = false
vim.opt.autoindent = true -- copy indent from current line when starting new one

vim.opt.wrap = false

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- turn on termguicolors for tokyonight colorscheme to work
-- need to have a true color terminal
vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes"

-- backspace
vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
vim.opt.clipboard:append("unnamedplus") -- use system register as default register

-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

-- stop auto inclusion of new line at the end of files
vim.opt.fixendofline = false

-- force CRLF line endings for all new files
vim.opt.fileformats = "dos,unix"
vim.opt.fileformat = "dos"

-- turn off swap files (saves unsaved changes in the event of a crash)
vim.opt.swapfile = false

-- global statusline
-- vim.opt.laststatus = 3

-- Cursor rules (.mdc): same filetype as Markdown so treesitter + render-markdown.nvim apply
vim.filetype.add({
	extension = {
		mdc = "markdown",
	},
})

-- Remove auto comment continuation on newline
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 100,
		})
	end,
})

-- Automatically trigger buffer reload when underlying disk file has changed
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	callback = function()
		if vim.bo.buftype == "" then -- Only reload normal file buffers
			vim.cmd("checktime")
		end
	end,
})
