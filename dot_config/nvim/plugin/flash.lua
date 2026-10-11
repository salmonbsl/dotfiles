vim.pack.add({
	"https://github.com/folke/flash.nvim",
})

require("flash").setup()

local set_hl = require("utils").set_hl
local map = require("utils").map

map({
	"s",
	function()
		require("flash").jump()
	end,
	modes = { "n", "x", "o" },
	desc = "Flash",
})

map({
	"S",
	function()
		require("flash").treesitter()
	end,
	modes = { "n", "x", "o" },
	desc = "Flash Treesitter",
})

map({
	"r",
	function()
		require("flash").remote()
	end,
	modes = "o",
	desc = "Remote Flash",
})

map({
	"R",
	function()
		require("flash").treesitter_search()
	end,
	modes = { "o", "x" },
	desc = "Treesitter Search",
})

map({
	"<c-s>",
	function()
		require("flash").toggle()
	end,
	modes = "c",
	desc = "Toggle Flash Search",
})

set_hl("FlashLabel", {
	link = "Title",
})
