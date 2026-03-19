return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		init = function()
			vim.cmd([[colorscheme catppuccin ]])
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
					{ "<leader>w", group = "[w]indow" },
					{ "<leader><tab>", group = "[tab]" },
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
		"kevinhwang91/nvim-hlslens",
		event = "VeryLazy",
		config = true,
		keys = function()
			local function start()
				require("hlslens").start()
			end

			return {
				{
					"n",
					function()
						vim.cmd(("normal! %dn"):format(vim.v.count1))
						start()
					end,
					mode = "n",
					desc = "Next search (hlslens)",
				},
				{
					"N",
					function()
						vim.cmd(("normal! %dN"):format(vim.v.count1))
						start()
					end,
					mode = "n",
					desc = "Prev search (hlslens)",
				},
				{
					"*",
					function()
						vim.cmd("normal! *")
						start()
					end,
					mode = "n",
					desc = "Search word forward (hlslens)",
				},
				{
					"#",
					function()
						vim.cmd("normal! #")
						start()
					end,
					mode = "n",
					desc = "Search word backward (hlslens)",
				},
				{
					"g*",
					function()
						vim.cmd("normal! g*")
						start()
					end,
					mode = "n",
					desc = "Search word (partial) forward (hlslens)",
				},
				{
					"g#",
					function()
						vim.cmd("normal! g#")
						start()
					end,
					mode = "n",
					desc = "Search word (partial) backward (hlslens)",
				},
			}
		end,
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
}
