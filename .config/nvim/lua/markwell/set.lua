vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.showcmd = true

vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"

vim.opt.laststatus = 2
vim.opt.statusline = "%F%m%r%h%w (%{&ff}){%Y} [%l,%v][%p%%]"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.opt.pastetoggle = "<F10>"

vim.opt.completeopt = "longest,menuone,preview"

-- set the current working directory every time moving to a buffer.
vim.opt.autochdir = true

vim.g.mapleader = " "
