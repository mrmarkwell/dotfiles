vim.g.themeindex = 0
function RotateColorscheme()
  local colorstring = { "tokyonight-moon", "tokyonight-night", "tokyonight-storm", "zenburn", "vscode", "gruvbox" }
  vim.g.themeindex = ((vim.g.themeindex + 1) % #colorstring)
  local theme = colorstring[vim.g.themeindex + 1]
  vim.cmd.colorscheme(theme)
  --vim.api.nvim_echo({{':colorscheme ' .. theme}}, false, {})
end

vim.keymap.set("n", "<F8>", RotateColorscheme)
return {
  -- Default colorscheme.
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup()
      vim.cmd([[colorscheme tokyonight-moon]])
    end,
    priority = 1000, -- Load before other start plugins.
  },
  {
    "phha/zenburn.nvim",
    lazy = true,
  },

  -- Other colorschemes.
  -- These are automatically loaded with the |colorscheme| Ex command.
  {
    "mofiqul/vscode.nvim",
    lazy = true,
  },
  {
    "morhetz/gruvbox",
    lazy = true,
    config = function()
      vim.g.gruvbox_contrast_dark = "hard"
      vim.g.gruvbox_invert_selection = false
      vim.g.gruvbox_sign_column = "bg0"
    end,
  },
}
