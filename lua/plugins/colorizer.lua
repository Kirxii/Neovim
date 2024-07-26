return {
  "NvChad/nvim-colorizer.lua",

  opts = {
    filetypes = {
      "*",
      "!markdown",
    },
    user_default_options = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      AARRGGBB = true, -- 0xAARRGGBB hex codes
      names = true, -- "Name" codes like Blue or blue
      rgb_fn = false, -- CSS rgb() and rgba() functions
      hsl_fn = false, -- CSS hsl() and hsla() functions
      css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn

      mode = "background", -- Set the display mode.

      tailwind = false, -- Enable tailwind colors
      sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
      virtualtext = "█",

      always_update = true,
    },
  },
}
