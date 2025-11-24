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
