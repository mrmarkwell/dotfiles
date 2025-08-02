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
  - `:help deprecated` shows deprecated items with the correct alternative.
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
vim.open_last_n_buffers = function(n)
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
  vim.open_last_n_buffers(tonumber(opts.args))
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
vim.pretty_print = function(var)
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
vim.opt.showmode = false          -- Don't display mode (its in status line).
vim.opt.mouse = 'a'               -- Enable mouse mode.
vim.opt.nu = true                 -- Line numbers.
vim.opt.relativenumber = true     -- Relative line numbers.
vim.opt.backup = false            -- ciderlsp doesn't work well with backups.
vim.opt.writebackup = false
vim.opt.updatetime = 250          -- Don't wait 4s to trigger CursorHold.
vim.opt.timeoutlen = 250          -- Display which-key faster.
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
vim.opt.autochdir = true   -- Change cwd every time moving to buffer.
vim.opt.splitright = true  -- Horizontal splits to the right.
vim.opt.splitbelow = true  -- Vertical splits below.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split' -- Preview substitutions in real time.
vim.opt.cursorline = true    -- Show line with cursor.

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
snmap('<esc>', '<esc>:noh<CR>:lua Snacks.notifier.hide()<CR>', 'Esc dismisses highlights and notifications')
--snmap('<esc>', '<esc>:noh<CR>', 'Temporary')
nmap('<leader>cfg', '<cmd>e ~/.config/nvim/init.lua<CR>', 'Open Nvim [Config]')
nmap('<leader>gcfg', '<cmd>e ~/.config/nvim/lua/google.lua<CR>', 'Open Nvim [G]oogle [C]onfig')
nmap('<leader>f', vim.lsp.buf.format, "Format file")
nmap('<leader>n', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Go to next diagnostic message')
nmap('<leader>N', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Go to previous diagnostic message')
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
snmap('<leader>o', ':lua vim.open_last_n_buffers(1)<CR>', 'Reopen last buffer')
nmap('<leader>gb', '<cmd>GitBlameToggle<CR>', 'Toggle [G]it [B]lame')
nmap('<leader>sh', ':lua Snacks.notifier.show_history()<CR>', 'Show notifier history')
nmap('<leader>O', '<cmd>Oil<CR>', 'Open Oil in current directory.')

-- Jump to the definition of the word under your cursor.
--  This is where a variable was first declared, or where a function is defined, etc.
--  To jump back, press <C-t>.
-- nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

-- Find references for the word under your cursor.
--nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

-- Jump to the implementation of the word under your cursor.
--  Useful when your language has ways of declaring types without an actual implementation.
-- nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

-- Jump to the type of the word under your cursor.
--  Useful when you're not sure what type a variable is and you want to see
--  the definition of its *type*, not where it was *defined*.
-- nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

-- Fuzzy find all the symbols in your current document.
--  Symbols are things like variables, functions, types, etc.
-- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

-- Fuzzy find all the symbols in your current workspace.
--  Similar to document symbols, except searches over your entire project.
-- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

-- Rename the variable under your cursor.
--  Most Language Servers support renaming across files, etc.
nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

-- Execute a code action, usually your cursor needs to be on top of an error
-- or a suggestion from your LSP for this to activate.
nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

-- Opens a popup that displays documentation about the word under your cursor
--  See `:help K` for why this keymap.
nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

-- WARN: This is not Goto Definition, this is Goto Declaration.
--  For example, in C this would take you to the header.
nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

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
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.lsp.enable({ "clangd", "lua_ls" })

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- NOTE: Setting 'opts' in a plugin spec is equivalent to
    --       `require('ThePlugin').setup({...})`

    -- "gc" to comment highlighted selection.
    { 'numToStr/Comment.nvim',                   opts = {} },

    -- Only really using this because of :LspInfo and :LspRestart
    { 'https://github.com/neovim/nvim-lspconfig' },

    {
      'saghen/blink.cmp',

      -- use a release tag to download pre-built binaries
      version = '*',

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

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          -- Do I need buffer? It turns off comment completions without it.
          default = { 'lsp', 'path', 'snippets' },
          -- default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        -- Use the rust matcher, not the fuzzy one.
        fuzzy = { implementation = "prefer_rust_with_warning" },

        -- Experimental signature support
        signature = { enabled = true },
      },
      opts_extend = { "sources.default" }
    },
    {
      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          { path = "snacks.nvim",        words = { "Snacks" } },
        },
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      branch = 'master',
      lazy = false,
      build = ":TSUpdate",
      opts = {
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
          enable = true,
        },
        folds = {
          enable = true,
        },
      },
    },
    {
      -- Useful plugin to show you pending keybinds.
      'folke/which-key.nvim',
      event = 'VimEnter', -- Sets the loading event to 'VimEnter'
      opts = {
        -- Put the popup in the bottom-right.
        preset = 'helix',
        -- Expand sub groups if they're just a single thing.
        --expand = 1,
        expand = function(node)
          -- Expand if there is no description.
          return not node.desc
        end,
        spec = {
          { '<leader>c',        group = '[C]ode' },
          { '<leader>d',        group = '[D]ocument' },
          { '<leader>r',        group = '[R]ename' },
          { '<leader>s',        group = '[S]earch' },
          { '<leader>w',        group = '[W]orkspace' },
          { '<leader>f',        group = '[F]ind' },
          { '<leader><leader>', group = 'Telescope Path' },
        },
      },
      keys = {
        {
          '<leader>?',
          function()
            require('which-key').show({ global = false })
          end,
          desc = 'Buffer Local Keymaps (which-key)',
        },
      },
    },
    {
      'stevearc/oil.nvim',
      opts = {},
    },
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        animate = { enabled = false }, -- not a fan of animations.
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = {
          enabled = true,
          timeout = 3000,
        },
        picker = { enabled = true, },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = {
          notification = {
            wo = { wrap = true }
          }
        }
      },
      keys = {
        -- Top Pickers & Explorer
        { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
        { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
        { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
        { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
        -- find
        { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
        { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
        { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
        { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
        -- git
        { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
        { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
        { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
        { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
        { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
        { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
        { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
        -- Grep
        { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
        { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
        { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
        -- search
        { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
        { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
        { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
        { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
        { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
        { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
        { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
        { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
        { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
        { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
        { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
        { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
        { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
        { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
        { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
        { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
        { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
        { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
        { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
        { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
        { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
        -- LSP
        { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
        { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
        { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
        { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
        { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
        { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
        { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
        -- Other
        { "<leader>z",       function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
        { "<leader>Z",       function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
        { "<leader>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
        { "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
        { "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
        { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
        { "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
        { "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
        { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
        { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
        { "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
        { "<c-_>",           function() Snacks.terminal() end,                                       desc = "which_key_ignore" },
        { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",           mode = { "n", "t" } },
        { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",           mode = { "n", "t" } },
        {
          "<leader>N",
          desc = "Neovim News",
          function()
            Snacks.win({
              file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
              width = 0.6,
              height = 0.6,
              wo = {
                spell = false,
                wrap = false,
                signcolumn = "yes",
                statuscolumn = " ",
                conceallevel = 3,
              },
            })
          end,
        }
      },
      init = function()
        vim.api.nvim_create_autocmd("User", {
          pattern = "VeryLazy",
          callback = function()
            -- Setup some globals for debugging (lazy-loaded)
            _G.dd = function(...)
              Snacks.debug.inspect(...)
            end
            _G.bt = function()
              Snacks.debug.backtrace()
            end
            vim.print = _G.dd -- Override print to use snacks for `:=` command

            -- Create some toggle mappings
            Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
            Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
            Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
            Snacks.toggle.diagnostics():map("<leader>ud")
            Snacks.toggle.line_number():map("<leader>ul")
            Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                :map("<leader>uc")
            Snacks.toggle.treesitter():map("<leader>uT")
            Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
              "<leader>ub")
            Snacks.toggle.inlay_hints():map("<leader>uh")
            Snacks.toggle.indent():map("<leader>ug")
            Snacks.toggle.dim():map("<leader>uD")
          end,
        })
      end,
    },
    {
      'akinsho/bufferline.nvim',
      version = "*",
      dependencies = 'nvim-tree/nvim-web-devicons',
      config = function(_, opts)
        -- Set up Bufferline.
        require('bufferline').setup(opts)

        -- Set keymaps.
        vim.keymap.set('n', '<Left>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
        vim.keymap.set('n', '<Right>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
        vim.keymap.set('n', '<Leader><Left>', '<Cmd>BufferLineMovePrev<CR>', { desc = 'Move buffer left' })
        vim.keymap.set('n', '<Leader><Right>', '<Cmd>BufferLineMoveNext<CR>', { desc = 'Move buffer right' })
      end,
    },
    {
      'f-person/git-blame.nvim',
      event = 'VeryLazy',
      config = function()
        require('gitblame').setup({
          --Note how the `gitblame_` prefix is omitted in `setup`
          enabled = true,
          highlight_group = 'Comment',
          virtual_text_column = 80,
          date_format = '%r',
          message_template = '        <author> • <date> • <summary>',
          message_when_not_committed = '        Not committed yet...',
        })
      end,
    },
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- Go to file in lua.
    { 'sam4llis/nvim-lua-gf', ft = 'lua' },
    {
      'mbbill/undotree',
      event = 'VeryLazy',
      keys = {
        {
          '<leader>u',
          vim.cmd.UndotreeToggle,
          desc = 'Toggle Undotree',
        },
      },
    },
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      init = function()
        vim.cmd.colorscheme('tokyonight-moon')
      end
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { 'tokyonight-moon' } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
