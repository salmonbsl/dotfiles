return {
	{
		"https://github.com/neovim/nvim-lspconfig",
		event = "VeryLazy",
		init = function()
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
							library = vim.api.nvim_get_runtime_file('', true),
						},
					})
				end,
				settings = {
					Lua = {},
				},
			})
		end,
	},
	{
		"https://github.com/mason-org/mason.nvim",
		build = ":MasonUpdate",
		cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"https://github.com/mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			enhure_installed = {
				"lua_ls",
				"stylua",
			},
		},
		keys = {
			{ "gh", "<cmd>lua vim.lsp.buf.hover()       <CR>" },
			{ "gd", "<cmd>lua vim.lsp.buf.definition()  <CR>" },
			{ "gD", "<cmd>lua vim.lsp.buf.declaration() <CR>" },
		},
	},
	{
		"https://github.com/stevearc/conform.nvim",
		opts = function()
			local web_formatters = { "biome-check", "prettierd", "prettier", stop_after_first = true }
			---@type conform.setupOpts
			local opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					php = { "pint" },
					blade = { "blade-formatter" },
					nix = { "alejandra" },
					javascript = web_formatters,
					javascriptreact = web_formatters,
					typescript = web_formatters,
					typescriptreact = web_formatters,
					json = web_formatters,
					html = web_formatters,
					css = web_formatters,
					scss = web_formatters,
					less = web_formatters,
					markdown = web_formatters,
					yaml = { "yamlfmt" },
					sh = { "shfmt" },
					python = { "black" },
					rust = { "rustfmt" },
          astro = web_formatters,
				},
			}
			return opts
		end,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				desc = "[f]ormat",
			},
		},
	},
	{
		"https://github.com/saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "super-tab",
			},

			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 0 },
				menu = {
					direction_priority = { "n", "s" },
				},
				list = {
					selection = {
						preselect = true,
						auto_insert = true,
					},
				},
			},

			fuzzy = {
				implementation = "prefer_rust",
			},
		},
		init = function()
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})
		end,
	},
}
