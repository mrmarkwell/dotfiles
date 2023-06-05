vim.g.gitblame_enabled = 0
nmap("<leader>gb", "<cmd>GitBlameToggle<cr>", "Toggle Git Blame")
return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
}
