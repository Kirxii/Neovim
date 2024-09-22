---@diagnostic disable: unused-local, param-type-mismatch

return {
  "goolord/alpha-nvim",
  priority = 1,

  dependencies = {
    "HiPhish/rainbow-delimiters.nvim",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local headers = require("core.headers")

    local if_nil = vim.F.if_nil
    local leader = "SPC"

    ---@param keybind string
    ---@param text string
    ---@param action string?
    ---@param action_opts table?
    local button = function(keybind, text, action, action_opts)
      local trueKeybind = keybind:gsub("%s", ""):gsub(leader, "<leader>")

      local opts = {
        position = "center",
        shortcut = keybind,
        cursor = 2,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
      }

      if action then
        action_opts = if_nil(action_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", trueKeybind, action, action_opts }
      end

      local on_press = function()
        local key = vim.api.nvim_replace_termcodes(action or trueKeybind .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
      end

      return {
        type = "button",
        val = text,
        on_press = on_press,
        opts = opts,
      }
    end

    local text = function(value)
      local opts = {
        position = "center",
        hl = "Boolean",
      }

      return {
        type = "text",
        val = value,
        opts = opts,
      }
    end

    ---@param amount number
    local padding = function(amount)
      return {
        type = "padding",
        val = amount,
      }
    end

    dashboard.section.buttons.opts = { spacing = 0 }
    dashboard.section.buttons.val = {
      text("Main Menu"),

      padding(1),

      button("SPC f n", " New file", "<CMD>ene <BAR> startinsert <CR>"),
      button("SPC f f", " Find file", "<CMD>cd $HOME <BAR> Telescope find_files hidden=true no_ignore=true <CR>"),
      button("SPC f w", "󰈭 Find word", "<CMD>cd $HOME <BAR> Telescope live_grep <CR>"),
      button("SPC f h", " Recent files", "<CMD>Telescope oldfiles <CR>"),
      button("SPC f m", " Bookmarks", "<CMD>Telescope marks <CR>"),
      button("SPC q  ", " Quit neovim", "<CMD>qa<CR>"),

      padding(1),

      text("Useful shortcuts"),
      button("SPC t p", " Plugins", "<CMD>Lazy<CR>"),
      button("SPC t l", " LSPs", "<CMD>Mason<CR>"),
      button("SPC h  ", "? Help", "<CMD>Telescope help_tags<CR>"),
    }

    local function getCharLen(s, pos)
      local byte = string.byte(s, pos)
      if not byte then
        return nil
      end
      return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
    end

    local function applyColors(logo, colors, logoColors)
      dashboard.section.header.val = logo

      for key, color in pairs(colors) do
        local name = "Alpha" .. key
        vim.api.nvim_set_hl(0, name, color)
        colors[key] = name
      end

      dashboard.section.header.opts.hl = {}
      for i, line in ipairs(logoColors) do
        local highlights = {}
        local pos = 0

        for j = 1, #line do
          local opos = pos
          pos = pos + getCharLen(logo[i], opos + 1)

          local color_name = colors[line:sub(j, j)]
          if color_name then
            table.insert(highlights, { color_name, opos, pos })
          end
        end

        table.insert(dashboard.section.header.opts.hl, highlights)
      end
      return dashboard.opts
    end

    require("alpha").setup(applyColors({
      [[  ███       ███  ]],
      [[  ████      ████ ]],
      [[  ████     █████ ]],
      [[ █ ████    █████ ]],
      [[ ██ ████   █████ ]],
      [[ ███ ████  █████ ]],
      [[ ████ ████ ████ ]],
      [[ █████  ████████ ]],
      [[ █████   ███████ ]],
      [[ █████    ██████ ]],
      [[ █████     █████ ]],
      [[ ████      ████ ]],
      [[  ███       ███  ]],
      [[                    ]],
      [[  N  E  O  V  I  M  ]],
    }, {
      ["b"] = { fg = "#3399ff", ctermfg = 33 },
      ["a"] = { fg = "#53C670", ctermfg = 35 },
      ["g"] = { fg = "#39ac56", ctermfg = 29 },
      ["h"] = { fg = "#33994d", ctermfg = 23 },
      ["i"] = { fg = "#33994d", bg = "#39ac56", ctermfg = 23, ctermbg = 29 },
      ["j"] = { fg = "#53C670", bg = "#33994d", ctermfg = 35, ctermbg = 23 },
      ["k"] = { fg = "#30A572", ctermfg = 36 },
    }, {
      [[  kkkka       gggg  ]],
      [[  kkkkaa      ggggg ]],
      [[ b kkkaaa     ggggg ]],
      [[ bb kkaaaa    ggggg ]],
      [[ bbb kaaaaa   ggggg ]],
      [[ bbbb aaaaaa  ggggg ]],
      [[ bbbbb aaaaaa igggg ]],
      [[ bbbbb  aaaaaahiggg ]],
      [[ bbbbb   aaaaajhigg ]],
      [[ bbbbb    aaaaajhig ]],
      [[ bbbbb     aaaaajhi ]],
      [[ bbbbb      aaaaajh ]],
      [[  bbbb       aaaaa  ]],
      [[                    ]],
      [[  1  1  1  2  2  2  ]],
    }))
  end,
}
