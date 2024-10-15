local npairs = require('nvim-autopairs')
npairs.setup({
	disable_filetype = { "TelescopePrompt", "vim" },
	map_cr = true,
})
