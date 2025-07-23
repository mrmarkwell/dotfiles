--[[ Brand new neovim config 2025

Rewrite Goals:
1. Simpler. Don't install every plugin I've ever heard of.
2. Update to v11 best practices. Use vim.lsp.
3. Use Snacks.picker instead of Telescope.
4. Use blink.cmp. Very simple lsp config.

NOTE: Reminders of cool functionality.
- General
  - To open neovim with a different config path, set NVIM_APPNAME
    - e.g. `NVIM_APPNAME=nvimtest nvim`
      - this would look in ~/.config/nvimtest for the config.
  - Reload Config
    - `:source %` - reloads the entire file.
    - Highlight lines and `:lua` to run them.
  - Use <ctrl>h, j, k, or l to switch between windows.
  - <leader>config to open nvim config in a new buffer.
  - <leader>gc to open nvim google config in a new buffer.
  - <leader>o -> repoen [O]ld file (most recent buffer that isn't already open)
  - gc -> toggle comment on highlighted region.
  - :terminal to open a terminal (not yet set up).
  - gq -> restructure highlighted region to abide by `textwidth`.
  - After searching, dgn deletes the current highlighted match and goes to next.
    - This can be done repeatedly with "."
- Telescope
  - <leader>help -> search [help]
  - leader>sr -> reopen telescope [S]earch [R]esume.
  - <leader>sk -> [S]earch [K]eymaps (useful if you forget a mapping!).
  - <leader>/ -> fuzzy search in current buffer.
  - <leader>s/ -> fuzzy search in all open buffers
  - <leader>fh -> [F]ind in [H]istory
  - <leader><leader>s{prefix} -> [S]earch for the mapped prefix.
  - <leader><leader>f{prefix} -> [F]ind in the mapped prefix.
- Diagnostics
  - <leader>n and <leader>N to navigate diagnostic messages.
  - <leader>e to show the full error/diagnosic message on the current line.
  - <leader>l to open the quickfix list.

--]]

------------------------ Functions -------------------------
-- Function to map something with a description.
local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true })
end

-- Shorter version for normal keymaps.
local nmap = function(lhs, rhs, desc)
  map('n', lhs, rhs, desc)
end

-- Silent nmap.
local snmap = function(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = desc, silent = true, noremap = true })
end

-- Shorter version for visual keymaps.
local vmap = function(lhs, rhs, desc)
	map('v', lhs, rhs, desc)
end

-- Function to open the most recent N buffers from vim.v.oldfiles
-- Skips already open files.
_G.open_last_n_buffers = function(n)
  -- Get the list of old files
  local oldfiles = vim.v.oldfiles
  -- Calculate the number of files to open
  local count = math.min(n, #oldfiles)
  local opened_count = 0

  -- Get the list of currently open buffers
  local open_buffers = {}
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buffer) then
      local buffer_name = vim.api.nvim_buf_get_name(buffer)
      open_buffers[buffer_name] = true
    end
  end

  -- Open the most recent N files, skipping those already open
  for i = 1, #oldfiles do
    if opened_count >= count then
      break
    end
    local file_path = oldfiles[i]
    if vim.fn.filereadable(file_path) == 1 and not open_buffers[file_path] then
      vim.api.nvim_command('edit ' .. file_path)
      opened_count = opened_count + 1
    end
  end
end

-- Create a command to open the last N buffers
vim.api.nvim_create_user_command('OpenLastNBuffers', function(opts)
  open_last_n_buffers(tonumber(opts.args))
end, { nargs = 1 })

-- Pretty print command - for mapping to an nvim user command "PrettyPrint".
-- Usage:
--  :PrettyPrint(vim.opt.hlsearch)
local pretty_print_command = function(opts)
  -- parse the arguments
  local parsed = load('return ' .. opts.args)()
  local inspect = require('inspect')
  vim.notify(inspect(parsed))
end
vim.api.nvim_create_user_command('PrettyPrint', pretty_print_command, { nargs = '?', desc = 'Inspect a value' })

-- Global pretty print function.
_G.pretty_print = function(var)
  local inspect = require('inspect')
  vim.notify(inspect(var))
end

-- Helper function to check if a list contains a variable.
local function contains(list, var)
  for _, value in ipairs(list) do
    if value == var then
      return true
    end
  end
  return false
end

-- Helper function that checks if a string contains any of the substrings.
local function contains_any(target, substrings)
  for _, substring in ipairs(substrings) do
    if string.find(target, substring, 1, true) then
      return true
    end
  end
  return false
end

------------------------ Globals ---------------------------

vim.g.mapleader = ' ' -- Use <space> as leader.
vim.g.maplocalleader = ' '

-- Don't load built-in plugins.
--vim.g.loaded_matchparen = true
vim.g.loaded_gzip = true
vim.g.loaded_matchit = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_tohtml = true
vim.g.loaded_tutor = true
vim.g.loaded_zipPlugin = true

