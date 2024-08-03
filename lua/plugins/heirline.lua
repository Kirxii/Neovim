-- NOTE: lsp-saga has heirline as its dependencies so there's no error on startup

return {
  "rebelot/heirline.nvim",
  lazy = false,

  opts = function()
    -- Snippets
    local align = { provider = "%=" }
    local space = { provider = " " }
    local round = { opening = { provider = "" }, closing = { provider = "" } }
    local half = { opening = { provider = "▐" }, closing = { provider = "▌" } }
    local full = { opening = { provider = "█" }, closing = { provider = "█" } }

    -- Libraries
    local utils = require("heirline.utils")
    local conditions = require("heirline.conditions")

    local get_hi = function(highlight)
      return utils.get_highlight(highlight)
    end
    local setup_colors = function()
      local colors = {
				-- stylua: ignore start
        background   = get_hi("Normal").bg,
        color_column = get_hi("ColorColumn").bg,
        pmenu        = get_hi("PMenu").bg,
        normal       = get_hi("Normal").fg,
        tabline      = get_hi("TabLine").bg,
        statusline   = get_hi("StatusLine").bg,
        string       = get_hi("String").fg                     or get_hi("Normal").fg,
        func         = get_hi("Function").fg                   or get_hi("Normal").fg,
        type         = get_hi("Type").fg                       or get_hi("Normal").fg,
        debug        = get_hi("Debug").fg                      or get_hi("Normal").fg,
        comment      = get_hi("Comment").fg                    or get_hi("Normal").fg,
        directory    = get_hi("Directory").fg                  or get_hi("Normal").fg,
        constant     = get_hi("Constant").fg                   or get_hi("Normal").fg,
        statement    = get_hi("Statement").fg                  or get_hi("Normal").fg,
        special      = get_hi("Special").fg                    or get_hi("Normal").fg,
        diag_warn    = get_hi("DiagnosticVirtualTextWarn").fg  or get_hi("Normal").fg,
        diag_warn_2  = get_hi("DiagnosticVirtualTextWarn").bg  or get_hi("Normal").bg,
        diag_error   = get_hi("DiagnosticVirtualTextError").fg or get_hi("Normal").fg,
        diag_error_2 = get_hi("DiagnosticVirtualTextErro").bg  or get_hi("Normal").bg,
        diag_hint    = get_hi("DiagnosticVirtualTextHint").fg  or get_hi("Normal").fg,
        diag_hint_2  = get_hi("DiagnosticVirtualTextHint").bg  or get_hi("Normal").bg,
        diag_info    = get_hi("DiagnosticVirtualTextInfo").fg  or get_hi("Normal").fg,
        diag_info_2  = get_hi("DiagnosticVirtualTextInfo").bg  or get_hi("Normal").bg,
        diag_ok      = get_hi("DiagnosticVirtualTextOk").fg    or get_hi("Normal").fg,
        diag_ok_2    = get_hi("DiagnosticVirtualTextOk").bg    or get_hi("Normal").bg,
        tabline_sel  = get_hi("TabLineSel").bg                 or get_hi("Visual").bg,
        git_del      = get_hi("GitsignsDelete").fg             or get_hi("DiffRemoved").fg or get_hi("DiffDelete").bg,
        git_add      = get_hi("GitsignsAdd").fg                or get_hi("DiffAdded").fg   or get_hi("DiffAdded").bg,
        git_change   = get_hi("GitsignsChange").fg             or get_hi("DiffChange").fg  or get_hi("DiffChange").bg,
        -- stylua: ignore end
      }

      return colors
    end

    utils.on_colorscheme(setup_colors)
    vim.api.nvim_create_augroup("Heirline", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        utils.on_colorscheme(setup_colors)
      end,
      group = "Heirline",
    })

    -- Conditions
    local is_file_buffer = function(buffer)
      return not conditions.buffer_matches({
        buftype = { "nofile", "prompt", "help", "quickfix" },
      }, buffer or 0)
    end
    local is_active_buffer = conditions.is_active()
    local has_repo_buffer = conditions.is_git_repo
    local has_diagnostic_buffer = conditions.has_diagnostics
    local has_lsp_buffer = conditions.lsp_attached()

    -- Components
    local ModeName = {
			-- stylua: ignore start
      ["n"]     = "Normal",
      ["no"]    = "O-Pending",
      ["nov"]   = "O-Pending",
      ["noV"]   = "O-Pending",
      ["no\22"] = "O-Pending",
      ["niI"]   = "Normal",
      ["niR"]   = "Normal",
      ["niV"]   = "Normal",
      ["nt"]    = "Normal",
      ["ntT"]   = "Normal",
      ["v"]     = "Visual",
      ["vs"]    = "Visual",
      ["V"]     = "V-Line",
      ["Vs"]    = "V-Line",
      ["\22"]   = "V-Block",
      ["\22s"]  = "V-Block",
      ["s"]     = "Select",
      ["S"]     = "S-Line",
      ["\19"]   = "S-Block",
      ["i"]     = "Insert",
      ["ic"]    = "Insert",
      ["ix"]    = "Insert",
      ["R"]     = "Replace",
      ["Rc"]    = "Replace",
      ["Rx"]    = "Replace",
      ["Rv"]    = "V-Replace",
      ["Rvc"]   = "V-Replace",
      ["Rvx"]   = "V-Replace",
      ["c"]     = "Command",
      ["cv"]    = "Ex",
      ["ce"]    = "Ex",
      ["r"]     = "Replace",
      ["rm"]    = "More",
      ["r?"]    = "Confirm",
      ["!"]     = "Shell",
      ["t"]     = "Terminal",
      -- stylua: ignore end
    }

    local ModeColors = {
			-- stylua: ignore start
      ["n"]   = "diag_info",
      ["i"]   = "diag_ok",
      ["v"]   = "diag_hint",
      ["V"]   = "diag_hint",
      ["\22"] = "diag_hint",
      ["c"]   = "diag_warn",
      ["s"]   = "diag_warn",
      ["S"]   = "diag_warn",
      ["\19"] = "diag_warn",
      ["R"]   = "diag_error",
      ["r"]   = "diag_error",
      ["!"]   = "diag_error",
      ["t"]   = "diag_info",
      -- stylua: ignore end
    }

    local ModeDisplay = {
      provider = function(self)
        local mode = self.mode
        return "󰻂 " .. ModeName[mode]
      end,
      hl = function(self)
        local modeShort = self.mode:sub(1, 1)
        return {
          fg = "background",
          bg = ModeColors[modeShort],
          bold = true,
        }
      end,
    }

    local Mode = {
      init = function(self)
        self.mode = vim.fn.mode(1)
      end,

      update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
          vim.cmd("redrawstatus")
        end),
      },

      round["opening"],
      ModeDisplay,
      round["closing"],
      space,

      hl = function(self)
        local modeShort = self.mode:sub(1, 1)
        return {
          fg = ModeColors[modeShort],
          bg = "background",
        }
      end,
    }

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
        return { fg = self.icon_color, bg = "pmenu" }
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
          return { fg = "diag_warn", bg = "pmenu" }
        elseif self.unmodifiable then
          return { fg = "diag_warn", bg = "pmenu" }
        end

        return { fg = "normal", bg = "pmenu" }
      end,
    }

    local FileSize = {}

    local FileModifiedFlag = {
      condition = function(self)
        return self.modified
      end,

      provider = " ",

      hl = { fg = "diag_warn", bg = "pmenu" },
    }

    local FileUnmodifiableFlag = {
      condition = function(self)
        return self.unmodifiable
      end,

      provider = " ",
      hl = { fg = "diag_error", bg = "pmenu" },
    }

    local File = {
      init = function(self)
        self.filepath = vim.api.nvim_buf_get_name(0)
        self.filename = vim.fn.fnamemodify(self.filepath, ":t")
        self.filedirectory = vim.fn.fnamemodify(self.filepath, ":h")
        self.fileextension = vim.fn.fnamemodify(self.filepath, ":e")

        self.modified = vim.bo.modified
        self.unmodifiable = not vim.bo.modifiable or vim.bo.readonly
      end,

      hl = { fg = "pmenu", bg = "background" },

      round["opening"],
      FileIcon,
      FileName,
      FileSize,
      FileModifiedFlag,
      FileUnmodifiableFlag,
      round["closing"],
      space,
    }

    local GitBranch = {
      provider = function(self)
        return " " .. self.status_dict.head
      end,
      hl = { fg = "diag_hint", bold = true },
    }

    local GitAdd = {
      provider = function(self)
        local count = self.status_dict.added or 0
        return count > 0 and ("  " .. count)
      end,
      hl = { fg = "git_add" },
    }

    local GitChange = {
      provider = function(self)
        local count = self.status_dict.changed or 0
        return count > 0 and ("  " .. count)
      end,
      hl = { fg = "git_change" },
    }

    local GitDelete = {
      provider = function(self)
        local count = self.status_dict.removed or 0
        return count > 0 and ("  " .. count)
      end,
      hl = { fg = "git_del" },
    }

    local Git = {
      condition = has_repo_buffer,

      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
      end,

      static = {
        add = " ",
        change = " ",
        delete = " ",
      },

      hl = { fg = "color_column", bg = "background" },

      round["opening"],
      {
        hl = { fg = "normal", bg = "color_column" },

        GitBranch,
        GitAdd,
        GitChange,
        GitDelete,
      },
      round["closing"],
      space,
    }

    local DiagnosticsError = {
      provider = function(self)
        -- 0 is just another output, we can decide to print it or not!
        local error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text
        return self.errors > 0 and (error_icon .. self.errors .. " ")
      end,
      hl = { fg = "diag_error" },
    }

    local DiagnosticsWarn = {
      provider = function(self)
        local warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text
        return self.warnings > 0 and (warn_icon .. self.warnings .. " ")
      end,
      hl = { fg = "diag_warn" },
    }

    local DiagnosticsInfo = {
      provider = function(self)
        local info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text
        return self.info > 0 and (info_icon .. self.info .. " ")
      end,
      hl = { fg = "diag_info" },
    }

    local DiagnosticsHint = {
      provider = function(self)
        local hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text
        return self.hints > 0 and (hint_icon .. self.hints .. " ")
      end,
      hl = { fg = "diag_hint" },
    }

    local Diagnostics = {
      condition = has_diagnostic_buffer,

      init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,

      DiagnosticsError,
      DiagnosticsWarn,
      DiagnosticsInfo,
      DiagnosticsHint,
    }

    local FileEncodingIcon = {
      static = {
        icon = {
          ["utf-8"] = "󰉿",
          ["utf-16"] = "󰊀",
          ["utf-32"] = "󰊁",
          ["utf-8mb4"] = "󰊂",
          ["utf-16le"] = "󰊃",
          ["utf-16be"] = "󰊄",
        },
      },

      provider = function(self)
        return self.icon[self.encoding] .. " "
      end,

      hl = { fg = "normal", bg = "color_column" },
    }

    local FileEncodingValue = {
      provider = function(self)
        return self.encoding:upper()
      end,

      hl = { fg = "normal", bg = "color_column" },
    }

    local FileEncoding = {
      init = function(self)
        self.encoding = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
      end,

      hl = { fg = "color_column", bg = "background" },

      round["opening"],
      FileEncodingIcon,
      FileEncodingValue,
      round["closing"],
    }

    local Breadcrumb = {
      condition = function()
        return is_file_buffer()
      end,

      update = { "CursorMoved", "CursorMovedI" },

      provider = function()
        local content = require("lspsaga.symbol.winbar").get_bar()
        return (content or "LSP not found") .. "%="
      end,
      hl = { bg = "background" },
    }

    local FileStatusline = {
      condition = function()
        return is_file_buffer()
      end,

      hl = { bg = "background" },

      Mode,
      File,
      Git,
      align,
      Diagnostics,
      FileEncoding,
    }

    local OthersStatusline = {}

    local Statusline = {
      FileStatusline,
      OthersStatusline,
    }

    return {
      -- NOTE: %C is the fold column
      -- %l is the line number (absolute)
      -- %r is the line number (relative)

      statusline = Statusline,
      winbar = { Breadcrumb },
      tabline = {},
      statuscolumn = {
        {
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
