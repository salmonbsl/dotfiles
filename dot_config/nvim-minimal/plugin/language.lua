vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
})

vim.lsp.config("vtsls", {
	root_dir = function(bufnr, on_dir)
		local deno_markers = { "deno.json", "deno.jsonc", "deps.ts" }
		local deno_dir = vim.fs.root(bufnr, deno_markers)
		if deno_dir then
			return
		end

		local node_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
		local node_dir = vim.fs.root(bufnr, node_markers)
		if node_dir then
			return on_dir(node_dir)
		end

		local cwd = vim.fs.dirname(vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr)))
		return on_dir(cwd)
	end,
	workspace_required = true,
	settings = {
		complete_function_calls = true,
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true,
			experimental = {
				maxInlayHintLength = 30,
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
		typescript = {
			preferences = {
				importModuleSpecifier = "non-relative",
			},
			updateImportsOnFileMove = { enabled = "always" },
			suggest = {
				completeFunctionCalls = true,
			},
			inlayHints = {
				enumMemberValues = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				parameterNames = { enabled = "literals" },
				parameterTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				variableTypes = { enabled = false },
			},
		},
	},
})

vim.lsp.config("intelephense", {
	settings = {
		intelephense = {
			files = {
				exclude = {
					"**/vendor/**/Tests/**",
					"**/vendor/**/tests/**",
					"**/var/cache/**",
					"**/vendor/composer/**",
				},
			},
		},
	},
})

vim.lsp.config("emmet_language_server", {
	filetypes = {
		"astro",
		"blade",
		"css",
		"eruby",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"pug",
		"sass",
		"scss",
		"typescriptreact",
	},
})

vim.lsp.config("tailwindcss", {
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					{ "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "tv\\({([\\s\\S]*)}\\)", '"([^"]*)"' },
					{ "tv\\({([\\s\\S]*)}\\)", "'([^']*)'" },
					{ "tv\\({([\\s\\S]*)}\\)", "`([^`]*)`" },
				},
			},
		},
	},
})

vim.lsp.config("denols", {
	root_dir = function(bufnr, on_dir)
		local deno_markers = { "deno.json", "deno.jsonc", "deps.ts" }
		local deno_dir = vim.fs.root(bufnr, deno_markers)
		if deno_dir then
			return on_dir(deno_dir)
		end

		local node_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
		local node_dir = vim.fs.root(bufnr, node_markers)
		if node_dir then
			return
		end
	end,
})

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			workspace = {
				checkThirdParty = false,
				-- NOTE: this is a lot slower and will cause issues when working on
				-- your own configuration.
				-- See https://github.com/neovim/nvim-lspconfig/issues/3189
				library = vim.api.nvim_get_runtime_file("", true),
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
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
vim.keymap.set("n", "<leader>mm", "<cmd>Mason<cr>", {
	desc = "[m]ason",
})

vim.pack.add({
	"https://github.com/mason-org/mason-lspconfig.nvim",
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"stylua",
	},
})
