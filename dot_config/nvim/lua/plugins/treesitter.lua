return {
	{
		"https://github.com/nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = ":TSUpdate",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("vim-treesitter-start", { clear = true }),
				callback = function()
					pcall(vim.treesitter.start)

					-- vim.wo[0][0].foldmethod = "expr"
					-- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"

					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"https://github.com/nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
	},
	{
		"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		config = true,
	},
	{
		"https://github.com/windwp/nvim-ts-autotag",
		event = { "VeryLazy" },
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true,
			},
		},
	},
	{
		"https://github.com/folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},
}
