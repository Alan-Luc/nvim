return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v2.x',
	dependencies = {
		-- LSP Support
		{ 'neovim/nvim-lspconfig' }, -- Required
		{                          -- Optional
			'williamboman/mason.nvim',
			run = function()
				pcall(vim.api.nvim_command, 'MasonUpdate')
			end,
		},
		{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

		-- Autocompletion
		{ 'hrsh7th/nvim-cmp' },   -- Required
		{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
		{ 'L3MON4D3/LuaSnip' },   -- Required
		-- Useful completion sources:
		{ 'hrsh7th/cmp-nvim-lua' },
		{ 'hrsh7th/cmp-nvim-lsp-signature-help' },
		{ 'hrsh7th/cmp-vsnip' },
		{ 'hrsh7th/cmp-path' },
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/vim-vsnip' },
	},
	config = function()
		local lsp = require("lsp-zero")

		lsp.preset("recommended")

		lsp.ensure_installed({
			'denols',
			'ts_ls',
			'rust_analyzer',
			-- 'gopls',
			'ruff',
			-- 'pyright'
		})

		-- Fix Undefined global 'vim'
		lsp.nvim_workspace()

		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		local cmp = require('cmp')
		cmp.event:on(
			'confirm_done',
			cmp_autopairs.on_confirm_done()
		)
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local cmp_mappings = lsp.defaults.cmp_mappings({
			-- ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
			-- ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
			-- ['<CR>'] = cmp.mapping.confirm({ select = true }),
			['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
			['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
			['<C-y>'] = cmp.mapping.confirm({ select = true }),
			-- ['<C-Space>'] = cmp.mapping.complete(),
		})

		cmp_mappings['<Tab>'] = nil
		cmp_mappings['<S-Tab>'] = nil

		lsp.setup_nvim_cmp({
			mapping = cmp_mappings
		})

		lsp.set_preferences({
			suggest_lsp_servers = true,
			sign_icons = {
				error = 'E',
				warn = 'W',
				hint = 'H',
				info = 'I'
			}
		})

		lsp.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }

			vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
			vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
			vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
			vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
			vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
			vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
			vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
			vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
			vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
			vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
		end)

		lsp.format_on_save({
			format_opts = {
				async = true,
				timeout_ms = 10000,
			},
			servers = {
				['lua_ls'] = { 'lua' },
			}
		})

		lsp.setup()

		vim.diagnostic.config({
			virtual_text = true
		})
	end
}
