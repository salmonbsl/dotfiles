local M = {}

---@class KeymapSpec: vim.keymap.set.Opts
---@field [1] string
---@field [2] string|function
---@field modes? string|string[]

---@param spec KeymapSpec
function M.map(spec)
	local lhs, rhs = spec[1], spec[2]
	local modes = spec.modes or "n"

	local opts = vim.tbl_extend("force", {}, spec)
	opts[1], opts[2], opts.modes = nil, nil, nil

	vim.keymap.set(modes, lhs, rhs, opts)
end

--- @param name string
function M.augroup(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

local hl_group = M.augroup("highlights")
---@param name string
---@param val vim.api.keyset.highlight
function M.set_hl(name, val)
	local function set()
		vim.api.nvim_set_hl(0, name, val)
	end

	set()

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = hl_group,
		callback = set,
	})
end

return M
