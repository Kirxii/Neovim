-- NOTE: lsp-saga has heirline as its dependencies so there's no error on startup

return {
  "rebelot/heirline.nvim",

  opts = function()
    -- Libraries
    local utils = require("heirline.utils")
    local conditions = require("heirline.conditions")

    -- Conditions
    local is_file_buffer = function(buffer)
      return not conditions.buffer_matches({
        buftype = { "nofile", "prompt", "help", "quickfix" },
      }, buffer or 0)
    end
    local is_active_buffer = function()
      return conditions.is_active()
    end
    local has_repo_buffer = function()
      return conditions.is_git_repo()
    end
    local has_diagnostic_buffer = function()
      return conditions.has_diagnostics()
    end
    local has_lsp_buffer = function()
      return conditions.lsp_attached()
    end

    -- Components
    local FileIcon = {
      init = function(self)
        self.icon, self.icon_color =
          require("nvim-web-devicons").get_icon_color(self.filename, self.fileextension, { default = true })

        if self.filename == "" then
          self.icon = ""
          self.icon_color = utils.get_highlight("DiagnosticError").fg
        end
      end,

      provider = function(self)
        return self.icon .. " "
      end,
      hl = function(self)
        return { fg = self.icon_color }
      end,
    }

    local FileName = {
      provider = function(self)
        if self.filename == "" then
          return "Unnamed File"
        end

        return self.filename
      end,
      hl = function(self)
        if self.modified then
          return { fg = utils.get_highlight("DiagnosticWarn").fg }
        elseif self.unmodifiable then
          return { fg = utils.get_highlight("DiagnosticError").fg }
        end
      end,
    }

    local FileFlags = {
      {
        condition = function(self)
          return self.modified
        end,

        provider = " ",

        hl = { fg = utils.get_highlight("DiagnosticWarn").fg },
      },
      {
        condition = function(self)
          return self.unmodifiable
        end,

        provider = " ",
        hl = { fg = utils.get_highlight("DiagnosticError").fg },
      },
    }

    local FileInfo = {
      init = function(self)
        self.filepath = vim.api.nvim_buf_get_name(0)
        self.filename = vim.fn.fnamemodify(self.filepath, ":t")
        self.filedirectory = vim.fn.fnamemodify(self.filepath, ":h")
        self.fileextension = vim.fn.fnamemodify(self.filepath, ":e")

        self.modified = vim.bo.modified
        self.unmodifiable = not vim.bo.modifiable or vim.bo.readonly
      end,

      FileIcon,
      FileName,
      FileFlags,
    }

    local Breadcrumb = {
      condition = function()
        return is_file_buffer()
      end,

      update = { "CursorMoved", "CursorMovedI" },

      provider = function()
        local content = require("lspsaga.symbol.winbar").get_bar()
        return content or "LSP not found"
      end,
    }

    local FileStatusline = {
      condition = function()
        return is_file_buffer()
      end,

      FileInfo,
    }

    local OthersStatusline = {}

    local Statusline = {
      FileStatusline,
      OthersStatusline,
    }

    return {
      -- NOTE: %C is the fold column
      -- NOTE: %l is the line number (absolute)
      -- NOTE: %r is the line number (relative)

      statusline = Statusline,
      winbar = { Breadcrumb },
      tabline = {},
      statuscolumn = {
        {
          condition = function()
            return is_file_buffer()
          end,

          provider = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . ' ' : v:lnum) : ''}%=%s",
        },
      },

      opts = {
        disable_winbar_cb = function(args)
          return not is_file_buffer(args.buf)
        end,
      },
    }
  end,
  config = function(_, opts)
    vim.opt.showcmdloc = "statusline"

    require("heirline").setup(opts)
  end,
}
