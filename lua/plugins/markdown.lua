return {
  "MeanderingProgrammer/markdown.nvim",
  main = "render-markdown",

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
  },
}
