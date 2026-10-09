vim.pack.add({
	"https://github.com/NeogitOrg/neogit",
})

local set_hl = require("utils").set_hl

require("neogit").setup({
  disable_context_highlighting = true,
})

vim.keymap.set("n", "<leader>g", "<cmd>Neogit<cr>", {
	desc = "Neo[g]it",
})

set_hl("NeogitDiffAdd", { link = "DiffAdd" })
set_hl("NeogitDiffAddInline", { link = "DraculaGreenInverse" })
set_hl("NeogitDiffDelete", { link = "DiffDelete" })
set_hl("NeogitDiffDeleteInline", { link = "DraculaRedInverse" })
