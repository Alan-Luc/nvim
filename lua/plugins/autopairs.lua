return {
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	config = true,
	-- use opts = {} for passing setup options
	-- this is equivalent to setup({}) function
	opts = {
		disable_filetype = { "TelescopePrompt", "vim" },
		map_cr = true,
	}
}
