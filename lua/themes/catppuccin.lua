return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd("colorscheme github_dark")
  end,
  opts = {
    treesitter = true,
    treesitter_context = true,
  },
}
