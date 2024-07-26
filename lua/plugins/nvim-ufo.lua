return {
  "kevinhwang91/nvim-ufo",
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
    provider_selector = function(_, _, _)
      return { "treesitter", "indent" }
    end,
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "Folded", { link = "PMenu" })
    vim.api.nvim_set_hl(0, "UfoFoldedEllipsis", { link = "ModeMsg" })

    require("ufo").setup(opts)
  end,
}
