local function augroup(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
	group = augroup("auto_save"),
	pattern = "*",
	command = "silent! write",
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup("lsp_attach"),
	callback = function(ars)
		local bufnr = arg.buf
		local lspmap = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		lspmap("n", "K", vim.lsp.buf.hover, "LSP Hover")
		lspmap("n", "gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
		lspmap("n", "gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
		lspmap("n", "gi", vim.lsp.buf.implementation, "[g]o to [i]mplementation")
		lspmap("n", "<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame symbol")
		lspmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
		lspmap("n", "<leader>f", function()
			vim.lsp.buf.format({ acync = true })
		end, "[f]ormat buffer")
	end,
})

local cmdheight_grp = augroup("cmdheight")
vim.api.nvim_create_autocmd({ "RecordingEnter", "CmdlineEnter" }, {
	group = cmdheight_grp,
	pattern = "*",
	callback = function()
		vim.opt.cmdheight = 1
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	group = cmdheight_grp,
	pattern = "*",
	callback = function()
		vim.opt.cmdheight = 0
	end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
	group = cmdheight_grp,
	pattern = "*",
	callback = function()
		if vim.fn.reg_recording() == "" then
			vim.opt.cmdheight = 0
		end
	end,
})
