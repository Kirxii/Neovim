return {
  "epwalsh/obsidian.nvim",
  enabled = false,
  version = "*",
  lazy = true,
  event = {
    "BufReadPre C:/Users/K/ObsidianMD/Spacious Rework/*.md",
    "BufNewFile C:/Users/K/ObsidianMD/Spacious Rework/*.md",
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  opts = {
    workspaces = {
      {
        name = "Spacious",
        path = "~/ObsidianMD/Spacious Rework",
      },
    },

    completion = {
      nvim_cmp = true,
      min_char = 2,
    },

    disable_frontmatter = true,

    ui = {
      enable = false,
    },
  },
}
