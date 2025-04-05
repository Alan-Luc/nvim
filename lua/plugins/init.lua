return {
	-- kanagawa.nvim
	{
		'rebelot/kanagawa.nvim',
		name = 'kanagawa',
		config = function()
			vim.cmd('colorscheme kanagawa-dragon')
		end
	},
	-- undotree
	{ 'mbbill/undotree' },
	-- t-pope
	'tpope/vim-surround',
	'tpope/vim-vinegar',
	'tpope/vim-eunuch',
	-- 'tpope/vim-rails',
	'tpope/vim-repeat',
	-- to comment in vue or jsx where commenting differs between sections of the page
	{ 'numToStr/Comment.nvim', opts = {} },
	-- gitsigns
	'lewis6991/gitsigns.nvim',
	-- QOL
	{ 'windwp/nvim-autopairs', opts = {} },
	-- autotags
	-- { 'windwp/nvim-ts-autotag', opts = {} },
	'haya14busa/is.vim',
	{
		'NvChad/nvim-colorizer.lua',
		opts = {
			user_default_options = {
				css = true,
				rgb_fn = true,
				hsl_fn = true,
				css_fn = true,
			},
		},
	},
	{
		'NeogitOrg/neogit',
		dependencies = {
			{ "nvim-lua/plenary.nvim" },      -- required
			{ "nvim-telescope/telescope.nvim" }, -- optional
			{ "sindrets/diffview.nvim" },     -- optional
		},
		opts = {},
	},
	-- vim visual multi
	'mg979/vim-visual-multi',
	-- conform.nvim - null-ls replacement
	{ 'stevearc/conform.nvim', opts = {} },
	-- kitty syntax highlighting
	'fladson/vim-kitty',
	{ 'nvim-treesitter/nvim-treesitter-context', opts = {}, },
	-- 'RRethy/nvim-treesitter-endwise',
	-- { 'kevinhwang91/nvim-bqf',                   ft = 'qf' }
}
