local map = require("utils").map

-- General
map({ "jk", "<ESC>", modes = "i", noremap = true })
map({ "<C-\\>", "<C-\\><C-n>", modes = "t", noremap = true })
map({ "U", "<C-r>", desc = "Redo" })
map({ "<C-u>", "<C-u>zz", desc = "Scroll Up (Centered)" })
map({ "<C-d>", "<C-d>zz", desc = "Scroll Down (Centered)" })
map({ "n", "nzzzv", desc = "Next Search Result (Centered)" })
map({ "N", "Nzzzv", desc = "Prev Search Result (Centered)" })
map({ "<ESC>", "<Cmd>noh<CR>", desc = "Clear highlights" })
map({ "q:", "<Nop>", desc = "Disable cmdwin" })
map({ "<Leader>w", "<Cmd>w<CR>", desc = "[w]rite" })
map({ "<Leader>q", "<Cmd>q<CR>", desc = "[q]uit" })
map({ "<Leader>Q", "<Cmd>qall<CR>", desc = "[Q]uit all" })

-- Windows
map({ "<C-w>-", "<Cmd>split<CR>", desc = "Horizontal Split" })
map({ "<C-w>\\", "<Cmd>vsplit<CR>", desc = "Vertical Split" })
map({ "<leader>-", "<Cmd>split<CR>", desc = "Horizontal Split" })
map({ "<leader>\\", "<Cmd>vsplit<CR>", desc = "Vertical Split" })
map({ "<C-w>d", "<Cmd>close<CR>", desc = "[d]elete Window" })
map({ "<C-h", "<C-w>h", desc = "Go to Left Window", remap = true })
map({ "<C-j", "<C-w>j", desc = "Go to Lower Window", remap = true })
map({ "<C-k", "<C-w>k", desc = "Go to Upper Window", remap = true })
map({ "<C-l", "<C-w>l", desc = "Go to Right Window", remap = true })
map({ "<C-S-H>", "<C-w><S-H>" })
map({ "<C-S-J>", "<C-w><S-J>" })
map({ "<C-S-K>", "<C-w><S-K>" })
map({ "<C-S-L>", "<C-w><S-L>" })

-- Tabs
map({ "<tab>", "<cmd>tabnext<cr>", desc = "Next Tab" })
map({ "<S-tab>", "<cmd>tabprevious<cr>", desc = "Previous Tab" })
map({ "<leader><tab>f", "<cmd>tabfirst<cr>", desc = "[f]irst Tab" })
map({ "<leader><tab>l", "<cmd>tablast<cr>", desc = "Last Tab" })
map({ "<leader><tab>]", "<cmd>tabnext<cr>", desc = "Next Tab" })
map({ "<leader><tab>[", "<cmd>tabprevious<cr>", desc = "Previous Tab" })
map({ "<leader><tab>d", "<cmd>tabclose<cr>", desc = "[d]elete Tab" })
map({ "<leader><tab>D", "<cmd>tabonly<cr>", desc = "[D]elete Other Tabs" })
map({ "<leader><tab>n", "<cmd>tabnew<cr>", desc = "[n]ew Tab" })

-- Replacement
map({ "<leader>rr", ":%s/", desc = "Replace" })
map({ "<leader>rr", ":s/", modes = "x", desc = "Replace (Selection)" })
map({ "<leader>rv", ":%s/\\v", desc = "Regex Replace" })
map({ "<leader>rv", ":s/\\v", modes = "x", desc = "Regex Replace (Selection)" })
map({ "<leader>rV", ":%s/\\V", desc = "Literal Replace" })
map({ "<leader>rV", ":s/\\V", modes = "x", desc = "Literal Replace (Selection)" })

-- Coding
map({ "g/", "gcc", remap = true, desc = "Toggle Comment Line" })
map({ "g/", "gc", modes = "x", remap = true, desc = "Toggle Comment" })

-- Pasting
map({
	"<leader>p",
	'"0p',
	modes = { "n", "x" },
	noremap = true,
	silent = true,
	desc = "Paste from yank register",
})

map({
	"<leader>P",
	'"0P',
	modes = { "n", "x" },
	noremap = true,
	silent = true,
	desc = "Paste before from yank register",
})

-- Diagnostics
local diagnostic_goto = function(next, severity)
	return function()
		vim.diagnostic.jump({
			count = next and 1 or -1,
			float = true,
			severity = severity and vim.diagnostic.severity[severity] or nil,
		})
	end
end
map({ "ge", vim.diagnostic.open_float, desc = "Line Diagnostics" })
map({ "]d", diagnostic_goto(true), desc = "Next Diagnostic" })
map({ "[d", diagnostic_goto(false), desc = "Prev Diagnostic" })
map({ "]e", diagnostic_goto(true, "ERROR"), desc = "Next Error" })
map({ "[e", diagnostic_goto(false, "ERROR"), desc = "Prev Error" })
map({ "]w", diagnostic_goto(true, "WARN"), desc = "Next Warning" })
map({ "[w", diagnostic_goto(false, "WARN"), desc = "Prev Warning" })

-- Packages
map({
	"<leader>mp",
	function()
		vim.pack.update()
	end,
	desc = "Update [p]ackages",
})
