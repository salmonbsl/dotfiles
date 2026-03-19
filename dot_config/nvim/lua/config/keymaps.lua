local map = vim.keymap.set

-- General
map("i", "jk", "<ESC>", { noremap = true })
map("t", [[<C-\>]], [[<C-\><C-n>]], { noremap = true })
map("n", "U", "<C-r>", { desc = "Redo" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up and Recenter" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down and Recenter" })
map("n", "<ESC>", "<Cmd>noh<CR>", { desc = "Clear highlights" })
map("n", "q:", "<Nop>", { desc = "Disable cmdwin" })

-- Windows
map("n", "<Leader>w-", ":split<CR><C-w>j", { desc = "HSplit+Move" })
map("n", "<Leader>w\\", ":vsplit<CR><C-w>l", { desc = "VSplit+Move" })
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]])
map("n", "<leader>wd", "<C-w>c", { desc = "Delete Window" })
map("n", "<leader>w=", "<C-w>=", { desc = "Equally high and wide" })

-- Tabs
map("n", "<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<S-tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "New Tab" })

-- Replacement
map("n", "<leader>rr", ":%s/", { desc = "Replace" })
map("x", "<leader>rr", ":s/", { desc = "Replace (Selection)" })
map("n", "<leader>rv", ":%s/\\v", { desc = "Regex Replace" })
map("x", "<leader>rv", ":s/\\v", { desc = "Regex Replace (Selection)" })
map("n", "<leader>rV", ":%s/\\V", { desc = "Literal Replace" })
map("x", "<leader>rV", ":s/\\V", { desc = "Literal Replace (Selection)" })

-- Coding
map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
map("n", "g/", "gcc", { remap = true, desc = "Toggle Comment Line" })
map("x", "g/", "gc", { remap = true, desc = "Toggle Comment" })

-- Pasting
map({ "n", "x" }, "<leader>p", '"0p', { noremap = true, silent = true, desc = "Paste from yank register" })
map({ "n", "x" }, "<leader>P", '"0P', { noremap = true, silent = true, desc = "Paste before from yank register" })

-- Diagnostics
local diagnostic_goto = function(next, severity)
	return function()
		vim.diagnostic.jump({
			count = next and 1 or -1,
			float = true,
			severity = severity and vim.diagnostic.severity[severity] or nil,
		})
		severity = severity and vim.diagnostic.severity[severity] or nil
	end
end
map("n", "ge", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
