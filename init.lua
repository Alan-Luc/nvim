require("alan")
require("config.lazy")
_G.vim = vim
vim.diagnostic.config({
	virtual_text = { severity = { min = "INFO", max = "WARN" } },
	virtual_lines = { current_line = true, severity = { min = "ERROR" } },
})
