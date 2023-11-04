return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",
    "l3mon4d3/luasnip",
    "onsails/lspkind.nvim",
  },
  event = "BufReadPost",
  config = function()
    vim.opt.completeopt = { "menu", "menuone", "noselect" }
    vim.o.shortmess = vim.o.shortmess .. "c"

    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Set up Luasnip.
    luasnip.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      delete_check_events = "TextChanged",
    })
    require("luasnip.loaders.from_lua").lazy_load({
      paths = vim.fn.stdpath("config") .. "/snippets",
    })

    -- Set keymaps for Luasnip.
    vim.keymap.set({ "i", "n", "s" }, "<C-k>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end)
    vim.keymap.set({ "i", "n", "s" }, "<C-j>", function()
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      end
    end)
    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if luasnip.choice_active() then
        return "<Plug>luasnip-next-choice"
      else
        return "<Tab>"
      end
    end, {
      expr = true,
    })

    -- Set up nvim-cmp.
    cmp.setup({
      mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = {
        -- TODO does this work with register_source_with_nvim_cmp
        -- { name = "nvim_ciderlsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer", max_item_count = 5 },
      },
      sorting = {
        comparators = {}, -- We stop all sorting to let the lsp do the sorting
      },
      -- Disable inside comments.
      enabled = function()
        if
          require("cmp.config.context").in_treesitter_capture("comment") == true
          or require("cmp.config.context").in_syntax_group("Comment")
        then
          return false
        else
          return true
        end
      end,
      formatting = {
        format = require("lspkind").cmp_format({
          with_text = true,
          maxwidth = 70, -- half max width
          menu = {
            buffer = "[buffer]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[API]",
            path = "[path]",
            luasnip = "[snip]",
            vim_vsnip = "[snip]",
            nvim_ciderlsp = "(🤖)",
          },
        }),
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "cmdline", max_item_count = 10 },
      },
    })

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer", max_item_count = 10 },
      },
    })
  end,
}
