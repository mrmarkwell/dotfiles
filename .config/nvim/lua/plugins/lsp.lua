-- Helper function for formatting the entire file.
--vim.cmd([[
--function MyFormatFile()
--  let l:lines="all"
--  py3f /usr/lib/clang-format/clang-format.py
--endfunction
--]])
--
--_G.format_cpp_file = function()
--  vim.cmd([[call MyFormatFile()]])
--end

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
          "lua_ls",
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
              "-j=20",
              "--header-insertion=iwyu",
              "--clang-tidy",
              "--fallback-style=Google",
            },
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            on_attach = require("markwell.lsp-util").on_attach,
            -- Only use clangd on projects that proplerly setup compilation database.
            -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
            --    TODO: should I set this?
            --    single_file_support = false,
          })
        end,
        lua_ls = function()
          require("lspconfig").lua_ls.setup({
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
      -- Glug codefmt handles this formatting stuff now.
      --      nmap("<leader>F", function()
      --        if vim.bo.filetype == "cpp" then
      --          format_cpp_file()
      --        else
      --          vim.lsp.buf.format()
      --        end
      --      end, "Format file")
      --      vmap("<leader>F", ":py3f /usr/lib/clang-format/clang-format.py<CR>gv=gv", "Format Lines CPP")
      --      vmap("<leader>ff", function()
      --        vim.lsp.buf.format({
      --          async = true,
      --          range = {
      --            ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
      --            ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
      --          },
      --        })
      --      end, "Format Lines")
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
