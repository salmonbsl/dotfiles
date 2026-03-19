return {
	"https://github.com/folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = {
			formatters = {
				file = { filename_first = true },
			},
		},
		zen = {
			toggles = {
				dim = false,
			},
		},
		indent = {
			chunk = {
				enabled = true,
			},
		},
		notifier = {},
	},
	keys = {
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},

		-- Search
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>s/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "Search History",
		},
		{
			"<leader>sa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "[a]utocmds",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "[b]uffers",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open [B]uffers",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "[c]ommand History",
		},
		{
			"<leader>sC",
			function()
				Snacks.picker.commands()
			end,
			desc = "[C]ommands",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "[d]iagnostics",
		},
		{
			"<leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer [D]iagnostics",
		},
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "[f]ind Files",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "[g]rep",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "[h]elp Pages",
		},
		{
			"<leader>sH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "[H]ighlights",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "[i]cons",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "[j]umps",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "[k]eymaps",
		},
		{
			"<leader>sl",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer [l]ines",
		},
		{
			"<leader>sL",
			function()
				Snacks.picker.loclist()
			end,
			desc = "[L]ocation List",
		},
		{
			"<leader>sn",
			function()
				Snacks.picker.notifications()
			end,
			desc = "[n]otifications",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "[m]arks",
		},
		{
			"<leader>sM",
			function()
				Snacks.picker.man()
			end,
			desc = "[M]an Pages",
		},
		{
			"<leader>sp",
			function()
				Snacks.picker.projects()
			end,
			desc = "[p]rojects",
		},
		{
			"<leader>sP",
			function()
				Snacks.picker.lazy()
			end,
			desc = "[P]lugin Spec",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "[q]uickfix List",
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.recent()
			end,
			desc = "[r]ecent",
		},
		{
			"<leader>sR",
			function()
				Snacks.picker.resume()
			end,
			desc = "[R]esume",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP [s]ymbols",
		},
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace [S]ymbols",
		},
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "[u]ndo History",
			mode = { "n", "x" },
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "[w]ord",
			mode = { "n", "x" },
		},

		-- -- LSP
		-- {
		-- 	"gd",
		-- 	function()
		-- 		Snacks.picker.lsp_definitions()
		-- 	end,
		-- 	desc = "[d]efinition",
		-- },
		-- {
		-- 	"gD",
		-- 	function()
		-- 		Snacks.picker.lsp_declarations()
		-- 	end,
		-- 	desc = "[D]eclaration",
		-- },
		-- {
		-- 	"gr",
		-- 	function()
		-- 		Snacks.picker.lsp_references()
		-- 	end,
		-- 	desc = "[r]eferences",
		-- 	nowait = true,
		-- },
		-- {
		-- 	"gI",
		-- 	function()
		-- 		Snacks.picker.lsp_implementations()
		-- 	end,
		-- 	desc = "[I]mplementation",
		-- },
		-- {
		-- 	"gy",
		-- 	function()
		-- 		Snacks.picker.lsp_type_definitions()
		-- 	end,
		-- 	desc = "[y]pe Definition",
		-- },

		-- Zen
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "[z]en Mode",
		},

		-- Buffer
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "[d]elete Buffer",
		},
		{
			"<leader>bo",
			function()
				Snacks.bufdelete.other()
				vim.notify("Deleted other buffers", "info", { title = "Buffer" })
			end,
			desc = "[o]ther Buffers",
		},
	},
	init = function()
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
	end,
}
