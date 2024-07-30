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
    {
      "nvim-telescope/telescope-file-browser.nvim",

      config = function()
        local ts_select_dir_for_grep = function(prompt_bufnr)
          local action_state = require("telescope.actions.state")
          local fb = require("telescope").extensions.file_browser
          local live_grep = require("telescope.builtin").live_grep
          local current_line = action_state.get_current_line()

          fb.file_browser {
            files = false,
            depth = false,
            attach_mappings = function(prompt_bufnr)
              require("telescope.actions").select_default:replace(function()
                local entry_path = action_state.get_selected_entry().Path
                local dir = entry_path:is_dir() and entry_path or entry_path:parent()
                local relative = dir:make_relative(vim.fn.getcwd())
                local absolute = dir:absolute()

                live_grep {
                  results_title = relative .. "/",
                  cwd = absolute,
                  default_text = current_line,
                }
              end)

              return true
            end,
          }
        end
      end,
    },
  },

  opts = {
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
    },
  },
}
