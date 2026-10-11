---@type vim.lsp.Config
return {
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
}
