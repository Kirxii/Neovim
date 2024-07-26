return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  cmd = "Telescope",
  keys = {
    {
      "<leader>tc",
      "<cmd>Telescope colorscheme<cr>",
      desc = "Search colorschemes",
    },
    {
      "<leader>tb",
      "<cmd>Telescope buffers<cr>",
      desc = "Search buffers",
    },
    {
      "<leader>tf",
      "<cmd>Telescope find_files<cr>",
      desc = "Search files",
    },
    {
      "<leader>td",
      "<cmd>Telescope diagnostics<cr>",
      desc = "Search diagonstics",
    },
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
  },

  opts = {
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
    },
  },
}
