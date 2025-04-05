return {
	-- Mason setup
	{
		"williamboman/mason.nvim",
		lazy = false,
		build = ":MasonUpdate",
		opts = {}, -- Automatically calls require('mason').setup({})
	},
	-- Autocompletion setup
	{
		"hrsh7th/nvim-cmp", -- Required
		dependencies = {
			"L3MON4D3/LuaSnip", -- Required snippet engine
			-- Useful completion sources:
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/vim-vsnip",
			"windwp/nvim-autopairs", -- Optional autopairs plugin
		},
		config = function()
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local mapping = {
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = nil,
				["<S-Tab>"] = nil,
			}

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip" }, -- or vim-vsnip if you're using that
					{ name = "path" },
					{ name = "buffer" },
				},
				mapping = mapping,
			})
		end,
	},
	-- LSP setup
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",                   -- Completion for LSP
			"williamboman/mason-lspconfig.nvim",      -- Mason integration with lspconfig
			"WhoIsSethDaniel/mason-tool-installer.nvim", -- Optional additional tools
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")
			local mason_tool_installer = require("mason-tool-installer")

			-- Ensure Mason installs these tools
			mason_lspconfig.setup({
				ensure_installed = {
					"ts_ls",
					"pyright",
					-- "gopls",
					"lua_ls",
					-- "rust_analyzer",
				},
			})

			-- Ensure Mason installs these tools
			mason_tool_installer.setup({
				ensure_installed = {
					"prettierd",
					"stylua",
					"black",
					-- "goimports",
					"isort",
				},
			})

			-- Capabilities for nvim-cmp integration
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- on_attach function: for setting up keymaps and other per-buffer options
			local on_attach = function(client, bufnr)
				local keymap = vim.keymap.set
				local opts = { buffer = bufnr, silent = true }

				-- LSP Keybindings
				keymap("n", "gd", function() vim.lsp.buf.definition() end, opts)
				keymap("n", "gr", function() vim.lsp.buf.references() end, opts)
				keymap("n", "K", function() vim.lsp.buf.hover() end, opts)
				keymap("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
				keymap("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
				keymap("n", "[d", function() vim.diagnostic.goto_next() end, opts)
				keymap("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
				keymap("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
				keymap("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
				keymap("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
			end

			-- Configure servers using Mason's handlers
			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
			})

			-- Diagnostics configuration
			vim.diagnostic.config({
				virtual_text = true,
			})
		end,
	},
}
