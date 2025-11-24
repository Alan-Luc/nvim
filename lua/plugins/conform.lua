return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			-- Conform will run multiple formatters sequentially
			python = { "black" },
			javascript = { "prettierd", args = { "--config", ".prettierrc" } },
			javascriptreact = { "prettierd", args = { "--config", ".prettierrc" } },
			typescript = { "prettierd", args = { "--config", ".prettierrc" } },
			typescriptreact = { "prettierd", args = { "--config", ".prettierrc" } },
			json = { "prettierd", args = { "--config", ".prettierrc" } },
			yaml = { "prettierd", args = { "--config", ".prettierrc" } },
			yml = { "prettierd", args = { "--config", ".prettierrc" } },
			vue = { "prettierd" },
			go = { "gofmt", "goimports", "golines" },
			rust = { "rustfmt" },
			ruby = { "rubocop" },
			lua = { "stylua" },
		},
		format_on_save = {
			timeout_ms = 1000, -- Timeout for formatting on save
			lsp_fallback = true, -- Use LSP formatting if no formatter is found
			quiet = true, -- Suppress unnecessary messages
		},
	},
}
