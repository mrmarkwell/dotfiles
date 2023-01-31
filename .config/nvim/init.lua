vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.lsp.set_log_level("debug")

require("markwell")

-- if google lua module exists, load it.
pcall(require, "google")
