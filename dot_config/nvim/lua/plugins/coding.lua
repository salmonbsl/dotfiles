return {
	{
		"https://github.com/nvim-mini/mini.cursorword",
		event = { "BufReadPost", "BufNewFile" },
		config = true,
	},
	{
		"https://github.com/nvim-mini/mini.pairs",
		event = "VeryLazy",
		opts = {
			modes = { insert = true, command = true, terminal = false },
		},
	},
	{
		"https://github.com/nvim-mini/mini.surround",
		event = "VeryLazy",
		opts = {
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				update_n_lines = "gsn",
			},
		},
		keys = {
			{ "gsa", mode = { "n", "x" }, desc = "[a]dd surround" },
			{ "gsd", mode = { "n", "x" }, desc = "[d]elete surround" },
			{ "gsf", mode = { "n", "x" }, desc = "[f]ind surround" },
			{ "gsF", mode = { "n", "x" }, desc = "[F]ind left surround" },
			{ "gsh", mode = { "n", "x" }, desc = "[h]ighlight surround" },
			{ "gsr", mode = { "n", "x" }, desc = "[r]eplace surround" },
			{ "gsn", mode = { "n", "x" }, desc = "[n]ext line surround update" },
		},
	},
	{
		"https://github.com/nvim-mini/mini.move",
		event = "VeryLazy",
		config = true,
	},
	{
		"https://github.com/nvim-mini/mini.splitjoin",
		event = "VeryLazy",
		opts = {
			mappings = {
				toggle = "gST",
				split = "gSS",
				join = "gSJ",
			},
		},
		keys = {
			{ "gST", mode = { "n", "x" }, desc = "[T]oggle split/join" },
			{ "gSS", mode = { "n", "x" }, desc = "[S]plit" },
			{ "gSJ", mode = { "n", "x" }, desc = "[J]oin" },
		},
	},
	{
		"https://github.com/monaqa/dial.nvim",
		event = "VeryLazy",
		init = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.integer.alias.binary,
					augend.date.alias["%Y/%m/%d"],
					augend.date.alias["%m/%d"],
					augend.date.alias["%Y-%m-%d"],
					augend.constant.alias.bool,
					augend.constant.new({ elements = { "and", "or" }, cyclic = true }),
					augend.constant.new({ elements = { "&&", "||" }, cyclic = true }),
					augend.semver.alias.semver,
				},
			})
		end,
		keys = function()
			local function map(lhs, mode, op, kind, desc)
				return {
					lhs,
					function()
						require("dial.map").manipulate(op, kind)
					end,
					mode = mode,
					desc = desc,
				}
			end

			return {
				map("<C-a>", "n", "increment", "normal", "Dial Increment"),
				map("<C-x>", "n", "decrement", "normal", "Dial Decrement"),
				map("g<C-a>", "n", "increment", "gnormal", "Dial gIncrement"),
				map("g<C-x>", "n", "decrement", "gnormal", "Dial gDecrement"),
				map("<C-a>", "x", "increment", "visual", "Dial Increment"),
				map("<C-x>", "x", "decrement", "visual", "Dial Decrement"),
				map("g<C-a>", "x", "increment", "gvisual", "Dial gIncrement"),
				map("g<C-x>", "x", "decrement", "gvisual", "Dial gDecrement"),
			}
		end,
	},
	{
		"https://github.com/nvim-mini/mini.ai",
		event = "VeryLazy",
		opts = function()
			local extra = require("mini.extra")
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({
						a = "@function.outer",
						i = "@function.inner",
					}, {}),
					c = ai.gen_spec.treesitter({
						a = "@class.outer",
						i = "@class.inner",
					}, {}),
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
					-- t = ai.gen_spec.treesitter({ a = "@tag.outer", i = "@tag.inner" }),
					d = { "%f[%d]%d+" },
					e = {
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					u = ai.gen_spec.function_call(),
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
					B = extra.gen_ai_spec.buffer(),
				},
			}
		end,
	},
	{
		"https://github.com/folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
}
