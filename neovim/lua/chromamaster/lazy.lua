local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Detect tabstop and shiftwidth automatically
    { 'tpope/vim-sleuth' },

    -- Use `opts = {}` to force a plugin to be loaded.
    --
    --  This is equivalent to:
    --    require('Comment').setup({})

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim',  opts = {} },

    -- Adds git related signs to the gutter, as well as utilities for managing changes
    { 'lewis6991/gitsigns.nvim' },

    -- Useful plugin to show you pending keybinds.
    {
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    },

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { -- If encountering errors, see telescope-fzf-native README for install instructions
                'nvim-telescope/telescope-fzf-native.nvim',

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = 'make',

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            -- Useful for getting pretty icons, but requires special font.
            --  If you already have a Nerd Font, or terminal set up with fallback fonts you can enable this
            { 'nvim-tree/nvim-web-devicons' },
        },
    },

    -- Theme
    {
        'folke/tokyonight.nvim',
        name = 'tokyonight',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
    },

    -- Syntax highlighting
    { 'nvim-treesitter/nvim-treesitter',  build = ':TSUpdate' },

    -- See full history of changes
    { 'mbbill/undotree' },

    -- Use git inside nvim
    { 'tpope/vim-fugitive' },

    -- All this is for the lsp
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },

    { 'williamboman/mason.nvim' },

    { 'williamboman/mason-lspconfig.nvim' },

    -- LSP Support
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
        },
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
        }
    },
    -- until here


    { 'github/copilot.vim', build = ':Copilot setup' }
})
