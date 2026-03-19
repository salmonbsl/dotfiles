return {
	{
		"https://github.com/stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			float = {
				max_width = 128,
				preview_split = "right",
			},
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["<C-c>"] = { "actions.close", mode = { "n", "i" } },
				["q"] = { "actions.close", mode = "n" },
			},
		},
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		lazy = false,
		keys = {
			{
				"<leader>e",
				function()
					require("oil").open_float(nil, { preview = { vertical = true } })
				end,
				desc = "File [e]xplorer",
			},
			{
				"<leader>E",
				function()
					require("oil").open_float(".", { preview = { vertical = true } })
				end,
				desc = "File [E]xplorer (Current Directory)",
			},
		},
	},
	{
		"https://github.com/MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		keys = {
			{
				"<leader>rg",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				desc = "Search and Replace ([g]ruc Far)",
			},
		},
	},
}
