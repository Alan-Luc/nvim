local opts = { silent = true, noremap = true }
local keymap = vim.keymap.set
vim.g.mapleader = ","
local helpers = require("alan.helpers")
--  Convenient vim binds and re-binds "
keymap("n", "<leader>2", ":tabp<CR>", opts)
keymap("n", "<leader>3", ":tabn<CR>", opts)
keymap("n", "<leader>4", ":tabclose<CR>", opts)

--  move up and down by a page and center cursor
--  ty primeagen
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<S-j>", "mzJ`z", opts)
keymap("n", "<n>", "nzzzv", opts)
keymap("n", "<N>", "Nzzzv", opts)
-- keymap("x", '<leader>p', "\"_dP", opts)
-- nice substitution
keymap("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

--  move lines up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- copy to clipboard
keymap("n", "<leader>y", '"+y', opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>y", '"+Y', opts)

-- paste from clipboard
keymap("i", "<C-S-v>", "<C-r>+", opts)
keymap("x", "<C-S-v>", '"+p', opts)
keymap("n", "<C-S-v>", '"+p', opts)

-- neogit
keymap("n", "<F12>", ":Neogit<CR>", opts)
keymap("n", "<leader>t", ":Fern . -drawer -toggle<CR>", opts)

--undo tree
keymap("n", "<F5>", vim.cmd.UndotreeToggle)
-- " copy to clipboard and copy last yank to clipboard
-- vim.keymap.set("x", <silent><F12> :!pbcopy <CR><CR>
-- vim.keymap.set("n", <silent><F11> :call system('xclip -selection clipboard', @0)<CR>
keymap("n", "gr", function()
	require("goto-preview").goto_preview_references()
end, opts)

-- keymap('n', '<leader>t', ':Fern . -toggle -drawer<CR>', opts)

keymap("n", "<leader>f", ":LspRestart<CR>", opts)

keymap("n", "<C-g>", function()
	helpers.copy_relative_path()
end, opts)
keymap("n", "<C-h>", function()
	helpers.copy_pwd()
end, opts)

keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
keymap("n", "<leader>vd", vim.diagnostic.open_float)
keymap("n", "<leader>ca", vim.lsp.buf.code_action)
