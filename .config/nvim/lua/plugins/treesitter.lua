return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "dart",
        "diff",
        "dot",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "go",
        "help",
        "html",
        "java",
        "javascript",
        "json",
        "jsonc",
        "kotlin",
        "lua",
        "proto",
        "python",
        "query",
        "scss",
        "typescript",
        "vim",
        "yaml",
      },
      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      auto_install = true,
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    keys = { { "<leader>ts", vim.cmd.TSPlaygroundToggle, desc = "Toggle Treesitter Playground" } },
  },
}
