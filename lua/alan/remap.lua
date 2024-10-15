vim.g.mapleader = ","
vim.keymap.set("n", "<leader>p", vim.cmd.Ex)
--  Convenient vim binds and re-binds "
vim.keymap.set("n", "<leader>2", ":tabp<CR>")
vim.keymap.set("n", "<leader>3", ":tabn<CR>")

--  move up and down by a page and center cursor
--  ty primeagen
vim.keymap.set("n", '<C-d>', '<C-d>zz')
vim.keymap.set("n", '<C-u>', '<C-u>zz')
vim.keymap.set("n", '<S-j>', 'mzJ`z')
vim.keymap.set("n", '<n>', 'nzzzv')
vim.keymap.set("n", '<N>', 'Nzzzv')
-- vim.keymap.set("x", '<leader>p', "\"_dP")
-- nice substitution
vim.keymap.set("n", '<leader>s', ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", '<leader>x', '<cmd>!chmod +x %<CR>')


--  move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>y", "\"+Y")

-- paste from clipboard
vim.keymap.set("i", "<C-S-v>", "<C-r>+")
vim.keymap.set("x", "<C-S-v>", "\"+p")
vim.keymap.set("n", "<C-S-v>", "\"+p")


-- neogit
vim.keymap.set("n", "<F12>", ":Neogit<CR>")
-- " copy to clipboard and copy last yank to clipboard
-- vim.keymap.set("x", <silent><F12> :!pbcopy <CR><CR>
-- vim.keymap.set("n", <silent><F11> :call system('xclip -selection clipboard', @0)<CR>
