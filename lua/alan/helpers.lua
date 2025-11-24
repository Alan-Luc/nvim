local M = {}

function M.copy_relative_path()
	local relative_path = vim.fn.expand("%")
	vim.fn.setreg("+", relative_path)
	print(relative_path)
end

function M.copy_pwd()
	local current_dir = vim.fn.getcwd()
	vim.fn.setreg("+", current_dir)
	print(current_dir)
end

function M.print_linters()
	local linters = require("lint").get_running()
	if #linters == 0 then
		return "󰦕"
	end
	print("󱉶 " .. table.concat(linters, ", "))
end

return M
