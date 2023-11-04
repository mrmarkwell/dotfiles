vim.g.mapleader = " "
vim.g.maplocalleader = " "

--vim.lsp.set_log_level("off")
-- Turn this on for debugging!
vim.lsp.set_log_level("debug")

require("markwell")

-- if google lua module exists, load it.
--pcall(require, "google")

-- on my Google system, just require directly, since pcall messes with errors getting propagated back to me.
require("google")
