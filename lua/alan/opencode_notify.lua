local M = {}

function M.ping(message, level, title)
  vim.schedule(function()
    vim.notify(
      message or "Opencode needs your attention",
      level or vim.log.levels.WARN,
      { title = title or "Opencode" }
    )
  end)
end

return M
