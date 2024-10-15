local builtin = require('telescope.builtin')
local telescope = require('telescope')
-- text and file search hidden files and folders
telescope.setup({
	defaults = {
		theme = "ivy",
		layout_strategy = "horizontal",
		prompt_position = 'top',
		sorting_strategy = "ascending",
		layout_config = {
			height = 0.8, -- Adjust height to make results more visible
			width = 0.8,
			preview_width = 0.5,
		},
	},
	dynamic_preview_title = true,
	pickers = {
		find_files = {
			find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
		},
	},
})

vim.keymap.set('n', '<C-f>', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.live_grep, {})
vim.keymap.set('n', '<leader>g', builtin.git_files, {})
vim.keymap.set('n', '<leader>ll', function()
	builtin.grep_string({ search = vim.fn.input("grep > ") })
end)
