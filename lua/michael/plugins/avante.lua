-- see default configuration section of repo for full list of config options

local cursor_agent_cmd = vim.fn.exepath("cursor-agent")
if cursor_agent_cmd == "" then
	cursor_agent_cmd = vim.fn.exepath("agent")
end
if cursor_agent_cmd == "" then
	cursor_agent_cmd = "cursor-agent"
end

return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
	opts = {
		mode = "legacy",
		instructions_file = "avante.md",
		provider = "cursor",
		acp_providers = {
			cursor = {
				command = cursor_agent_cmd,
				args = { "acp" },
				auth_method = "cursor_login",
				env = {
					HOME = os.getenv("HOME"),
					PATH = os.getenv("PATH"),
				},
			},
		},
		-- mode = "legacy", -- use "agentic" for multi-file, multi-step abstract tasks
		-- instructions_file = "avante.md",
		-- provider = "bedrock",
		-- providers = {
		-- 	bedrock = {
		-- 		-- model = "us.anthropic.claude-opus-4-5-20251101-v1:0", -- best but slowest
		-- 		model = "us.anthropic.claude-sonnet-4-5-20250929-v1:0", -- best balance: Nearly Opus quality, much faster
		-- 		-- model = "us.anthropic.claude-haiku-4-5-20251001-v1:0", -- fastest but less capable
		-- 		aws_profile = "rfs-ai",
		-- 		aws_region = "us-east-1",
		-- 		extra_request_body = {
		-- 			max_tokens = 4096,
		-- 			temperature = 0.3,
		-- 		},
		-- 	},
		-- },
		behaviour = {
			auto_suggestions = false, -- Experimental stage
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
			minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
			enable_token_counting = true, -- Whether to enable token counting. Default to true.
			auto_add_current_file = true, -- Whether to automatically add the current file when opening a new chat. Default to true.
			auto_approve_tool_permissions = true, -- Default: auto-approve all tools (no prompts)
			-- Examples:
			-- auto_approve_tool_permissions = false,                -- Show permission prompts for all tools
			-- auto_approve_tool_permissions = {"bash", "str_replace"}, -- Auto-approve specific tools only
			---@type "popup" | "inline_buttons"
			confirmation_ui_style = "inline_buttons",
			--- Whether to automatically open files and navigate to lines when ACP agent makes edits
			---@type boolean
			acp_follow_agent_locations = true,
		},
		selection = {
			enabled = true,
			hint_display = "none", -- turn off visual mode hints
		},
		prompt_logger = { -- logs prompts to disk (timestamped, for replay/debugging)
			enabled = false, -- toggle logging entirely
			log_dir = vim.fn.stdpath("cache") .. "/avante_prompts", -- directory where logs are saved
			fortune_cookie_on_success = false, -- shows a random fortune after each logged prompt (requires `fortune` installed)
			next_prompt = {
				normal = "<C-n>", -- load the next (newer) prompt log in normal mode
				insert = "<C-n>",
			},
			prev_prompt = {
				normal = "<C-p>", -- load the previous (older) prompt log in normal mode
				insert = "<C-p>",
			},
		},
		windows = {
			---@type "right" | "left" | "top" | "bottom"
			position = "right", -- the position of the sidebar
			wrap = true, -- similar to vim.o.wrap
			width = 30, -- default % based on available width
			sidebar_header = {
				enabled = false, -- true, false to enable/disable the header
				align = "center", -- left, center, right for title
				rounded = true,
			},
			spinner = {
				editing = {
					"⡀",
					"⠄",
					"⠂",
					"⠁",
					"⠈",
					"⠐",
					"⠠",
					"⢀",
					"⣀",
					"⢄",
					"⢂",
					"⢁",
					"⢈",
					"⢐",
					"⢠",
					"⣠",
					"⢤",
					"⢢",
					"⢡",
					"⢨",
					"⢰",
					"⣰",
					"⢴",
					"⢲",
					"⢱",
					"⢸",
					"⣸",
					"⢼",
					"⢺",
					"⢹",
					"⣹",
					"⢽",
					"⢻",
					"⣻",
					"⢿",
					"⣿",
				},
				generating = { "·", "✢", "✳", "∗", "✻", "✽" }, -- Spinner characters for the 'generating' state
				thinking = { "🤯", "🙄" }, -- Spinner characters for the 'thinking' state
			},
			input = {
				prefix = "> ",
				height = 10, -- Height of the input window in vertical layout
			},
			edit = {
				border = "rounded",
				start_insert = true, -- Start insert mode when opening the edit window
			},
			ask = {
				floating = false, -- Open the 'AvanteAsk' prompt in a floating window
				start_insert = false, -- Start insert mode when opening the ask window
				border = "rounded",
				---@type "ours" | "theirs"
				focus_on_apply = "ours", -- which diff to focus after applying
			},
		},
		shortcuts = {
			{
				name = "prreview",
				description = "Review PR",
				details = "Performs a thorough review of changes made on current branch",
				prompt = [[
					## Perform a thorough review of the changes made on the current branch since divergence from master
					- verify changes are sufficient at accomplishing the task (feature implementation, bug fix, etc.)
						- feel free to ask for questions at the outset if you are not able to infer the intent of the changes
					- verify code/test changes/additions adhere to standards outlined in the "Avante Instructions for RF-SMART" document
					- verify test coverage completely covers the changes that were made
						- changes to a helper function must be tested through all of its consumers
						- verify edge/corner cases
					- at end of response, provide a tldr summary of suggested changes
				]],
			},
			{
				name = "prsummary",
				description = "Generate PR Summary",
				details = "Generate PR summary of changes made in the current branch",
				prompt = [[
					## Generate PR summary of changes made on the current branch since divergence from master
					**Structure**:
					- Summary: Brief what and why
					- Solution: Detailed approach
					- Key Implementation Details: Decisions, edge cases, non-obvious behavior

					**Exclude**: Tests, research, debugging, iterations
					**Focus**: Final solution, architectural decisions, integrations
				]],
			},
		},
	},
	keys = {
		-- { "<leader>aa", ":AvanteAsk<CR>", desc = "Avante Ask" },
	},
}
