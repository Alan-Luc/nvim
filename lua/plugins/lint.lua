return {
	"mfussenegger/nvim-lint",
	dependencies = {
		"mason-org/mason.nvim",
		"rshkarin/mason-nvim-lint",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- mason-nvim-lint auto-configures linters installed via mason
		require("mason-nvim-lint").setup({
			-- Automatically install linters (optional - set to {} to disable)
			ensure_installed = {},
			-- Auto-configure nvim-lint with mason-installed linters
			automatic_installation = true,
		})

		local lint = require("lint")
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
