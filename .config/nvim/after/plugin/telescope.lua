require('telescope').setup {
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				-- ["<C-h>"] = "which_key"
			}
		}
	},
	pickers = {
-- 		find_command = {
-- 			'fd',
-- 			'--type',
-- 			'f',
--       -- I don't love respecting gitignore in find_files.
--       -- Use git_files if you want that.
-- 			'--no-ignore-vcs',
-- 			'--color=never',
-- 			'--hidden',
-- 			'--follow',
--		}
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	}
}


local builtin = require('telescope.builtin')


-- Find files from current dir (search local)
vim.keymap.set('n', '<leader>sl', builtin.find_files, {})

-- Find files from home dir (search home)
-- vim.keymap.set('n', '<leader>sh', function()
-- 	builtin.find_files({ cwd = "~/" })
-- -- , find_command={"fd","--type","f","--no-ignore-vcs","--hidden"}})
-- end)

-- Find files from top of git repo (search git)
vim.keymap.set('n', '<leader>sg', builtin.git_files, {})

-- Grep for tokens in local files (grep local)
vim.keymap.set('n', '<leader>gl', builtin.live_grep, {})

-- Grep for tokens from home (grep home)
-- vim.keymap.set('n', '<leader>gh', function()
-- 	builtin.live_grep({ cwd = "~/" })
-- end)

-- Grep for tokens from top of git repo (grep git)
vim.keymap.set('n', '<leader>gg', function()
	builtin.live_grep({ cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] })
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
