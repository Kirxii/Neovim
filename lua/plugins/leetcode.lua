return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",

  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    -- NOTE: Optional
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },

  opts = {
    arg = "leetcode.nvim",
    cn = {
      enabled = false,
    },
  },
}
