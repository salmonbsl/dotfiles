vim.pack.add({
	"https://github.com/folke/which-key.nvim",
})

require("which-key").setup({
	preset = "helix",
	spec = {
		{
			mode = { "n", "v" },
			{ "<leader>b", group = "[b]uffer" },
			{ "<leader>r", group = "[r]eplace" },
			{ "<leader>s", group = "[s]earch" },
			{ "<leader>S", group = "[S]ession" },
			{ "<leader>M", group = "[M]anager" },
			{ "<leader><tab>", group = "[tab]" },
			{ "g", group = "[g]o / [g]lobal" },
			{ "gr", group = "LSP" },
			{ "<C-w>", group = "[w]indow" },
		},
	},
	sort = { "alphanum", "local", "order", "group", "mod" },
})
