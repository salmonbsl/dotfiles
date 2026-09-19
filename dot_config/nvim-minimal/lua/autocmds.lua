local map = require("utils").map
local augroup = require("utils").augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "InsertLeave", "TextChanged" }, {
	group = augroup("auto_save"),
	pattern = "*",
	command = "silent! write",
})

autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

autocmd("LspAttach", {
	group = augroup("lsp_attach"),
	callback = function(arg)
		map({
			"<leader>f",
			function()
				vim.lsp.buf.format({ acync = true })
			end,
			desc = "[f]ormat buffer",
			buffer = arg.buf
		})
	end,
})

local cmdheight_grp = augroup("cmdheight")
autocmd({ "RecordingEnter", "CmdlineEnter" }, {
	group = cmdheight_grp,
	pattern = "*",
	callback = function()
		vim.opt.cmdheight = 1
	end,
})

autocmd("RecordingLeave", {
	group = cmdheight_grp,
	pattern = "*",
	callback = function()
		vim.opt.cmdheight = 0
	end,
})

autocmd("CmdlineLeave", {
	group = cmdheight_grp,
	pattern = "*",
	callback = function()
		if vim.fn.reg_recording() == "" then
			vim.opt.cmdheight = 0
		end
	end,
})
