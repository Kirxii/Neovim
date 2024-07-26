return {
  "williamboman/mason.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonInstallAll",
    "MasonUpdate",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
  },

  dependencies = {
    "stevearc/dressing.nvim",
    {
      "williamboman/mason-lspconfig.nvim",

      opts = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

        mason.setup({
          ui = {
            check_outdated_packages_on_open = false,
            icons = {
              package_pending = "○ ",
              package_installed = "● ",
              package_uninstalled = "○ ",
            },
          },
        })

        mason_lspconfig.setup({
          automatic_installation = true,
          ensure_installed = {
            -- Lua
            "lua_ls",
            "vimls",

            -- Web development
            "cssls",
            "html",
            "tsserver",
            "denols",
            "vuels",
            "tailwindcss",
            "emmet_language_server",
          },
        })

        -- NOTE: Automatically fetch installed servers from Mason and run it
        mason_lspconfig.setup_handlers({
          function(server_name)
            local opts = {}

            local ok, server = pcall(require, "plugins.lsp.settings" .. server_name)
            if ok then
              opts = vim.tbl_deep_extend("force", server, opts)
            end

            require("lspconfig")[server_name].setup(opts)
          end,
        })
      end,
    },
  },
}
