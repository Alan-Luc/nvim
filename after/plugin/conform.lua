require("conform").setup({
	formatters_by_ft = {
		-- Conform will run multiple formatters sequentially
		python = { "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { "prettierd" },
		go = { "gofmt" },
		rust = { "rustfmt" },
		ruby = { "rubocop" },
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
		quiet = true,
	},
})
