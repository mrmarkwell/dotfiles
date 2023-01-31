return {
  "folke/zen-mode.nvim",
  event = "VeryLazy",
  config = function()
    require("zen-mode").setup({
      window = {
        width = 90,
        options = {
          number = true,
          relativenumber = true,
        },
      },
    })
  end,
  keys = {
    {
      "<leader>zz",
      vim.cmd.ZenMode,
      desc = "Toggle Zenmode",
    },
  },
}
