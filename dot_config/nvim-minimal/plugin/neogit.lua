vim.pack.add({
  "https://github.com/NeogitOrg/neogit",
})

vim.keymap.set(
  "n",
  "<leader>g",
  "<cmd>Neogit<cr>",
  {
    desc = "Neo[g]it",
  }
)
