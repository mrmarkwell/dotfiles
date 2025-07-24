return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  settings = {
    Lua = {
      -- Formatting options
      format = {
        enable = true,
        indent_style = "space",
        indent_size = "2",
        quote_style = "single",
      },
      diagnostics = {
        -- Disable the "missing-fields" diagnostic
        disable = {
          "missing-fields",
        },
      },
    },
  },
}
