return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',                    -- Ensure parsers are updated automatically
	event = { 'BufReadPost', 'BufNewFile' }, -- Lazy-load on file read
	config = function()
		require('nvim-treesitter.configs').setup {
			-- Specify the parsers to ensure are installed
			ensure_installed = { "javascript", "typescript", "ruby", "rust", "go", "vim", "vimdoc", "bash", "yaml" },

			-- Synchronous installation
			sync_install = false,

			-- Automatically install missing parsers
			auto_install = true,

			highlight = {
				enable = true, -- Enable syntax highlighting with tree-sitter
				-- additional_vim_regex_highlighting = false, -- Disable regex-based highlighting
			},

			indent = {
				enable = true, -- Enable indentation based on tree-sitter
			},

			autopairs = {
				enable = true, -- Enable integration with nvim-autopairs
			},
		}
	end
}
