return {
	"ibhagwan/fzf-lua",
	opts = {
		{ "telescope", "fzf-native" },
		fzf_opts = {
			["--cycle"] = true,
			["--wrap"] = true,
			["--layout"] = "reverse-list",
		},
		grep = {
			rg_opts = "--sort-files --hidden --column --line-number --no-heading "
				.. "--color=always --smart-case -g '!{.git,node_modules}/*'",
		},
		previewers = {
			bat = {
				theme = "ansi",
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
				})
			end,
			mode = "n",
			desc = "Live grep",
		},
		{
			"gd",
			function()
				require("fzf-lua").lsp_definitions({
					ignore_current_line = true,
					sync = true,
					jump1 = true,
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
			"<leader>g",
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
			":lua require'fzf-lua'.lsp_code_actions({ winopts = {relative='cursor',row=1.01, col=0, height=0.2, width=0.4} })<cr>",
			mode = "n",
			desc = "code actions",
		},
	},
}
