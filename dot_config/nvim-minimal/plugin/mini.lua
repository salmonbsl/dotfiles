vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

local map = vim.keymap.set

local extra = require("mini.extra")

require("mini.misc").setup_restore_cursor()

-- UI
require("mini.icons").setup()
require("mini.starter").setup()
require("mini.diff").setup()
require("mini.statusline").setup()

-- Coding
require("mini.cursorword").setup()
vim.api.nvim_set_hl(0, "MiniCursorword", { link = "CursorLine" })
vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "CursorLine" })

require("mini.trailspace").setup()

require("mini.pairs").setup({
	modes = { insert = true, command = true, terminal = false },
})

require("mini.move").setup({
  mappings = {
    left = "<C-S-h>",
    right = "<C-S-l>",
    down = "<C-S-j>",
    up = "<C-S-k>",
    line_left = "<C-S-h>",
    line_right = "<C-S-l>",
    line_down = "<C-S-j>",
    line_up = "<C-S-k>",
  }
})

require("mini.splitjoin").setup({
	mappings = {
		toggle = "gSt",
		split = "gSs",
		join = "gSj",
	},
})

local ai = require("mini.ai")
ai.setup({
	n_lines = 500,
	custom_textobjects = {
		o = ai.gen_spec.treesitter({
			a = { "@block.outer", "@conditional.outer", "@loop.outer" },
			i = { "@block.inner", "@conditional.inner", "@loop.inner" },
		}, {}),
		f = ai.gen_spec.treesitter({
			a = "@function.outer",
			i = "@function.inner",
		}, {}),
		c = ai.gen_spec.treesitter({
			a = "@class.outer",
			i = "@class.inner",
		}, {}),
		t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
		d = { "%f[%d]%d+" },
		e = {
			{
				"%u[%l%d]+%f[^%l%d]",
				"%f[%S][%l%d]+%f[^%l%d]",
				"%f[%P][%l%d]+%f[^%l%d]",
				"^[%l%d]+%f[^%l%d]",
			},
			"^().*()$",
		},
		u = ai.gen_spec.function_call(),
		U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
		B = extra.gen_ai_spec.buffer(),
	},
})

local hipatterns = require("mini.hipatterns")
local hi_words = require("mini.extra").gen_highlighter.words
require("mini.hipatterns").setup({
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
		hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
		todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
		note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

-- Files
require("mini.files").setup({
	windows = {
		preview = true,
	},
})

map("n", "<leader>e", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0))
	MiniFiles.reveal_cwd()
end, {
	desc = "File [e]xplorer",
})

map("n", "<leader>E", function()
	MiniFiles.open()
end, {
	desc = "File [E]xplorer (CWD)",
})

-- Completion
require("mini.fuzzy").setup()
require("mini.completion").setup({
	delay = { completion = 0, info = 0, signature = 0 },
	lsp_conpletion = {
		process_items = MiniFuzzy.process_lsp_items,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "snacks_picker_*",
	callback = function()
		vim.b.minicompletion_disable = true
	end,
})

map("i", "<tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<c-y>"
	end
	return "tab"
end, { expr = true })

-- Sessions
require("mini.sessions").setup()

local function save_session()
	local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	require("mini.sessions").write(name)
end

map("n", "<leader>Ss", save_session, {
	desc = "[s]ave Session",
})

map("n", "<leader>Sl", function()
	require("mini.sessions").select("read", { verbose = true })
end, {
	desc = "[l]oad Session",
})

map("n", "<leader>Sd", function()
	require("mini.sessions").select("delete")
end, {
	desc = "[d]elete Session",
})

map("n", "<leader>SD", function()
	require("mini.sessions").select("delete", { force = true })
end, {
	desc = "[D]elete Session (force)",
})

map("n", "<leader>Se", function()
	vim.v.this_session = ""
end, {
	desc = "[e]scape Session",
})

map("n", "<leader>R", function()
	save_session()
	vim.cmd("restart")
end, {
	desc = "[r]estart Neovim",
})

