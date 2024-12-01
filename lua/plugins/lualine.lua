return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
	lazy = false,
	config = function()
		require('lualine').setup {
			options = {
				icons_enabled = false,
				theme = 'seoul256',
				section_separators = '',
				component_separators = '',
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 500,
					tabline = 500,
					winbar = 500,
				},
			},
			sections = {
				lualine_a = { 'mode', 'paste' },
				lualine_b = { 'filename' },
				lualine_c = { 'branch', 'readonly', 'modified' },
				lualine_x = { 'lineinfo', 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = { 'location' },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		}
	end,
}
