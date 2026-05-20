return {
  "stevearc/conform.nvim",
  init = function ()
    -- Commands to toggle formatting
    vim.api.nvim_create_user_command("FormatDisable", function (args)
      if args.bang then
        -- FormatDisable! disables for current buffer only
        vim.b.disable_autoformat = true
      else
        -- FormatDisable disables globally
        vim.g.disable_autoformat = true
      end
    end, { desc = "Disable autoformat-on-save", bang = true }
    )

    vim.api.nvim_create_user_command("FormatEnable", function ()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = "Enable autoformat-on-save" }
    )
  end,
  opts = {
    formatters_by_ft = {
      -- Conform will run multiple formatters sequentially
      python = {
        -- To fix auto-fixable lint errors.
        "ruff_fix",
        -- To run the Ruff formatter.
        "ruff_format",
        -- To organize the imports.
        "ruff_organize_imports"
      },
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
      lua = { "stylua" }
    },
    format_on_save = function (bufnr)
      -- Check built-in disable flags
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      -- Directories where format_on_save should be disabled
      local disabled_dirs = { "/Users/alan.luc/dev/platform/nexus", "/Users/alan.luc/dev/platform/ml-platform/.gitlab" }

      local bufname = vim.api.nvim_buf_get_name(bufnr)
      for _, dir in ipairs(disabled_dirs) do
        if bufname:match("^" .. vim.pesc(dir)) then
          return nil -- Disable format_on_save for this buffer
        end
      end

      return {
        timeout_ms = 1000,
        lsp_fallback = true
        -- quiet = true,
      }
    end
  }
}
