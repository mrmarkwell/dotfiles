vim.g.mapleader = " "

function _G.nmap(lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set("n", lhs, rhs, opts)
end

function _G.vmap(lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set("v", lhs, rhs, opts)
end

function _G.imap(lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set("i", lhs, rhs, opts)
end

-- Big keyboards have backtick where my escape key is on my little keyboard.
nmap("`", "<esc>")
vmap("`", "<esc>")
imap("`", "<esc>")

-- make it possible to move highighted lines with capital J and K
vmap("J", ":m '>+1<CR>gv=gv")
vmap("K", ":m '<-2<CR>gv=gv")

-- Make joining lines not move the cursor.
nmap("J", "mzJ`z")
nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")
nmap("n", "nzzzv")
nmap("N", "Nzzzv")

-- Close buffer without closing
nmap("<leader>q", "<cmd>bp|bd #<CR>", "Close current buffer")

-- <leader>y yanks to system clipboard instead of just to vim.
nmap("<leader>y", '"+y')
vmap("<leader>y", '"+y')
nmap("<leader>Y", '"+Y')

-- Disable chronological history (I open this accidentally all the time)
-- TODO(markwell): This doesn't work...
nmap("q:", "<nop>")
vim.cmd([[nnoremap q: <nop>]])

-- Aliases for fat-fingering
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("Q", "q", {})

-- Quick fix list navigation
nmap("<C-k>", "<cmd>cnext<CR>zz")
nmap("<C-j>", "<cmd>cprev<CR>zz")
nmap("<leader>k", "<cmd>lnext<CR>zz")
nmap("<leader>j", "<cmd>lprev<CR>zz")

-- start a find-replace for the token under the cursor in the current file
-- TODO(markwell): What should this mapping be?
--nmap("<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
