return {
  cmd = {
    'clangd',
    -- Do everything in-memory for performance.
    '--pch-storage=memory',
    -- Use 20 threads
    '-j=20',
    --'--header-insertion=iwyu',
    '--clang-tidy',
    '--fallback-style=Google',
    --'--log=verbose',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac', -- AutoTools
    '.git',
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { 'utf-8', 'utf-16' },
  },
  ---@param client vim.lsp.Client
  ---@param init_result ClangdInitializeResult
  on_init = function(client, init_result)
    if init_result.offsetEncoding then
      client.offset_encoding = init_result.offsetEncoding
    end
  end,
}
