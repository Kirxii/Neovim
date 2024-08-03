return {
  "jbyuki/nabla.nvim",

  config = function()
    vim.keymap.set("n", "<leader>p", function()
      return require("nabla").popup()
    end, { silent = true })
  end,
}
