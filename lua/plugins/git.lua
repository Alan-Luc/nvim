return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "≈" },
				untracked = { text = "┆" },
			},
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "ibhagwan/fzf-lua" },
			{ "sindrets/diffview.nvim" },
		},
		opts = {
			disable_line_numbers = false,
			kind = "floating",
			auto_refresh = true,
			popup = {
				kind = "floating",
			},
			commit_editor = {
				kind = "floating",
			},
			commit_select_view = {
				kind = "floating",
			},
			commit_view = {
				kind = "floating",
			},
			log_view = {
				kind = "floating",
			},
			rebase_editor = {
				kind = "floating",
			},
			reflog_view = {
				kind = "floating",
			},
			merge_editor = {
				kind = "floating",
			},
			preview_buffer = {
				kind = "floating",
			},
		},
		config = function(_, opts)
			require("neogit").setup(opts)
			-- Ensure line numbers are shown in neogit buffers
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "Neogit*",
				callback = function()
					vim.opt_local.number = true
				end,
			})
			-- Refocus neogit window after commit (including pre-commit hooks)
			vim.api.nvim_create_autocmd("User", {
				pattern = "NeogitCommitComplete",
				callback = function()
					-- Find the neogit window and focus it
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local buf = vim.api.nvim_win_get_buf(win)
						local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
						if ft == "NeogitStatus" then
							vim.api.nvim_set_current_win(win)
							break
						end
					end
				end,
			})
		end,
		cmd = "Neogit",
		keys = {
			{
				"<C-l>",
				":Neogit<CR>",
				desc = "Show Neogit UI",
			},
		},
	},
}
