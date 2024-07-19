--[[ markwell note:

I recreated my config from scratch (for the third time) recently. This is the result.
This takes kickstart.nvim as the starting point, and just merges in all the goodness from my other config.

In particular, I like the single file approach since it simplifies where my config is located. Modular config is overrated.

This file is both the kickstart init file (modified with my own config), as well  as all the plugins that are not work-specific.

SETUP:
1. A symlink needs to be added to this folder in .config/ called `nvim`:

```
ln -s ~/path/to/this/folder/nvim-kickstart ~/.config/nvim
```

2. A symlink needs to be added to any google config in the google folder.

```
ln -s ~/path/to/some/google-specific/repo/google.lua ./lua/google.lua
```

Note: I'm on Neovim v0.10.0 currently.

My own todo list for this config.
TODO:
- Investigate snippets.
- Get multiline ML completions working.

NOTE: Reminders of cool functionality.
- Highlight a region and type 'gc' to toggle converting it into a comment.
- :terminal opens a terminal in a buffer. 'i' to use it (terminal mode) and '<esc><esc>' to exit.
- Telescope
  - <leader>help to search [help]
  - leader>sr to reopen telescope [S]earch [R]esume.
  - <leader>sk to [S]earch [K]eymaps (useful if you forget a mapping!).
  - <leader>/ to fuzzy search in current buffer.
  - <leader>s/ to fuzzy search in all open buffers
  - <leader>fh to [F]ind in [H]istory
  - <leader><leader>s{prefix} to [S]earch for the mapped prefix.
  - <leader><leader>f{prefix} to [F]ind in the mapped prefix.
- Diagnostics
  - <leader>n and <leader>N to navigate diagnostic messages.
  - <leader>e to show the full error/diagnosic message on the current line.
  - <leader>l to open the quickfix list.
- Use <ctrl>h, j, k, or l to switch between windows.
- <leader>config to open nvim config in a new buffer.
- <leader>gc to open nvim google config in a new buffer.

The original kickstart comment header starts here.

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========

========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>help" to search the [help] documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]
-- NOTE: markwell's settings:
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.textwidth = 80
vim.opt.expandtab = true
vim.opt.smarttab = true

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

vim.opt.updatetime = 50
vim.opt.colorcolumn = '81' -- Putting this at 81 since the 80 is the limit.

-- set the current working directory every time moving to a buffer.
vim.opt.autochdir = true

-- Don't load built-in plugins.
vim.g.loaded_gzip = true
vim.g.loaded_matchit = true
--vim.g.loaded_matchparen = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_tohtml = true
vim.g.loaded_tutor = true
vim.g.loaded_zipPlugin = true

-- Don't autoinsert comments when adding new lines.
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

-- NOTE: markwell: Ok, back to kickstart boilerplate...

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- NOTE: markwell's keymaps start

vim.keymap.set('n', '<leader>gb', '<cmd>GitBlameToggle<cr>', { desc = 'Toggle [G]it [B]lame' })

-- make it possible to move highighted lines with capital J and K
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')

-- Make joining lines not move the cursor.
vim.keymap.set('n', 'J', 'mzJ`z')

-- Paging down or going to the next search match centers cursor on the screen.
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Close buffer without closing window.
vim.keymap.set('n', '<leader>q', '<cmd>bp|bd #<CR>', { desc = 'Close current buffer' })

-- Aliases for fat-fingering
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Q', 'q', {})

-- Quickfix list navigation
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

-- "replace word"
vim.keymap.set('n', '<leader>rw', 'ciw<C-R>0<ESC>', { desc = '[R]eplace the [w]ord under cursor with previous yank' })

-- Set highlight on search, but clear on pressing <Esc> in normal mode. Also dismiss notify messages with esc.
vim.opt.hlsearch = true
vim.keymap.set(
  'n',
  '<esc>',
  '<esc>:noh<CR>:lua require("notify").dismiss()<CR>',
  { desc = 'Dismiss highlights and notify messages silently when hitting <esc> in normal mode.', silent = true }
)

vim.keymap.set('n', '<leader>config', '<cmd>e ~/.config/nvim/init.lua<CR>', { desc = 'Open Nvim [Config]' })
vim.keymap.set('n', '<leader>gc', '<cmd>e ~/.config/nvim/lua/google.lua<CR>', { desc = 'Open Nvim [G]oogle [C]onfig' })

-- NOTE: markwell's keymaps end (kickstart keymaps below).

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>n', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>N', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix [L]ist' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- NOTE: markwell functions start

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

local find_files_current_directory = function()
  require('telescope.builtin').find_files({
    prompt_title = 'Find in Directory',
    hidden = true,
  })
end

local find_history = function()
  require('telescope.builtin').oldfiles({
    prompt_title = 'Find in History',
  })
end

-- Searches for the name of the current file in the file |filename|.
local find_current_filename_in_file = function(filename)
  local lines = vim.fn.readfile(filename)
  local current_filename = vim.fn.expand('%:t')
  for linenum, line in ipairs(lines) do
    if string.match(line, current_filename) then
      return linenum
    end
  end
  return 0
end

local grep_dir = function()
  require('telescope.builtin').live_grep({
    prompt_title = 'grep Directory',
  })
end

-- Returns a table of files related to the current file (e.g. BUILD, tests,
-- etc.). Each entry in the table is a table containing the name of the related
-- file and the relevant line number.
local get_related_files = function()
  local related_files = {}
  local current_dir = vim.fn.expand('%:h')
  local current_filename = vim.fn.expand('%')
  local files_to_find = {
    -- BUILD file.
    current_dir .. '/BUILD',
    -- Source files.
    string.gsub(current_filename, '_test%.(%w+)', '.%1'),
    string.gsub(current_filename, '_tests%.(%w+)', '.%1'),
    -- Test files.
    string.gsub(current_filename, '%.(%w+)', '_test.%1'),
    string.gsub(current_filename, '%.(%w+)', '_tests.%1'),
  }
  for _, filename in ipairs(files_to_find) do
    if filename ~= current_filename and vim.fn.filereadable(filename) == 1 then
      local cwd = vim.fn.getcwd() .. '/'
      local relative_filename = string.gsub(filename, cwd, '')
      -- In BUILD files, search for current file's BUILD rule to jump to that
      -- line directly.
      local lnum = 0
      if string.find(filename, 'BUILD') ~= nil then
        lnum = find_current_filename_in_file(filename)
      end
      table.insert(related_files, {
        filename = relative_filename,
        lnum = lnum,
      })
    end
  end
  return related_files
end

local find_related = function()
  local action_state = require('telescope.actions.state')
  local action_set = require('telescope.actions.set')
  local config = require('telescope.config').values
  local finders = require('telescope.finders')
  local pickers = require('telescope.pickers')
  local opts = {}
  pickers
    .new(opts, {
      prompt_title = 'Find in Related Files',
      previewer = config.grep_previewer(opts),
      sorter = config.generic_sorter(opts),
      finder = finders.new_table({
        results = get_related_files(),
        entry_maker = function(entry)
          return {
            value = entry.filename,
            ordinal = entry.filename,
            display = entry.filename,
            lnum = entry.lnum,
          }
        end,
      }),
      attach_mappings = function()
        action_set.select:enhance({
          post = function()
            local selection = action_state.get_selected_entry()
            if selection.lnum ~= 0 then
              vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
            end
          end,
        })
        return true
      end,
    })
    :find()
end

-- Helper function for a scoped grep search with telescope.
_G.live_grep = function(search_dirs, prompt_title, follow, hidden)
  prompt_title = prompt_title or 'Find Files'
  -- repeat an existing flag if false.
  local follow_flag = (follow and '--follow' or '--column')
  local hidden_flag = (hidden and '--hidden' or '--column')
  require('telescope.builtin').live_grep({
    prompt_title = prompt_title,
    search_dirs = search_dirs,
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      follow_flag,
      hidden_flag,
    },
  })
end

-- Helper function for a scoped file search with telescope.
_G.find_files = function(search_dirs, prompt_title, follow, hidden)
  prompt_title = prompt_title or 'Find Files'
  -- repeat an existing flag if false.
  local follow_flag = (follow and '--follow' or '--files')
  local hidden_flag = (hidden and '--hidden' or '--files')
  require('telescope.builtin').find_files({
    prompt_title = prompt_title,
    search_dirs = search_dirs,
    find_command = {
      'rg',
      '--files',
      '-g',
      '!.git',
      follow_flag,
      hidden_flag,
    },
  })
end

-- Shortcut for creating telescope keymaps.
-- Usage:
--    -- This would create two keymaps: <leader><leader>fx and <leader><leader>sx.
--    -- 'f' mappings call find_files on the provided paths, with the provided titles.
--    -- 's' mappings do the same but with live_grep.
--    map_search_shortcuts(
--       "x",
--       { "~/.config/nvim/", "~/.config/fish/" },
--       "Configs",
--       true, -- optional 'follow'
--       true,  -- optional 'hidden'
--       )
_G.map_search_shortcuts = function(map_letter, search_dirs, prompt, follow, hidden)
  local find_mapping = '<leader><leader>f' .. map_letter
  local grep_mapping = '<leader><leader>s' .. map_letter
  local find_prompt = 'Find ' .. prompt
  local grep_prompt = 'Grep ' .. prompt
  vim.keymap.set('n', find_mapping, function()
    find_files(search_dirs, find_prompt, follow, hidden)
  end, { desc = find_prompt })
  vim.keymap.set('n', grep_mapping, function()
    live_grep(search_dirs, grep_prompt, follow, hidden)
  end, { desc = grep_prompt })
end

local dotfile_paths = {
  vim.fn.expand('~/.config/'),
}

local nvim_config_paths = {
  vim.fn.expand('~/.config/nvim/'),
  vim.fn.expand('~/.config/nvim/lua/google.lua'),
}

-- <leader><leader>d to grep all dotfiles.
map_search_shortcuts('d', dotfile_paths, 'Dotfiles', true, true)
map_search_shortcuts('n', nvim_config_paths, 'Nvim Config', true, true)

vim.g.themeindex = 0
function RotateColorscheme()
  local colorstring = { 'tokyonight-moon', 'tokyonight-night', 'tokyonight-storm', 'zenburn', 'vscode', 'gruvbox' }
  vim.g.themeindex = ((vim.g.themeindex + 1) % #colorstring)
  local theme = colorstring[vim.g.themeindex + 1]
  vim.cmd.colorscheme(theme)
  --vim.api.nvim_echo({{':colorscheme ' .. theme}}, false, {})
end

vim.keymap.set('n', '<F8>', RotateColorscheme)

-- NOTE: end my functions.

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  change_detection = { enabled = false },

  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

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
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>f', group = '[F]ind' },
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

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  {
    -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope-live-grep-args.nvim',
      {
        -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',
        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable('make') == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    cmd = 'Telescope',
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      -- TODO: Telescope is not looking good. I preferred the way it worked before.
      -- Also, my custom telescope search paths aren't working either.
      -- Investigate...
      require('telescope').setup({
        defaults = {
          file_ignore_patterns = {
            -- See: https://www.lua.org/manual/5.1/manual.html#5.4.1 for more
            -- information about lua regex.
            '%.git/',
            '%.orig',
          },
          -- The vertical layout strategy is good to handle long paths like those in
          -- google3 repos because you have nearly the full screen to display a file path.
          -- The caveat is that the preview area is smaller.
          layout_strategy = 'vertical',
          layout_config = {
            prompt_position = 'bottom',
            vertical = { height = 0.95, width = 0.95 },
            horizontal = { height = 0.95, width = 0.95 },
          },
          -- Common paths in google3 repos are collapsed following the example of Cider
          -- It is nice to keep this as a user config rather than part of
          -- telescope-codesearch because it can be reused by other telescope pickers.
          path_display = function(opts, path)
            -- Do common substitutions
            path = path:gsub('^/google/src/cloud/[^/]+/[^/]+/google3/', '~/google3/', 1)
            path = path:gsub('^/google/src/cloud/[^/]+/[^/]+/google3/', '~/google3/', 1)
            path = path:gsub('^/usr/local/google/home/markwell/android/', '~/android/', 1)
            path = path:gsub('^/usr/local/google/home/markwell/aoc/', '~/aoc/', 1)
            path = path:gsub('^/usr/local/google/home/markwell/', '~/', 1)
            path = path:gsub('^~/repos/aoc/', '~/aoc/', 1)
            path = path:gsub('^~/repos/master/', '~/android/', 1)

            -- Do truncation. This allows us to combine our custom display formatter
            -- with the built-in truncation.
            -- `truncate` handler in transform_path memoizes computed truncation length in opts.__length.
            -- Here we are manually propagating this value between new_opts and opts.
            -- We can make this cleaner and more complicated using metatables :)
            local new_opts = {
              path_display = {
                truncate = 3,
              },
              __length = opts.__length,
            }
            path = require('telescope.utils').transform_path(new_opts, path)
            opts.__length = new_opts.__length
            return path
          end,
          mappings = {
            n = {
              p = require('telescope.actions.layout').toggle_preview,
            },
          },
          sorting_strategy = 'ascending',
        },
        pickers = {
          lsp_code_actions = { theme = 'cursor' },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })

      -- Enable Telescope extensions if they are installed
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('ui-select')
      require('telescope').load_extension('live_grep_args')

      -- See `:help telescope.builtin`
      local builtin = require('telescope.builtin')

      -- TODO: These are not how I want them! take some time to fix them.
      vim.keymap.set('n', '<leader>help', builtin.help_tags, { desc = 'search [help]' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sdir', builtin.find_files, { desc = '[F]ind in open [Files]' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>dd', builtin.diagnostics, { desc = 'Search [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch open [B]uffers' })

      vim.keymap.set('n', '<leader>sp', grep_dir, { desc = '[S]earch in [P]roject (current directory)' })
      vim.keymap.set('n', '<leader>st', '<Cmd>Telescope treesitter<CR>', { desc = '[S]earch [T]reesitter symbols' })
      vim.keymap.set('n', '<leader>fh', find_history, { desc = '[F]ind in [H]istory' })
      vim.keymap.set('n', '<leader>fp', find_files_current_directory, { desc = '[F]ind in [P]roject (current directory)' })
      vim.keymap.set('n', '<leader>fr', find_related, { desc = 'Open from related files' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        })
      end, { desc = '[S]earch [/] in Open Files' })
    end,
  },
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = function()
                -- Add filetypes here if they don't support documentHighlight
                local unsupported_filetypes = { 'pbtxt', 'bzl' }
                local current_filetype = vim.bo[event.buf].filetype
                if not contains(unsupported_filetypes, current_filetype) then
                  vim.lsp.buf.document_highlight()
                end
              end,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        clangd = {
          -- We need this to start only when certain conditions are met.
          autostart = false,
          cmd = {
            'clangd',
            -- Do everything in-memory for performance.
            '--pch-storage=memory',
            -- Use 20 threads
            '-j=20',
            '--header-insertion=iwyu',
            '--clang-tidy',
            '--fallback-style=Google',
          },
        },
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --
        -- For Nix.
        nil_ls = {
          --   autostart = true,
          --   capabilities = caps,
          --   cmd = { lsp_path },
          settings = {
            ['nil'] = {
              testSetting = 42,
              formatting = {
                command = { 'nixpkgs-fmt' },
              },
              -- This is noisy - disable it.
              diagnostics = { ignored = { 'unused_binding' } },
            },
          },
        },
        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          root_dir = function()
            return false
          end,
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },

              format = {
                enable = true,
                -- Put format options here
                -- NOTE: the value should be STRING!!
                defaultConfig = {
                  indent_style = 'space',
                  indent_size = '2',
                  quote_style = 'single',
                  call_arg_parentheses = 'keep',
                },
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = {
                disable = {
                  'different-requires',
                  'missing-fields',
                },
                globals = {
                  'vim', -- Neovim
                  'require',
                  'use', -- Packer
                },
              },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'nixpkgs-fmt', -- Used to format nix code.
        'buildifier', -- Used to format bazel files.
        'clang-format',
        'rust-analyzer',
        'lua-language-server',
        'bash-language-server',
        'vim-language-server',
      })
      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
    end,
  },
  {
    -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      -- Turning this to true is very useful when debugging style issues.
      -- See :ConformInfo also to see any logs from conform if things aren't working.
      notify_on_error = false,

      format_on_save = {
        -- I recommend these options. See :help conform.format for details.
        lsp_format = 'fallback',
        --lsp_format = 'prefer',
        timeout_ms = 500,
      },
      -- format_on_save = function(bufnr)
      --   -- Disable "format_on_save lsp_fallback" for languages that don't
      --   -- have a well standardized coding style. You can add additional
      --   -- languages here or re-enable it for the disabled ones.
      --   --local disable_filetypes = { c = false, cpp = false }
      --   return {
      --     timeout_ms = 500,
      --     -- Do formatting with the attached LSP if it is available.
      --     lsp_fallback = "prefer",
      --     -- not disable_filetypes[vim.bo[bufnr].filetype],
      --   }
      -- end,
      formatters_by_ft = {
        lua = { 'stylua' },
        cpp = { 'clang-format' },
        bzl = { 'buildifier' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
      formatters = {
        ['clang-format'] = {
          -- Always use google style.
          prepend_args = { '--style', 'Google' },
        },
        stylua = {
          -- This can be a string or a function that returns a string.
          -- When defining a new formatter, this is the only field that is required
          --command = 'stylua',
          -- A list of strings, or a function that returns a list of strings
          -- Return a single string instead of a list to run the command in a shell
          prepend_args = { '--call-parentheses', 'Always', '--quote-style', 'ForceSingle', '--indent-type=Spaces', '--indent-width=2' },
        },
      },
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    -- We need CmdlineEnter as well since we want completions when we start typing a command (e.g. ':') even if we haven't entered insert mode yet.
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = 'lazydev',
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      luasnip.config.setup({})

      luasnip.config.set_config({
        history = true,
        updateevents = 'TextChanged,TextChangedI',
        delete_check_events = 'TextChanged',
      })
      require('luasnip.loaders.from_lua').lazy_load({
        paths = vim.fn.stdpath('config') .. '/snippets',
      })

      -- Set keymaps for Luasnip.
      vim.keymap.set({ 'i', 'n', 's' }, '<C-k>', function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end)
      vim.keymap.set({ 'i', 'n', 's' }, '<C-j>', function()
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        end
      end)
      vim.keymap.set({ 'i', 's' }, '<Tab>', function()
        if luasnip.choice_active() then
          return '<Plug>luasnip-next-choice'
        else
          return '<Tab>'
        end
      end, {
        expr = true,
      })

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noselect' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert({
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [u]p / [d]own
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          -- Also allow C-f to match the behavior of Fish.
          ['<C-f>'] = cmp.mapping.confirm({ select = true }),

          -- TJ doesn't like this, but I enjoy using tab to scroll through completion options.
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete({}),

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        }),
        sources = {
          -- Order matters here. Prioritize the useful stuff!
          { name = 'nvim_ciderlsp', priority = 30 }, -- TODO: Not working.
          { name = 'nvim_lsp', priority = 20 },
          { name = 'luasnip', priority = 10 },
          { name = 'nvim_lua', priority = 1 },
          { name = 'path', priority = 1 },
          -- We don't want a lot of suggestions from the current buffer.
          { name = 'buffer', max_item_count = 3, priority = 1 },
          { name = 'nvim_lsp_signature_help', priority = 1 },
        },
        sorting = {
          comparators = {
            -- Default comparators for nvim-cmp
            -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua#L67-L78
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            -- cmp.config.compare.scopes,
            cmp.config.compare.score,
            -- Rank items that start with "_", lower. i.e. private fields and methods.
            function(entry1, entry2)
              local _, entry1_under = entry1.completion_item.label:find('^_+')
              local _, entry2_under = entry2.completion_item.label:find('^_+')
              entry1_under = entry1_under or 0
              entry2_under = entry2_under or 0
              if entry1_under > entry2_under then
                return false
              elseif entry1_under < entry2_under then
                return true
              end
            end,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            -- cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        experimental = {
          -- TODO: I think this might be necessary for ML completions.
          --ghost_text = true,
        },
        -- Disable inside comments. Autocomplete in comments is super annoying!
        enabled = function()
          if require('cmp.config.context').in_treesitter_capture('comment') == true or require('cmp.config.context').in_syntax_group('Comment') then
            return false
          else
            return true
          end
        end,
        -- TODO: I'm not sure this is necessary.
        formatting = {
          expandable_indicator = true,
          fields = { 'kind', 'abbr', 'menu' },
          format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            before = function(entry, vim_item)
              --pcall(function()
              local item = entry:get_completion_item()
              -- Label where the info came from.
              local menu = {
                buffer = '[buffer]',
                nvim_lsp = '[LSP]',
                nvim_lua = '[API]',
                path = '[path]',
                luasnip = '[snip]',
                vim_vsnip = '[snip]',
                nvim_ciderlsp = '(🤖)',
              }
              vim_item.menu = menu[entry.source.name]

              -- If there is a small-ish amount of detail, just add it to the end
              -- of the table. This is usually the return type or the field type.
              if item.detail and #item.detail < 30 then
                vim_item.menu = vim_item.menu .. ' (' .. item.detail .. ')'
              end
              --end)
              return vim_item
            end,
          }),
        },
      })

      -- Completion suggestions for execution commands.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'cmdline', max_item_count = 10 },
        },
      })

      -- Completion suggestions for searches.
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer', max_item_count = 10 },
        },
      })
    end,
  },

  {
    -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme('tokyonight-moon')

      -- You can configure highlights by doing something like:
      vim.cmd.hi('Comment gui=none')
    end,
  },
  -- Other colorschemes.
  {
    'phha/zenburn.nvim',
    lazy = true,
  },
  {
    'mofiqul/vscode.nvim',
    lazy = true,
  },
  {
    'morhetz/gruvbox',
    lazy = true,
    config = function()
      vim.g.gruvbox_contrast_dark = 'hard'
      vim.g.gruvbox_invert_selection = false
      vim.g.gruvbox_sign_column = 'bg0'
    end,
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      -- Use notify as the default 'notify' function.
      vim.notify = require('notify')
      vim.notify.setup({ timeout = 5000 })
    end,
  },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- require('mini.surround').setup() -- I don't like surround.

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require('mini.statusline')
      -- set use_icons to true if you have a Nerd Font
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'cpp' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      -- TODO: I'm not convinced treesitter is better than the default nvim indent capability.
      -- I do know that it sucks for Java, so disable that here. But I might want to just disable this alltogether.
      -- Look here first if there is any funky indentation issue.
      indent = { enable = true, disable = { 'ruby', 'java' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    event = 'VeryLazy',
    config = function()
      require('trouble').setup({
        position = 'bottom', -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = 'workspace_diagnostics', -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = '', -- icon used for open folds
        fold_closed = '', -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        action_keys = {
          -- key mappings for actions in the trouble list
          -- map to {} to remove a mapping, for example:
          -- close = {},
          close = 'q', -- close the list
          cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
          refresh = 'r', -- manually refresh
          jump = { '<cr>', '<tab>' }, -- jump to the diagnostic or open / close folds
          open_split = { '<c-x>' }, -- open buffer in new split
          open_vsplit = { '<c-v>' }, -- open buffer in new vsplit
          open_tab = { '<c-t>' }, -- open buffer in new tab
          jump_close = { 'o' }, -- jump to the diagnostic and close the list
          toggle_mode = 'm', -- toggle between "workspace" and "document" diagnostics mode
          toggle_preview = 'P', -- toggle auto_preview
          hover = 'K', -- opens a small popup with the full multiline message
          preview = 'p', -- preview the diagnostic location
          close_folds = { 'zM', 'zm' }, -- close all folds
          open_folds = { 'zR', 'zr' }, -- open all folds
          toggle_fold = { 'zA', 'za' }, -- toggle fold of current file
          previous = 'k', -- preview item
          next = 'j', -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = { 'lsp_definitions' }, -- for the given modes, automatically jump if there is only a single result
        signs = {
          -- icons / text used for a diagnostic
          error = '',
          warning = '',
          hint = '',
          information = '',
          other = '',
        },
        use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
      })
    end,
    keys = {
      { '<leader>d', desc = 'Diagnostics (Trouble)' },
      { '<leader>dt', '<cmd>TroubleToggle<CR>', desc = 'Trouble Toggle' },
      { '<leader>dw', '<cmd>Trouble workspace_diagnostics<CR>', desc = 'Trouble Workspace Diagnostics' },
      { '<leader>dd', '<cmd>Trouble document_diagnostics<CR>', desc = 'Trouble Doc Diagnostics' },
      { '<leader>dl', '<cmd>Trouble loclist<CR>', desc = 'Trouble Loclist' },
      { '<leader>dq', '<cmd>Trouble quickfix<CR>', desc = 'Trouble Quickfix' },
      { '<leader>dk', vim.diagnostic.open_float, desc = 'Open Diagnostic Float' },
    },
  },
  {
    -- debug.lua
    --
    -- Shows how to use the DAP plugin to debug your code.
    --
    -- Primarily focused on configuring the debugger for Go, but can
    -- be extended to other languages as well. That's why it's called
    -- kickstart.nvim and not kitchen-sink.nvim ;)

    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      require('mason-nvim-dap').setup({
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'delve',
        },
      })

      -- Basic debugging keymaps, feel free to change to your liking!
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, { desc = 'Debug: Set Breakpoint' })

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup({
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      })

      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Install golang specific config
      require('dap-go').setup()
    end,
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
  {
    -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- local lint = require 'lint'
      -- lint.linters_by_ft = {
      --   markdown = { 'markdownlint' },
      -- }
      --
      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
  -- NOTE: markwell's plugins start here (stuff not included in kickstart)
  {
    -- Toggle formatted markdown view with :RenderMarkdownToggle
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('render-markdown').setup({})
      vim.keymap.set('n', '<leader>md', '<Cmd>RenderMarkdownToggle<CR>', { desc = 'Toggle [M]ark[d]own' })
    end,
  },
  {
    'tpope/vim-abolish',
    cmd = { 'S', 'Subvert' },
    keys = 'cr',
    config = function()
      -- Register mappings with WhichKey.
      local loaded, wk = pcall(require, 'which-key')
      if loaded then
        wk.register({
          ['cr'] = {
            name = 'coerce',
            ['<Space>'] = 'to space case',
            ['.'] = 'to.dot.case',
            ['-'] = 'to-dash-case',
            c = 'toCamelCase',
            m = 'ToMixedCase',
            s = 'to_snake_case',
            u = 'TO_UPPER_SNAKE_CASE',
          },
        })
      end
    end,
  },
  {
    -- Netrw replacement.
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup()
    end,
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        custom_filter = function(buf_number)
          return vim.api.nvim_buf_get_option(buf_number, 'buftype') ~= 'quickfix'
        end,
        diagnostics = 'nvim_lsp',
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            highlight = 'Directory',
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
    'folke/paint.nvim',
    event = 'BufReadPre',
    opts = {
      highlights = {
        {
          filter = {},
          pattern = 'DO_NOT_SUBMIT',
          hl = 'ErrorMsg',
        },
        {
          filter = {},
          pattern = 'MARKWELL',
          hl = 'Constant',
        },
        {
          filter = { filetype = 'lua' },
          -- TODO: Make sure this works
          -- The goal is to highlight the word 'section' in lua comments.
          pattern = '%-%-SECTION:',
          hl = 'Constant',
        },
      },
    },
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
  -- Import all the google plugins. Symlink a 'google.lua' into the lua folder.
  -- It can be empty for non-google configs.
  { import = 'google' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
