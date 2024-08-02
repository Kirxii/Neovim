-- NOTE: Input mode escape more smooth with no delay
return {
  "max397574/better-escape.nvim",
  event = "InsertEnter",

  opts = {
    timeout = vim.o.timeoutlen,
    mappings = {
      n = {
        [" "] = {
          ["<tab>"] = "<esc>",
        },
      },
      i = {
        j = {
          j = "<esc>",
          k = "<esc>",
        },
        k = {
          j = "<esc>",
          k = "<esc>",
        },
      },
      t = {
        j = {
          j = false,
          k = false,
          h = "<C-\\><C-n>",
        },
      },
    },
  },
}
