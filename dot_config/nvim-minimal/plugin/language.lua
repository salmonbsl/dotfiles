local map = require("utils").map
local augroup = require("utils").augroup
local autocmd = vim.api.nvim_create_autocmd

-- LSP
vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
})

-- Manager
vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
vim.keymap.set("n", "<leader>Mm", "<cmd>Mason<cr>", {
	desc = "[m]ason",
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"stylua",
	},
})

-- Formatting
vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

local conform = require("conform")
local web_formatters = { "biome-check", "prettierd", "prettier", stop_after_first = true }
conform.setup({
	formatters_by_ft = {
		astro = web_formatters,
		blade = { "blade-formatter" },
		css = web_formatters,
		html = web_formatters,
		javascript = web_formatters,
		javascriptreact = web_formatters,
		json = web_formatters,
		jsonc = web_formatters,
		kdl = { "kdlfmt" },
		less = web_formatters,
		lua = { "stylua" },
		markdown = web_formatters,
		nix = { "alejandra" },
		php = { "pint" },
		python = { "black" },
		rust = { "rustfmt" },
		scss = web_formatters,
		sh = { "shfmt" },
		typescript = web_formatters,
		typescriptreact = web_formatters,
		yaml = { "yamlfmt" },
	},
})

autocmd("LspAttach", {
	group = augroup("lsp_attach"),
	callback = function(arg)
		map({
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			desc = "[f]ormat buffer",
			buffer = arg.buf,
		})
	end,
})
