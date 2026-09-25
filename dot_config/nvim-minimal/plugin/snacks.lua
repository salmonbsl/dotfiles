local map = require("utils").map

vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
	picker = {
		-- ui_select = true,
		formatters = {
			file = { filename_first = true },
		},
	},
	explorer = {},
	indent = {
		chunk = {
			enabled = true,
		},
	},
	notifier = {},
	toggle = {},
	rename = {},
	zen = {
		toggles = {
			dim = false,
		},
	},
})

map({
	"<leader><space>",
	function()
		Snacks.picker.smart()
	end,
	desc = "Smart Find Files",
})

map({
	"<leader>,",
	function()
		Snacks.picker.buffers()
	end,
	desc = "Buffers",
})

map({
	"<leader>/",
	function()
		Snacks.picker.grep()
	end,
	desc = "Grep",
})

map({
	"<leader>:",
	function()
		Snacks.picker.command_history()
	end,
	desc = "Search Command History",
})

map({
	"<leader>?",
	function()
		Snacks.picker.help()
	end,
	desc = "Help",
})

map({
	"<leader>sm",
	function()
		Snacks.picker.man()
	end,
	desc = "Search [m]an",
})

-- Explorer
map({
	"<leader>e",
	function()
		local file = vim.api.nvim_buf_get_name(0)
		local root = vim.fs.root(file, ".git") or vim.fs.dirname(file)

		Snacks.picker.explorer({
			layout = {
				preset = "default",
				preview = true,
			},
			auto_close = true,
			cwd = root,
			follow_file = true,
			win = {
				input = {
					keys = {
						["<CR>"] = { "jump", mode = { "n", "i" } },
					},
				},
				list = {
					keys = {
						["<CR>"] = "jump",
					},
				},
			},
			on_show = function(picker)
				picker:action("explorer_close_all")
			end,
		})
	end,
})

-- Zen
map({
	"<leader>z",
	function()
		Snacks.zen()
	end,
	desc = "[z]en Mode",
})

-- Buffers
map({
	"<leader>bd",
	function()
		Snacks.bufdelete()
	end,
	desc = "[d]elete Buffer",
})

map({
	"<leader>bD",
	function()
		Snacks.bufdelete.other()
		vim.notify("Deleted other buffers", "info", { title = "Buffer" })
	end,
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
