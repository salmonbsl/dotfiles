local o,g=vim.opt,vim.g

g.mapleader, g.maplocalleader = " ", "\\"

o.clipboard = "unnamedplus"
o.cursorline = true
o.ignorecase = true
o.linebreak = true
o.relativenumber = true
o.scrolloff = 5
o.shiftround = true
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.whichwrap = "b,s,h,l,<,>,[,],~"
o.winborder = "solid"
o.wrap = true

-- Indentation
o.autoindent = true
o.breakindent = true
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.softtabstop = -1
o.tabstop = 2

-- Visual Settings
o.cmdheight = 0;
o.laststatus = 3;
o.number = true
o.showbreak = ">>"
o.signcolumn = "yes"
o.termguicolors = true

-- Completion
o.complete = { ".", "w", "k", "b", "u" }
o.completeopt = { "menuone", "noinsert", "fuzzy" }

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
