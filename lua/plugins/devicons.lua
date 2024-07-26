return {
  "rachartier/tiny-devicons-auto-colors.nvim",
  event = "VeryLazy",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  opts = {
    cache = {
      enabled = false,
      path = vim.fn.stdpath("cache") .. "/tiny-devicons-auto-colors-cache.json",
    },

    autoreload = true,
  },
}
