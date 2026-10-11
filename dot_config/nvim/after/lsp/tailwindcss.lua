---@type vim.lsp.Config
return {
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
}
