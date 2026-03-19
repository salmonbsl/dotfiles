return {
	{
		"https://github.com/zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			panel = {
				enabled = false,
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = false,
				keymap = {
					prev = "<M-p>",
					next = "<M-n>",
					accept = "<M-CR>",
				},
			},
			filetypes = {
				markdown = true,
				gitcommit = true,
				["*"] = function()
					-- disable for files with specific names
					local fname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
					local disable_patterns = { "env", "conf", "cnf", "local", "private" }
					return vim.iter(disable_patterns):all(function(pattern)
						return not string.match(fname, pattern)
					end)
				end,
			},
		},
	},
}
