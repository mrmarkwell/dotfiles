local builtin = require('telescope.builtin')
-- Find files from current dir (search local)
vim.keymap.set('n', '<leader>sl', builtin.find_files, {})

-- Find files from home dir (search home)
vim.keymap.set('n', '<leader>sh', function()
  builtin.find_files({cwd="~/"})
end)

-- Find files from top of git repo (search git)
vim.keymap.set('n', '<leader>sg', builtin.git_files, {})

-- Grep for tokens in local files (grep local)
vim.keymap.set('n', '<leader>gl', builtin.live_grep, {})

-- Grep for tokens from home (grep home)
vim.keymap.set('n', '<leader>gh', function()
  builtin.live_grep({cwd="~/"})
end)

-- Grep for tokens from top of git repo (grep git)
vim.keymap.set('n', '<leader>gg', function()
  builtin.live_grep({cwd=vim.fn.systemlist("git rev-parse --show-toplevel")[1]})
end)

-- Grep
vim.keymap.set('n', '<leader>gr', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- Close the search window on the first 'esc' keypress
local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
})
