return {
	"alan-luc/mini-ssr",
	opts = {},
	keys = {
		{
			"<C-h>",
			function()
				require("mini-ssr").open()
			end,
			desc = "Search and replace",
		},
	},
}
