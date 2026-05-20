return {
  "mfussenegger/nvim-lint",
  dependencies = {
    "mason-org/mason.nvim",
    "rshkarin/mason-nvim-lint"
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function ()
    -- mason-nvim-lint auto-configures linters installed via mason
    require("mason-nvim-lint").setup({
      ensure_installed = {},
      automatic_installation = false,
      ignore_install = { "janet", "inko", "clj-kondo", "ruby", "vale" }
    })

		local lint = require("lint")

		-- ruff LSP handles Python linting, avoid duplicates
		lint.linters_by_ft.python = {}

		-- vale requires a .vale.ini; without one it exits with code 2.
		lint.linters_by_ft.markdown = {}
		lint.linters_by_ft.text = {}

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function ()
        lint.try_lint()
      end
    })
  end
}
