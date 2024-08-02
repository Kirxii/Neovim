local keyset = vim.keymap.set

local silent = function(desc)
  return { silent = true, remap = false, desc = desc }
end
local expr = function(desc)
  return { silent = true, expr = true, remap = false, desc = desc }
end

keyset({ "n", "v" }, "j", "(v:count == 0 ? 'gj' : 'j')", expr())
keyset({ "n", "v" }, "k", "(v:count == 0 ? 'gk' : 'k')", expr())
keyset({ "n", "v" }, "<DOWN>", "(v:count == 0 ? 'gj' : 'j')", expr())
keyset({ "n", "v" }, "<UP>", "(v:count == 0 ? 'gk' : 'k')", expr())
keyset({ "n", "v" }, "^", "(v:count == 0 ? 'g^' : '^')", expr())
keyset({ "n", "v" }, "0", "(v:count == 0 ? 'g0' : '0')", expr())
keyset({ "n", "v" }, "$", "(v:count == 0 ? 'g$' : '$')", expr())

keyset("n", "<leader>qq", ":qa<CR>", silent("Quit Neovim"))
keyset("t", "<esc>", "<c-\\><c-n>", silent())
