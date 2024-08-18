---@param line string The string to wrap
---@param width integer How long should one line be
---@return string new_lines New lines generated
function SoftWrap(line, width)
  return line
end

---@param line string The string to wrap
---@param width integer How long should one line be
---@return string new_lines New lines generated
function HardWrap(line, width)
  return line
end

vim.api.nvim_set_hl(0, "RedBackground", { fg = "#1e1e2e", bg = "#f38ba8" })
local ns = vim.api.nvim_create_namespace("testing-field")
vim.api.nvim_buf_set_extmark(0, ns, 13, 0, { virt_text = { { " Hello World ", "RedBackground" } } })
