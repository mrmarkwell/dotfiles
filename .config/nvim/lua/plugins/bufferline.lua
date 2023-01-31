return {
  "akinsho/bufferline.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  opts = {
    options = {
      custom_filter = function(buf_number)
        return vim.api.nvim_buf_get_option(buf_number, "buftype") ~= "quickfix"
      end,
      diagnostics = "nvim_lsp",
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
        },
      },
      show_buffer_close_icons = false,
      show_close_icon = false,
    },
    highlights = {
      buffer_selected = { italic = false },
      diagnostic_selected = { italic = false },
      duplicate = { italic = false },
      duplicate_selected = { italic = false },
      duplicate_visible = { italic = false },
      error_diagnostic_selected = { italic = false },
      error_selected = { italic = false },
      hint_diagnostic_selected = { italic = false },
      hint_selected = { italic = false },
      info_diagnostic_selected = { italic = false },
      info_selected = { italic = false },
      numbers_selected = { italic = false },
      pick = { italic = false },
      pick_selected = { italic = false },
      pick_visible = { italic = false },
      warning_diagnostic_selected = { italic = false },
      warning_selected = { italic = false },
    },
  },
  config = function(_, opts)
    -- Set up Bufferline.
    require("bufferline").setup(opts)

    -- Set keymaps.
    vim.keymap.set("n", "<Left>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
    vim.keymap.set("n", "<Right>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "<Leader><Left>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
    vim.keymap.set("n", "<Leader><Right>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
  end,
}
