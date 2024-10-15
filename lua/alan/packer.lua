-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use('wbthomason/packer.nvim')


	-- telescope.nvim
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	-- kanagawa.nvim
	use({
		'rebelot/kanagawa.nvim',
		as = 'kanagawa',
		config = function()
			vim.cmd('colorscheme kanagawa-dragon')
		end
	})

	-- treesitter.nvim
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

	-- lualine.nvim
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	-- undotree
	use('mbbill/undotree')

	-- t-pope
	use('tpope/vim-fugitive')
	use('tpope/vim-surround')
	use('tpope/vim-vinegar')
	use('tpope/vim-eunuch')
	use('tpope/vim-rails')
	use('tpope/vim-repeat')

	-- endwise
	use {
		"RRethy/nvim-treesitter-endwise",
		config = function()
			require('nvim-treesitter.configs').setup {
				endwise = {
					enable = true,
				},
			}
		end
	}

	-- lsp-zero
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{                         -- Optional
				'williamboman/mason.nvim',
				run = function()
					pcall(vim.api.nvim_command, 'MasonUpdate')
				end,
			},
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },  -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'L3MON4D3/LuaSnip' },  -- Required
			-- Useful completion sources:
			{ 'hrsh7th/cmp-nvim-lua' },
			{ 'hrsh7th/cmp-nvim-lsp-signature-help' },
			{ 'hrsh7th/cmp-vsnip' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/vim-vsnip' },
		}
	}


	-- to comment in vue or jsx where commenting differs between sections of the page
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	-- gitsigns
	use('lewis6991/gitsigns.nvim')


	-- QOL
	use {
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end
	}

	-- autotags
	use {
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end
	}


	use('haya14busa/is.vim')
	use('ap/vim-css-color')
	use {
		'NvChad/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup {
				user_default_options = {
					css = true,
					rgb_fn = true,
					hsl_fn = true,
					css_fn = true,
				}
			}
		end
	}


	use {
		'NeogitOrg/neogit',
		requires = {
			{ "nvim-lua/plenary.nvim" },      -- required
			{ "nvim-telescope/telescope.nvim" }, -- optional
			{ "sindrets/diffview.nvim" },     -- optional
		},
		config = function()
			require("neogit").setup()
		end
	}


	-- vim visual multi
	use("mg979/vim-visual-multi")

	-- conform.nvim - null-ls replacement
	use {
		'stevearc/conform.nvim',
		config = function() require('conform').setup() end
	}
	-- kitty syntax highlighting
	use("fladson/vim-kitty")

	-- search and replace with a nice window
	use("cshuaimin/ssr.nvim")
end)
