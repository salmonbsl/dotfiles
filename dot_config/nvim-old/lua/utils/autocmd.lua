local M = {}
local grp = vim.api.nvim_create_augroup('user-au', {})
function M.create(event, opts)
  vim.api.nvim_create_autocmd(event, vim.tbl_extend('force', { group = grp }, opts))
end

return M
