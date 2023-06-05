return {
  url = "sso://user/vintharas/telescope-codesearch.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      "<Leader>cf",
      "<Cmd>Telescope codesearch find_files<CR>",
      desc = "Find file with Code Search",
    },
    {
      "<Leader>cq",
      "<Cmd>Telescope codesearch find_query<CR>",
      desc = "Query Code Search",
    },
    {
      "<Leader>ca",
      require("google.codesearch").query_android,
      desc = "Query Android",
    },
    {
      "<Leader>ct",
      require("google.codesearch").query_tuscany,
      desc = "Query Tuscany",
    },
  },
}
