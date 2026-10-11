local o, g = vim.opt, vim.g

-- Leader Keys
g.mapleader = " "
g.maplocalleader = "\\"

-- General
o.clipboard = "unnamedplus"
o.swapfile = false
o.scrolloff = 5
o.shiftround = true
o.whichwrap = "b,s,h,l,<,>,[,],~"

-- Search
o.ignorecase = true
o.smartcase = true

-- Editing
o.autoindent = true
o.breakindent = true
o.expandtab = true
o.linebreak = true
o.shiftwidth = 2
o.smartindent = true
o.softtabstop = -1
o.tabstop = 2
o.wrap = true

-- UI
o.cmdheight = 0
o.cursorline = true
o.laststatus = 3
o.number = true
o.relativenumber = true
o.showbreak = ">>"
o.signcolumn = "yes"
o.termguicolors = true
o.winborder = "solid"

-- Windows
o.splitbelow = true
o.splitright = true

-- Completion
o.complete = { ".", "w", "k", "b", "u" }
o.completeopt = { "menuone", "noinsert", "fuzzy" }

-- SSH OSC52
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
	virtual_lines = {
		current_line = true,
		format = function(diagnostic)
			return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
		end,
	},
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
