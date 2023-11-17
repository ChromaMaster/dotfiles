vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move selected text up and down one line
vim.keymap.set("n", "<c-j>", ":m '.+1<CR>==")
vim.keymap.set("n", "<c-k>", ":m '.-2<CR>==")
vim.keymap.set("v", "<c-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<c-k>", ":m '<-2<CR>gv=gv")

-- Do not move cursor when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the middle when you jump trough the file
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in the middle when you go trough search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy replaced word to void buffer instead of default one
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Delete to void register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Replace current highlited word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
