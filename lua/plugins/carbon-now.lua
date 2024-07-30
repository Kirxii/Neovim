return {
  "ellisonleao/carbon-now.nvim",
  lazy = true,
  cmd = "CarbonNow",

  opts = {
    base_url = "https://carbon.now.sh/",
    options = {
      bg = "#f8bbb4",
      drop_shadow_blur = "68px",
      drop_shadow = false,
      drop_shadow_offset_y = "20px",

      font_family = "Cascadia Code",
      font_size = "18px",
      line_height = "133%",
      line_numbers = true,

      theme = "monochrome",
      titlebar = "",
      watermark = false,
      width = "680",
      window_theme = "round",
      padding_horizontal = "100px",
      padding_vertical = "50px",
    },
  },
}
