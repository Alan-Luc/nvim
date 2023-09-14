-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
	-- All formatter configurations are opt-in
	filetype = {
		javascript = {
			require("formatter.filetypes.javascript").prettierd,

			function()
				return {
					exe = "prettierd",
					args = { util.escape_path(util.get_current_buffer_file_path()) },
					stdin = true,
				}
			end
		},
		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace
		}
	}
}
