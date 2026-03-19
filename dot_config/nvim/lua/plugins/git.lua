return {
	{
		"https://github.com/lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = true,
	},
	{
		"https://github.com/NeogitOrg/neogit",
		cmd = "Neogit",
		config = true,
		keys = {
			{ "<leader>g", "<cmd>Neogit<cr>", desc = "Neo[g]it" },
		},
	},
}
