-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- vim.api.nvim_create_autocmd("ColorScheme", {
--  group = vim.api.nvim_create_augroup("wezterm_colorscheme", { clear = true }),
--  callback = function(args)
--    local colorschemes = {
--      ["catppuccin-latte"] = "Catppuccin Latte",
--      ["catppuccin-frappe"] = "Catppuccin Frappe",
--      ["catppuccin-macchiato"] = "Catppuccin Macchiato",
--      ["catppuccin-mocha"] = "Catppuccin Mocha",
--      ["dayfox"] = "dayfox",
--      ["dawnfox"] = "dawnfox",
--      ["carbonfox"] = "carbonfox",
--      ["nordfox"] = "nordfox",
--      ["nightfox"] = "nightfox",
--      ["duskfox"] = "duskfox",
--      ["terafox"] = "terafox",
--      ["monochrome"] = "Mono (terminal.sexy)",
--    }
--
--    local colorscheme = colorschemes[args.match]
--    if not colorscheme then
--      return
--    end
--
--    -- local neovim_colorscheme = vim.fn.expand("~/Appdata/Local/nvim/lua/core/colorscheme")
--    -- assert(type(neovim_colorscheme) == "string")
--    -- local neovim = io.open(neovim_colorscheme, "w")
--    -- assert(neovim)
--    -- neovim:write(args.match)
--    -- neovim:close()
--
--    local wezterm_colorscheme = vim.fn.expand("~/.wezterm_colorscheme")
--    assert(type(wezterm_colorscheme) == "string")
--    local wezterm = io.open(wezterm_colorscheme, "w")
--    assert(wezterm)
--    wezterm:write(colorscheme)
--    wezterm:close()
--
--    vim.notify("Setting wezterm colorscheme to " .. colorscheme, vim.log.levels.INFO)
--  end,
-- })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("wezterm_colorscheme", { clear = true }),
  callback = function(args)
    local colorschemes = {
      ["catppuccin-frappe"] = "Catppuccin Frappe",
      ["catppuccin-latte"] = "Catppuccin Latte",
      ["catppuccin-macchiato"] = "Catppuccin Macchiato",
      ["catppuccin-mocha"] = "Catppuccin Mocha",
      ["dayfox"] = "dayfox",
      ["dawnfox"] = "dawnfox",
      ["carbonfox"] = "carbonfox",
      ["nordfox"] = "nordfox",
      ["nightfox"] = "nightfox",
      ["duskfox"] = "duskfox",
      ["terafox"] = "terafox",
      ["monochrome"] = "Mono (terminal.sexy)",
    }

    local colorscheme = colorschemes[args.match]
    if not colorscheme then
      return
    end

    local neovim_colorscheme = vim.fn.stdpath("config") .. "/lua/core/colorscheme"
    assert(type(neovim_colorscheme) == "string")
    local neovim = io.open(neovim_colorscheme, "w")
    assert(neovim)
    neovim:write(args.match)
    neovim:close()

    local wezterm_dir = vim.fn.expand("~/.wezterm.lua")
    assert(type(wezterm_dir) == "string")

    local wezterm_read = io.open(wezterm_dir, "r")
    assert(wezterm_read)
    local config = string.gsub(
      wezterm_read:read("*a"),
      'config%.color_scheme = ".+"\nconfig%.force_reverse_video_cursor',
      'config%.color_scheme = "' .. colorscheme .. '"\nconfig.force_reverse_video_cursor'
    )
    wezterm_read:close()

    local wezterm_write = io.open(wezterm_dir, "w")
    assert(wezterm_write)
    wezterm_write:write(config)
    wezterm_write:close()
  end,
})
