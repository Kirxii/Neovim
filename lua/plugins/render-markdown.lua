return {
  "MeanderingProgrammer/render-markdown.nvim",

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },

  opts = {
    heading = {
      icons = {
        "󰎤 ",
        "󰎧 ",
        "󰎪 ",
        "󰎭 ",
        "󰎱 ",
        "󰎳 ",
      },
    },

    bullet = {
      icons = {
        "●",
        "◉",
        "○",
        "◆",
        "◈",
        "◇",
      },
    },

    latex = {
      enabled = false,
    },

    quote = { repeat_linebreak = true },
    win_options = {
      showbreak = { default = vim.api.nvim_get_option_value("showbreak", {}), rendered = "  " },
      breakindent = { default = vim.api.nvim_get_option_value("breakindent", {}), rendered = true },
      breakindentopt = { default = vim.api.nvim_get_option_value("breakindentopt", {}), rendered = "" },
    },
  },
}
