return {
  "jakewvincent/mkdnflow.nvim",
  event = "VeryLazy",

  opts = {
    mappings = {
      MkdnNewListItem = { "i", "<CR>" },
    },

    perspective = {
      priority = "root",
      root_tell = "Dashboard.md",
      fallback = "first",
      nvim_wd_heel = false,
      update = false,
    },

    foldtext = {
      title_transformer = function()
        local function my_title_transformer(text)
          local updated_title = text:gsub("%b{}", "")
          updated_title = updated_title:gsub("^%s*", "")
          updated_title = updated_title:gsub("%s*$", "")
          updated_title = updated_title:gsub("^######", "󰉰")
          updated_title = updated_title:gsub("^#####", "󰉯")
          updated_title = updated_title:gsub("^####", "󰉮")
          updated_title = updated_title:gsub("^###", "󰉭")
          updated_title = updated_title:gsub("^##", "󰉬")
          updated_title = updated_title:gsub("^#", "󰉫")
          return updated_title
        end
        return my_title_transformer
      end,
      object_count_icon_set = "nerdfont", -- Use/fall back on the nerdfont icon set
      object_count_opts = function()
        local opts = {
          link = false, -- Prevent links from being counted
          blockquote = { -- Count block quotes (these aren't counted by default)
            icon = " ",
            count_method = {
              pattern = { "^>.+$" },
              tally = "blocks",
            },
          },
          fncblk = {
            icon = " ",
          },
          par = {
            icon = " ",
          },
        }
        return opts
      end,
      line_count = false, -- Prevent lines from being counted
      word_count = true, -- Count the words in the section
      fill_chars = {
        left_edge = "───────",
        right_edge = "──-",
        item_separator = " · ",
        section_separator = " ╎ ",
        left_inside = " ╟",
        right_inside = "╢ ",
        middle = "─",
      },
    },
  },
}
