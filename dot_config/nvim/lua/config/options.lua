local o, g = vim.opt, vim.g

g.mapleader, g.maplocalleader = " ", "\\"
o.breakindent = true
o.clipboard = "unnamedplus"
o.cursorline = true
o.expandtab = true
o.ignorecase = true
o.laststatus = 3
o.linebreak = true
o.number = true
o.relativenumber = true
o.scrolloff = 5
o.shiftround = true
o.shiftwidth = 2
o.showbreak = ">>"
o.signcolumn = "yes"
o.smartcase = true
o.softtabstop = -1
o.tabstop = 2
o.termguicolors = true
o.whichwrap = "b,s,h,l,<,>,[,],~"
o.winborder = "solid"
o.wrap = true

-- SSH 用 OSC52
local function paste()
	return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end
if vim.env.SSH_TTY then
	g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = { ["+"] = paste, ["*"] = paste },
	}
end

-- diagnostics
vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = { current_line = true },
	underline = true,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})
