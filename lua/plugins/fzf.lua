return {
	"ibhagwan/fzf-lua",
	config = function(_, opts)
		-- Set title colors (dragonRed from kanagawa-paper-ink)
		vim.api.nvim_set_hl(0, "FzfLuaPreviewTitle", { fg = "#c4746e" })
		vim.api.nvim_set_hl(0, "FzfLuaTitle", { fg = "#c4746e" })
		require("fzf-lua").setup(opts)
	end,
	opts = {
		{ "telescope", "default" },
		fzf_opts = {
			["--cycle"] = true,
			["--wrap"] = true,
			["--layout"] = "reverse-list",
		},
		grep = {
			rg_opts = "--sort-files --hidden --column --line-number --no-heading "
				.. "--color=always --smart-case -g '!{.git,node_modules}/*'",
		},
		winopts = {
			preview = {
				-- layout = "vertical",
				-- vertical = "up:60%",
				horizontal = "right:60%",
			},
		},
		previewers = {
			builtin = {
				title_fnamemodify = function(s)
					local path = require("fzf-lua.path")
					-- Expand ~ and make relative to cwd
					local abs = vim.fn.expand(s)
					local cwd = vim.fn.getcwd()
					return path.relative_to(abs, cwd) or s
				end,
			},
		},
		actions = {
			files = {
				["ctrl-v"] = {
					fn = function(selected, opts)
						require("fzf-lua").actions.file_vsplit(selected, opts)
					end,
				},
			},
		},
		files = {
			actions = {
				-- add file to buffer list without opening them (like :badd)
				["ctrl-b"] = {
					fn = function(selected, opts)
						require("fzf-lua.actions").file_open_in_background(selected, opts)
						local count = #selected
						vim.notify(
							string.format("Added %d file%s to buffers", count, count > 1 and "s" or ""),
							vim.log.levels.INFO
						)
					end,
					reload = true,
				},
			},
		},
		buffers = {
			actions = {
				["ctrl-x"] = {
					fn = function(selected, opts)
						require("fzf-lua.actions").buf_del(selected, opts)
					end,
					reload = true,
				},
				-- Disable ctrl-d to hide it from hints
				["ctrl-d"] = false,
			},
		},
	},
	keys = {
		{
			"<C-f>",
			function()
				require("fzf-lua").files({
					cwd_prompt = false,
				})
			end,
			mode = "n",
			desc = "Find files",
		},
		{
			"<C-p>",
			function()
				require("fzf-lua").live_grep_native({
					fzf_cli_args = "--nth 2..",
					-- resume = true,
				})
			end,
			mode = "n",
			desc = "Live grep",
		},
		{
			"gd",
			function()
				local FzfLua = require("fzf-lua")
				FzfLua.lsp_definitions({
					ignore_current_line = true,
					sync = true,
					jump1 = true,
				})
			end,
			mode = "n",
			desc = "lsp defs",
		},
		{
			"gv",
			function()
				local FzfLua = require("fzf-lua")
				FzfLua.lsp_definitions({
					ignore_current_line = true,
					sync = true,
					jump1 = true,
					jump1_action = FzfLua.actions.file_vsplit,
				})
			end,
			mode = "n",
			desc = "lsp defs",
		},
		{
			"gr",
			function()
				require("fzf-lua").lsp_references({ ignore_current_line = true, jump1 = true })
			end,
			mode = "n",
			desc = "lsp refs",
		},
		{
			"gi",
			function()
				require("fzf-lua").lsp_implementations({ jump1 = true })
			end,
			mode = "n",
			desc = "lsp implementations",
		},
		{
			"gt",
			function()
				require("fzf-lua").lsp_typedefs({ jump1 = true })
			end,
			mode = "n",
			desc = "lsp type defs",
		},
		{
			"<leader>b",
			function()
				require("fzf-lua").buffers()
			end,
			mode = "n",
			desc = "buffers",
		},
		{
			"<leader>s",
			function()
				require("fzf-lua").spell_suggest()
			end,
			mode = "n",
			desc = "spell suggest",
		},
		{
			"<leader>ca",
			":lua require'fzf-lua'.lsp_code_actions({ winopts = {relative='cursor',row=1.01, col=0, height=0.2, width=0.4} })<CR>",
			mode = "n",
			desc = "code actions",
		},
		{
			"<leader>g",
			function()
				require("fzf-lua").git_status()
			end,
			mode = "n",
			desc = "git status",
		},
	},
}
