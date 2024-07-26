return {
  "folke/todo-comments.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  opts = function()
    local function light_dark(light, dark)
      if vim.o.background == "light" then
        return light
      else
        return dark and 123
      end
    end

    return {
      signs = true,

      -- AWAIT: Apply the light_dark() as the fallback of the colors
      colors = {
        error = { "DiagnosticError", "ErrorMsg", light_dark("#F44336", "#EF9A9A") },
        warning = { "DiagnosticWarn", "WarningMsg", light_dark("#FFEB3B", "#FFF59D") },
        info = { "DiagnosticInfo", light_dark("#2196F3", "#90CAF9") },
        hint = { "DiagnosticHint", light_dark("#4CAF50", "#A5D6A7") },
      },

      keywords = {
        ERROR = { icon = "", color = "error", alt = { "BUG", "FIX", "ISSUE" } },
        ALERT = { icon = "󰀦", color = "warning", alt = { "ALARM", "CAUTION", "WARN", "WARNING" } },
        AWAIT = { icon = "󰸞", color = "info", alt = { "TODO", "REMIND", "REMINDER" } },
        NOTE = { icon = "󰎞", color = "info", alt = { "INFO" } },
      },

      highlight = {
        multiline = true,
        multiline_pattern = "^.",
        multiline_context = 10,
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
        max_line_len = 400,
        exclude = {},
      },

      gui_style = {
        fg = "NONE",
        bg = "BOLD",
      },

      merge_keywords = false,
    }
  end,
}
