local fileTypes = {
  vim = "indent",
  python = "indent",
  markdown = "",
}

return {
  "kevinhwang91/nvim-ufo",
  lazy = true,
  event = "VeryLazy",
  init = function()
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,

  dependencies = {
    "kevinhwang91/promise-async",
  },

  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      return fileTypes[filetype] or { "treesitter", "indent" }
    end,
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "Folded", { link = "PMenu" })
    vim.api.nvim_set_hl(0, "UfoFoldedEllipsis", { link = "ModeMsg" })

    require("ufo").setup(opts)
  end,
}
