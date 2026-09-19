vim.pack.add({
	"https://github.com/romus204/tree-sitter-manager.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	"https://github.com/folke/ts-comments.nvim",
})

require("tree-sitter-manager").setup()
require("nvim-treesitter-textobjects").setup()
require("nvim-ts-autotag").setup()
require("treesitter-context").setup()
require("ts-comments").setup()

vim.keymap.set("n", "<leader>mt", "<cmd>TSManager<cr>", {
	desc = "[t]ree-sitter Manager",
})
