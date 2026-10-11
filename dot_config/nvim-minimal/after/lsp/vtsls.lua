---@type vim.lsp.Config
return {
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
}
