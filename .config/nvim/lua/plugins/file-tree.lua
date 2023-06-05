-- close nvim-tree if it is the last buffer open.
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
--   pattern = "NvimTree_*",
--   callback = function()
--     local layout = vim.api.nvim_call_function("winlayout", {})
--     if
--       layout[1] == "leaf"
--       and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
--       and layout[3] == nil
--     then
--       vim.cmd("confirm quit")
--     end
--   end,
-- })

local function open_nvim_tree(data)
  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1
  if no_name then
    -- open the tree, find the file but don't focus it
    -- require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })

    return
  end

  if directory then
    -- change to the directory
    vim.cmd.cd(data.file)

    -- open the tree
    require("nvim-tree.api").tree.open()
  end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
return {
  "kyazdani42/nvim-tree.lua",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  keys = {
    { "<Leader>te", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    {
      "<Leader>tf",
      "<Cmd>NvimTreeFindFile<CR>",
      desc = "Find file in file explorer",
    },
  },
  opts = {
    git = {
      enable = false,
    },
    hijack_cursor = true,
    renderer = {
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = false,
          git = false,
        },
      },
    },
    view = {
      mappings = {
        list = {
          {
            key = "<Esc>",
            cb = "<Cmd>NvimTreeToggle<CR>",
          },
          {
            -- up
            key = "u",
            action = "dir_up",
          },
          {
            -- down
            key = "d",
            action = "<CR>",
          },
          {
            key = "O",
            action = "expand_all",
          },
        },
      },
      number = true,
      relativenumber = true,
      signcolumn = "no",
      width = 50,
    },
  },
}
