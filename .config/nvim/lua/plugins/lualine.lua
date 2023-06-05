return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  opts = {
    extensions = {
      "nvim-dap-ui",
      "nvim-tree",
      "quickfix",
      "symbols-outline",
    },
    options = {
      globalstatus = true,
      theme = "tokyonight",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        {
          "filename",
          path = 3, -- Absolute path, with tilde for home.
        },
      },
      lualine_x = { "fileformat", "filetype" },
      lualine_y = { "location" },
      lualine_z = { "progress" },
    },
  },
}
