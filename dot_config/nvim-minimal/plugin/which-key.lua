vim.pack.add({
	"https://github.com/folke/which-key.nvim",
})

require("which-key").setup({
  preset = "helix",
  spec = {
    {
      mode = { "n", "v" },
      { "<leader>a", group = "[a]I" },
      { "<leader>b", group = "[b]uffer" },
      { "<leader>c", group = "[c]ode" },
      { "<leader>r", group = "[r]eplace" },
      { "<leader>s", group = "[s]earch" },
      { "<leader>S", group = "[S]ession" },
      { "<leader>t", group = "[t]erminal" },
      { "<leader><tab>", group = "[tab]" },
      { "<C-w>", group = "[w]indow" },
    },
  },
})

