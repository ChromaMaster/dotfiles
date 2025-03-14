-- Move selected text up and down one line
-- This is also provided by mini.move
-- vim.keymap.set("n", "<c-j>", ":m .-2<CR>==")
-- vim.keymap.set("n", "<c-k>", ":m .+1<CR>==")
-- vim.keymap.set("v", "<c-j>", ":m '<-2<CR>gv=gv")
-- vim.keymap.set("v", "<c-k>", ":m '>+1<CR>gv=gv")

-- Disable command history
vim.keymap.set("n", "q:", "<nop>")

-- Remap buffer operations
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bq", ":%bd|e#<CR>", { desc = "Close all buffers except the current one" }) -- %bd closes all the buffers, e# opens the last one

-- Do not move cursor when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the middle when you jump trough the file
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in the middle when you go trough search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy replaced word to void buffer instead of default one
-- vim.keymap.set("x", "<leader>p", "\"_dP")

-- Delete to void register
-- vim.keymap.set("n", "<leader>d", "\"_d")
-- vim.keymap.set("v", "<leader>d", "\"_d")

-- Clear highlight on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- Handled with external plugin: folke/trouble
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<M-h>", "<cmd>vertical resize -5<CR>", { desc = "Decrease vertical size of pane" })
vim.keymap.set("n", "<M-l>", "<cmd>vertical resize +5<CR>", { desc = "Increase vertical size of pane" })
vim.keymap.set("n", "<M-j>", "<cmd>resize -3<CR>", { desc = "Decrease horizontal size of pane" })
vim.keymap.set("n", "<M-k>", "<cmd>resize +3<CR>", { desc = "Increase horizontal size of pane" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
--  Got this from kickstart
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Copies the selected text into the "h" register and open a sed command with the contents: %s/<reg-h>//g
vim.keymap.set("v", "<leader>s", '"hy:%s/<C-r>h//g<left><left>', { desc = "Replace current highlighted text" })
