vim.pack.add({
	"https://github.com/swaits/zellij-nav.nvim",
})

local map = require("utils").map

require("zellij-nav").setup()

map({ "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>", desc = "Navigate Left or Tab", silent = true })
map({ "<c-j>", "<cmd>ZellijNavigateDown<cr>", desc = "Navigate Down", silent = true })
map({ "<c-k>", "<cmd>ZellijNavigateUp<cr>", desc = "Navigate Up", silent = true })
map({ "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", desc = "Navigate Right or Tab", silent = true })
