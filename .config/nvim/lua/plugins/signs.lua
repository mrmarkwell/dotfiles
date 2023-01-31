return {
  "mhinz/vim-signify",
  init = function()
    vim.g.signify_priority = 5
    vim.g.signify_sign_show_count = 0
  end,
  hello,
  config = function()
    --
    -- Set keymaps.
    vim.keymap.set("n", "L", "<Plug>(signify-next-hunk)zz", { desc = "Next diff" })
    vim.keymap.set("n", "H", "<Plug>(signify-prev-hunk)zz", { desc = "Previous diff" })
    vim.keymap.set("n", "<Leader>md", "<Cmd>SignifyHunkDiff<CR>", { desc = "Hunk diff" })
    vim.keymap.set("n", "<Leader>mu", "<Cmd>SignifyHunkUndo<CR>", { desc = "Hunk undo" })
  end,
}