------------------------ Options ---------------------------

vim.opt.clipboard = "unnamedplus" -- Yank to system clipboard.
vim.opt.showmode = false -- Don't display mode (its in status line).
vim.opt.mouse = 'a' -- Enable mouse mode.
vim.opt.nu = true -- Line numbers.
vim.opt.relativenumber = true -- Relative line numbers.
vim.opt.backup = false -- ciderlsp doesn't work well with backups.
vim.opt.writebackup = false
vim.opt.updatetime = 250 -- Don't wait 4s to trigger CursorHold.
vim.opt.timeoutlen = 250 -- Display which-key faster.
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.textwidth = 80
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.breakindent = true -- wrapped lines indent to the same level.
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showcmd = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')
vim.opt.colorcolumn = '81' -- Putting this at 81 since the 80 is the limit.
vim.opt.autochdir = true -- Change cwd every time moving to buffer.
vim.opt.splitright = true -- Horizontal splits to the right.
vim.opt.splitbelow = true -- Vertical splits below.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split' -- Preview substitutions in real time.
vim.opt.cursorline = true -- Show line with cursor.

------------------------ Keymaps ---------------------------

nmap("<leader><leader>x", "<cmd>source %<CR>", "Source this file")
nmap("<leader>x", ":.lua<CR>", "Source this line") 
vmap("<leader>x", ":lua<CR>", "Source visual selection")
nmap('<leader>y', ':%y<CR>', '[Y]ank entire file')
nmap('<leader>q', '<cmd>bp|bd #<CR>', 'Close current buffer')
nmap('J', 'mzJ`z', "Joining lines shouldn't move the cursor")
nmap('<C-d>', '<C-d>zz', 'Going down centers cursor')
nmap('<C-u>', '<C-u>zz', 'Going up centers cursor')
nmap('n', 'nzzzv', 'Going to next match centers cursor')
nmap('N', 'Nzzzv', 'Going to prev match centers cursor')
vmap('J', ":m '>+1<CR>gv=gv", 'Move visually selected lines down')
vmap('K', ":m '<-2<CR>gv=gv", 'Move visually selected lines up')
vmap('<', '<gv', 'Decrease indent of visual selection.')
vmap('>', '>gv', 'Increase indent of visual selection.')
nmap('<leader>rw', 'ciw<C-R>0<ESC>', '[R]eplace the [w]ord under cursor with previous yank')
-- TODO: Fix this.
--snmap('<esc>', '<esc>:noh<CR>:lua Snacks.notifier.hide()<CR>', 'Esc dismisses highlights and notifications')
snmap('<esc>', '<esc>:noh<CR>', 'Temporary')
nmap('<leader>cfg', '<cmd>e ~/.config/nvim/init.lua<CR>', 'Open Nvim [Config]')
nmap('<leader>gcfg', '<cmd>e ~/.config/nvim/lua/google.lua<CR>', 'Open Nvim [G]oogle [C]onfig')
nmap('<leader>n', vim.diagnostic.goto_next, 'Go to next diagnostic message')
nmap('<leader>N', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
nmap('<leader>e', vim.diagnostic.open_float, 'Show diagnostic [E]rror messages')
nmap('<leader>l', vim.diagnostic.setloclist, 'Open diagnostic quickfix [L]ist')
nmap('<left>', '<cmd>echo "Use h to move!!"<CR>')
nmap('<right>', '<cmd>echo "Use l to move!!"<CR>')
nmap('<up>', '<cmd>echo "Use k to move!!"<CR>')
nmap('<down>', '<cmd>echo "Use j to move!!"<CR>')
nmap('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
nmap('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
nmap('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
nmap('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')
snmap('<leader>o', ':lua open_last_n_buffers(1)<CR>', 'Reopen last buffer')

-- TODO: check on these ones.
nmap('<leader>gb', '<cmd>GitBlameToggle<cr>', 'Toggle [G]it [B]lame')
nmap('<leader>sh', ':lua Snacks.notifier.show_history()<CR>', 'Show notifier history')

------------------------ Aliases ---------------------------

-- Aliases for fat-fingering
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Q', 'q', {})

------------------------ Autocmds --------------------------

-- Don't autoinsert comments when adding new lines.
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

------------------------ Lazy.nvim --------------------------

-- Copied directly from installation instructions in lazy wiki.
-- https://lazy.folke.io/installation

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.lsp.enable({"clangd", "lua_ls"})

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- NOTE: Setting 'opts' in a plugin spec is equivalent to
    --       `require('ThePlugin').setup({...})`

    -- "gc" to comment highlighted selection.
    { 'numToStr/Comment.nvim', opts = {} },
    -- TODO: Setup blink.cmp. Treesitter.
    -- LSP basic setup.
    {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
},
  {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { 'tokyonight-moon' } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
