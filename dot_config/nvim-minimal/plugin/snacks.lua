vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
	picker = {
		formatters = {
			file = { filename_first = true },
		},
	},
	indent = {
		chunk = {
			enabled = true,
		},
	},
	notifier = {},
	-- scroll = {
	-- 	animate = { total = 100 },
	-- },
	zen = {
		toggles = {
			dim = false,
		},
	},
})

local map = vim.keymap.set

map("n", "<leader><space>", function()
	Snacks.picker.smart()
end, {
	desc = "Smart Find Files",
})

map("n", "<leader>,", function()
	Snacks.picker.buffers()
end, {
	desc = "Buffers",
})

map("n", "<leader>/", function()
	Snacks.picker.grep()
end, {
	desc = "Grep",
})

map("n", "<leader>z", function()
	Snacks.zen()
end, {
	desc = "[z]en Mode",
})

map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, {
	desc = "[d]elete Buffer",
})

map("n", "<leader>bD", function()
	Snacks.bufdelete.other()
	vim.notify("Deleted other buffers", "info", { title = "Buffer" })
end, {
	desc = "[D]elete Other Buffers",
})

vim.api.nvim_create_autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(vim.lsp.status(), "info", {
			id = "lsp_progress",
			title = "LSP Progress",
			opts = function(notif)
				notif.icon = ev.data.params.value.kind == "end" and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})
