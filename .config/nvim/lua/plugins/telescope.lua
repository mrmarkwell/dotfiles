-- Helper function for a scoped grep search with telescope.
_G.live_grep = function(search_dirs, prompt_title, follow, hidden)
  prompt_title = prompt_title or "Find Files"
  follow = follow or false
  hidden = hidden or false
  require("telescope.builtin").live_grep({
    prompt_title = prompt_title,
    search_dirs = search_dirs,
    follow = follow,
    hidden = hidden,
  })
end

-- Helper function for a scoped file search with telescope.
_G.find_files = function(search_dirs, prompt_title, follow, hidden)
  prompt_title = prompt_title or "Find Files"
  follow = follow or false
  hidden = hidden or false
  require("telescope.builtin").find_files({
    prompt_title = prompt_title,
    search_dirs = search_dirs,
    follow = follow,
    hidden = hidden,
  })
end

-- Shortcut for creating telescope keymaps.
-- Usage:
--    -- This would create two keymaps: <leader>fx and <leader>sx.
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
  local find_mapping = "<leader>f" .. map_letter
  local grep_mapping = "<leader>s" .. map_letter
  local find_prompt = "Find " .. prompt
  local grep_prompt = "Grep " .. prompt
  nmap(find_mapping, function()
    find_files(search_dirs, find_prompt, follow, hidden)
  end, find_prompt)
  nmap(grep_mapping, function()
    live_grep(search_dirs, grep_prompt, follow, hidden)
  end, grep_prompt)
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  keys = {
    {
      "<leader>dd",
      "<Cmd>Telescope diagnostics<CR>",
      desc = "Open buffer diagnostics",
    },

    { "<leader>sd", require("markwell.grep").grep_dotfiles, desc = "grep dotfiles" },
    { "<leader>sf", require("markwell.grep").grep_buffer, desc = "grep buffer" },
    { "<leader>sh", require("markwell.grep").grep_help, desc = "grep help tags" },
    { "<leader>sn", require("markwell.grep").grep_nvim_help, desc = "grep nvim help" },
    { "<leader>sp", require("markwell.grep").grep_dir, desc = "grep directory" },
    { "<leader>st", "<Cmd>Telescope treesitter<CR>", desc = "grep treesitter" },
    {
      "<leader>fd",
      require("markwell.find").find_dotfiles,
      desc = "Open from dotfiles",
    },
    {
      "<leader>fh",
      require("markwell.find").find_history,
      desc = "Open from history",
    },
    {
      "<leader>fp",
      require("markwell.find").find_files,
      desc = "Open from directory",
    },
    {
      "<leader>fr",
      require("markwell.find").find_related,
      desc = "Open from related files",
    },
    {
      "<leader>rr",
      "<Cmd>Telescope resume<CR>",
      desc = "Resume Telescope picker",
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          -- See: https://www.lua.org/manual/5.1/manual.html#5.4.1 for more
          -- information about lua regex.
          "%.git/",
          "%.orig",
        },
        layout_config = {
          prompt_position = "top",
          horizontal = { height = 0.95, width = 0.95 },
        },
        mappings = {
          n = {
            p = require("telescope.actions.layout").toggle_preview,
          },
        },
        sorting_strategy = "ascending",
      },
      pickers = {
        lsp_code_actions = { theme = "cursor" },
      },
    })
    telescope.load_extension("fzf")
  end,
}
