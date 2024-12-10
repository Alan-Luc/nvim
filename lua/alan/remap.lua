local opts = { silent = true, noremap = true }
vim.g.mapleader = ","
--  Convenient vim binds and re-binds "
vim.keymap.set("n", "<leader>2", ":tabp<CR>", opts)
vim.keymap.set("n", "<leader>3", ":tabn<CR>", opts)

--  move up and down by a page and center cursor
--  ty primeagen
vim.keymap.set("n", '<C-d>', '<C-d>zz', opts)
vim.keymap.set("n", '<C-u>', '<C-u>zz', opts)
vim.keymap.set("n", '<S-j>', 'mzJ`z', opts)
vim.keymap.set("n", '<n>', 'nzzzv', opts)
vim.keymap.set("n", '<N>', 'Nzzzv', opts)
-- vim.keymap.set("x", '<leader>p', "\"_dP", opts)
-- nice substitution
vim.keymap.set("n", '<leader>s', ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)
vim.keymap.set("n", '<leader>x', '<cmd>!chmod +x %<CR>', opts)


--  move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y", opts)
vim.keymap.set("v", "<leader>y", "\"+y", opts)
vim.keymap.set("n", "<leader>y", "\"+Y", opts)

-- paste from clipboard
vim.keymap.set("i", "<C-S-v>", "<C-r>+", opts)
vim.keymap.set("x", "<C-S-v>", "\"+p", opts)
vim.keymap.set("n", "<C-S-v>", "\"+p", opts)


-- neogit
vim.keymap.set("n", "<F12>", ":Neogit<CR>", opts)
vim.keymap.set("n", "<leader>t", ":Fern . -drawer -toggle<CR>", opts)
vim.keymap.set("n", "<Tab>", "<Plug>(fern-action-expand)", opts)
-- " copy to clipboard and copy last yank to clipboard
-- vim.keymap.set("x", <silent><F12> :!pbcopy <CR><CR>
-- vim.keymap.set("n", <silent><F11> :call system('xclip -selection clipboard', @0)<CR>
