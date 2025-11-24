return {
	-- kanagawa-paper
	{
		"thesimonho/kanagawa-paper.nvim",
		-- "rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd.colorscheme("kanagawa-paper-ink")
			-- vim.cmd.colorscheme('kanagawa-dragon')
			vim.cmd("highlight Normal guibg=#0a0c0d")
		end,
	},
	-- undotree
	{ "mbbill/undotree" },
	-- t-pope
	"tpope/vim-surround",
	"tpope/vim-fugitive",
	"tpope/vim-eunuch",
	"tpope/vim-repeat",
	{ "numToStr/Comment.nvim", opts = {} },
	{ "windwp/nvim-ts-autotag", opts = {} },
	"haya14busa/is.vim",
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				css = true,
				rgb_fn = true,
				hsl_fn = true,
				css_fn = true,
			},
		},
	},
	"mg979/vim-visual-multi",
	"fladson/vim-kitty",
	{ "nvim-treesitter/nvim-treesitter-context", opts = {} },
	"RRethy/nvim-treesitter-endwise",
	{ "nvim-lua/plenary.nvim", lazy = false },
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			view_options = {
				show_hidden = true,
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		lazy = false,
	},
	{ "0x00-ketsu/maximizer.nvim", opts = {} },
	{ "qvalentin/helm-ls.nvim", ft = "helm", opts = {} },
}
