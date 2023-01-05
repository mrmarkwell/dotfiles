function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)

--  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

vim.g.themeindex = 0
function RotateColorscheme()
  local colorstring = { 'rose-pine', 'zenburn' }
  vim.g.themeindex = ((vim.g.themeindex + 1) % #colorstring)
  ColorMyPencils(colorstring[vim.g.themeindex + 1])
end

vim.keymap.set("n", "<F8>", RotateColorscheme)
