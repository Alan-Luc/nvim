return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		build = ":MasonUpdate",
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local mason_lspconfig = require("mason-lspconfig")

			require("mason").setup()
			mason_lspconfig.setup({
				ensure_installed = {
					"tsserver",
					"pyright",
					"lua_ls",
				},
			})
			local on_attach = function(_, bufnr)
				local map = function(mode, lhs, rhs)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
				end
				map("n", "gd", vim.lsp.buf.definition)
				map("n", "gr", vim.lsp.buf.references)
				map("n", "K", vim.lsp.buf.hover)
				map("n", "<leader>vd", vim.diagnostic.open_float)
				map("n", "<leader>ca", vim.lsp.buf.code_action)
			end
			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,
			})
			vim.diagnostic.config({
				virtual_text = { severity = { min = "INFO", max = "WARN" } },
				virtual_lines = { severity = { min = "ERROR" } },
			})
		end,
	},
}
