return {
  {
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
        desc = "Search in current directory (File)",
      },
      {
        "<leader>td",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Search diagnostics",
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
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = true,
    keys = {
      {
        "<leader>tF",
        "<cmd>Telescope file_browser select_buffer=true path=%:p:h<cr>",
        desc = "Search in current directory (Tree)",
      },
    },

    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
}
