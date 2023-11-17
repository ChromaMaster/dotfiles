-- line number & relative numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- 4 space indent 
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

-- Disable highlight search but allow incremental
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- Do not allow less than 8 lines above and below the current line
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "80"

-- Ignore case if all lowercase, otherwise case sensitive
vim.opt.smartcase = true
