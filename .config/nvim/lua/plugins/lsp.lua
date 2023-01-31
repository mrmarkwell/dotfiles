-- This nifty command starts clangd for Android buffers only.
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = { "/usr/local/google/home/markwell/repos/master/*" },
  group = vim.api.nvim_create_augroup("cpp_lsp", {}),
  callback = function()
    -- TODO(markwell): Why doesn't this work?
    vim.cmd("LspStop ciderlsp")
    vim.cmd("LspStart clangd")
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    event = "BufReadPre",
    config = function()
      -- Autoinstall language servers.
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- 'awk_ls',
          "bashls",
          "cssls",
          -- 'dotls',
          "emmet_ls",
          "html",
          -- 'jsonls',
          "sumneko_lua",
          "clangd",
          -- 'yamlls',
        },
      })
      require("mason-lspconfig").setup_handlers({
        -- Default setup for servers installed with Mason.
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            on_attach = require("markwell.lsp-util").on_attach,
          })
        end,
        -- Custom setups for servers installed with Mason.
        clangd = function()
          require("lspconfig").clangd.setup({
            -- Don't start clangd automatically.
            autostart = false,
            cmd = {
              "clangd",
              "--pch-storage=memory",
              "-j=10",
              "--header-insertion=iwyu",
              "--clang-tidy",
              "--fallback-style=Google",
            },
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            on_attach = require("markwell.lsp-util").on_attach,
            -- Only use clangd on projects that proplerly setup compilation database.
            -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
            single_file_support = false,
          })
        end,
        sumneko_lua = function()
          require("lspconfig").sumneko_lua.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            on_attach = require("markwell.lsp-util").on_attach,
            settings = {
              Lua = {
                runtime = {
                  path = vim.split(package.path, ";"),
                  version = "LuaJIT",
                },
                diagnostics = {
                  disable = {
                    "different-requires",
                  },
                  globals = {
                    "vim", -- Neovim
                    "use", -- Packer
                  },
                },
                workspace = {
                  -- Make the server aware of Neovim runtime files.
                  library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                  },
                },
              },
            },
          })
        end,
      })

      -- Configure Google LSP, if available.
      pcall(require, "google.lsp")

      -- Don't show diagnostics as inline virtual text.
      --      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
      --        vim.lsp.diagnostic.on_publish_diagnostics,
      --        { virtual_text = false }
      --      )

      -- Configure LSP signs.
      local diagnostic_types = { "Error", "Warn", "Hint", "Info" }
      for _, type in pairs(diagnostic_types) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = "•", texthl = hl, numhl = "" })
      end

      -- Set keymaps.
      nmap("gK", vim.lsp.buf.hover, "Show documentation")
      nmap("gR", vim.lsp.buf.rename, "Rename")
      nmap("ga", vim.lsp.buf.code_action, "Code actions")
      nmap("gd", vim.lsp.buf.definition, "Go to definition")
      nmap("gD", vim.lsp.buf.declaration, "Go to declaration")
      nmap("gh", vim.diagnostic.open_float, "Show line diagnostics")
      nmap("gr", vim.lsp.buf.references, "Open references")
      nmap("g0", vim.lsp.buf.document_symbol, "Show document symbol")
      nmap("gW", vim.lsp.buf.workspace_symbol, "Show workplace symbol")
      nmap("gi", vim.lsp.buf.implementation, "Go to implementation")
      nmap("gS", vim.lsp.buf.signature_help, "Get Signature help")
      nmap("gt", vim.lsp.buf.type_definition, "Get type definition")
      nmap("gb", "<C-o>", "Go back")
      nmap("<leader>n", vim.diagnostic.goto_next, "Go to next diagnostic")
      nmap("<leader>N", vim.diagnostic.goto_prev, "Go to prev diagnostic")
      nmap("<leader>F", vim.lsp.buf.format, "Format file")
      nmap("<leader>M", "<cmd>Mason<CR>", "Open Mason UI")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "lua" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = require("markwell.lsp-util").on_attach,
        sources = {
          -- Lua formatter.
          null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces", "--indent-width", 2 },
          }),
        },
      })
    end,
  },
}
