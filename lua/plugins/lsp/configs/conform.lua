local formatters_by_ft = {
  lua = { "stylua" },
  css = { "prettier" },
  flow = { "prettier" },
  graphql = { "prettier" },
  html = { "prettier" },
  json = { "prettier" },
  javascript = { "prettier" },
  javascriptreact = { "prettier" },
  less = { "prettier" },
  markdown = { "prettier" },
  scss = { "prettier" },
  typescript = { "prettier" },
  typescriptreact = { "prettier" },
  vue = { "prettier" },
}

local prettier_ft = {
  "css",
  "flow",
  "graphql",
  "html",
  "json",
  "javascriptreact",
  "javascript",
  "less",
  "markdown",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
}

for _, filetype in pairs(prettier_ft) do
  formatters_by_ft[filetype] = { "prettier" }
end

return {
  "stevearc/conform.nvim",
  -- event = { "BufReadPost", "BufNewFile" },
  opts = {
    formatters_by_ft = formatters_by_ft,
    format_on_save = {
      quiet = true,
      lsp_fallback = true,
    },
  },
}
