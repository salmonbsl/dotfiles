return {
	{
		"https://github.com/catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		init = function()
			-- なんかneovim0.12から見づらいので一旦tokyonightにする
			-- vim.cmd([[colorscheme catppuccin]])
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		init = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"https://github.com/folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader>a", group = "[a]I" },
					{ "<leader>b", group = "[b]uffer" },
					{ "<leader>c", group = "[c]ode" },
					{ "<leader>r", group = "[r]eplace" },
					{ "<leader>s", group = "[s]earch" },
					{ "<leader>t", group = "[t]erminal" },
					{ "<leader><tab>", group = "[tab]" },
					{ "<C-w>", group = "[w]indow" },
				},
			},
		},
	},
	{
		"https://github.com/nvim-mini/mini.misc",
		event = "VeryLazy",
		opts = {},
		init = function()
			require("mini.misc").setup_restore_cursor()
		end,
	},
	{
		"https://github.com/nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
		},
		init = function()
			local autocmd = require("utils.autocmd")
			autocmd.create({ "RecordingEnter", "CmdlineEnter" }, {
				pattern = "*",
				callback = function()
					vim.opt.cmdheight = 1
				end,
			})
			autocmd.create("RecordingLeave", {
				pattern = "*",
				callback = function()
					vim.opt.cmdheight = 0
				end,
			})
			autocmd.create("CmdlineLeave", {
				pattern = "*",
				callback = function()
					if vim.fn.reg_recording() == "" then
						vim.opt.cmdheight = 0
					end
				end,
			})
		end,
	},
	{
		"https://github.com/nvim-mini/mini.sessions",
		event = "VeryLazy",
		config = true,
		init = function()
			vim.api.nvim_create_user_command("SessionSaveCwd", function()
				local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
				require("mini.sessions").write(name)
			end, { desc = "Save session with cwd name" })

			vim.api.nvim_create_user_command("SessionDelete", function(arg)
				require("mini.sessions").select("delete", { force = arg.bang })
			end, { desc = "Delete session", bang = true })

			vim.api.nvim_create_user_command("SessionLoad", function()
				require("mini.sessions").select("read", { verbose = true })
			end, { desc = "Load session" })

			vim.api.nvim_create_user_command("SessionEscape", function()
				vim.v.this_session = ""
			end, { desc = "Escape session" })

			vim.api.nvim_create_user_command("SessionReveal", function()
				local s = vim.v.this_session
				if s == nil or s == "" then
					vim.print("No session")
					return
				end
				vim.print(vim.fn.fnamemodify(s, ":t:r"))
			end, { desc = "Reveal session" })
		end,
	},
	{
		"https://github.com/nvim-mini/mini.starter",
		lazy = false,
		event = "VimEnter",
		dependencies = {
			"https://github.com/nvim-mini/mini.sessions",
		},
		config = true,
	},
	{
		"https://github.com/Bekaboo/dropbar.nvim",
		event = "VeryLazy",
	},
	{
		"https://github.com/nvimdev/lspsaga.nvim",
		event = "VeryLazy",
		opts = {
			ui = {
				code_action = "",
			},
			symbol_in_winbar = {
				enable = false,
			},
		},
		keys = {
			{
				"gra",
				"<cmd>Lspsaga code_action<CR>",
				mode = { "n", "v" },
				desc = "Code [a]ction",
			},
			{
				"grn",
				"<cmd>Lspsaga rename<CR>",
				mode = "n",
				desc = "re[n]ame Symbol",
			},
		},
	},
	{
		"https://github.com/nvim-mini/mini.hipatterns",
		event = "VeryLazy",
		opts = function()
			local hipatterns = require("mini.hipatterns")
			local hi_words = require("mini.extra").gen_highlighter.words
			return {
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
					hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
					todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
					note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			}
		end,
	},
	{
		"https://github.com/folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			presets = {
				lsp_doc_border = true,
				long_message_to_split = true,
			},
			views = {
				notify = {
					merge = true,
				},
			},
			messages = {
				enabled = true,
				view = "mini",
				view_search = "virtualtext",
			},
			notify = {
				enabled = false,
			},
			lsp = {
				hover = {
					enabled = true,
				},
				signature = {
					enabled = false,
				},
				message = {
					enabled = true,
					view = "mini",
					opts = {},
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
		},
		keys = {
			{
				"<c-j>",
				function()
					if not require("noice.lsp").scroll(4) then
						return "<c-j>"
					end
				end,
			},
			{
				"<c-k>",
				function()
					if not require("noice.lsp").scroll(-4) then
						return "<c-k>"
					end
				end,
			},
		},
	},
	-- {
	-- 	"https://github.com/ruicsh/termite.nvim",
	-- 	event = "VeryLazy",
	-- 	-- cmd = "Termite",
	-- 	opts = {
	-- 		position = "bottom",
	-- 		keymaps = {
	-- 			toggle = "<C-t>t",
	-- 			create = "<C-n>",
	-- 			next = "<C-]>",
	-- 			prev = "<C-[>",
	-- 			normal_mode = false,
	-- 			focus_editor = false,
	-- 			maximize = "<C-z>",
	-- 			close = "q",
	-- 		},
	-- 	},
	-- },
	{
		"https://github.com/ruicsh/termite.nvim",
		event = "VeryLazy",
		config = function()
			-- optsでの読み込みだとなぜかkeymapsが上書きされないので、configで設定
			local leader = "<C-t>"
			require("termite").setup({
				position = "bottom",
				keymaps = {
					toggle = leader .. "t",
					create = leader .. "c",
					next = leader .. "]",
					prev = leader .. "[",
					normal_mode = false,
					focus_editor = false,
					maximize = leader .. "m",
					close = "q",
				},
			})
		end,
		keys = {
			{ "<C-t>t", desc = "[t]oggle terminals", mode = { "n", "t" } },
			{ "<C-t>c", desc = "[c]reate terminal", mode = { "n", "t" } },
			{ "<C-t>]", desc = "Next terminal", mode = { "t" } },
			{ "<C-t>[", desc = "Previous terminal", mode = { "t" } },
			{ "<C-t>m", desc = "[m]aximize terminal", mode = { "t" } },
		},
	},
}
