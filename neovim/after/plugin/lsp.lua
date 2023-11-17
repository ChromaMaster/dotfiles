local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

    vim.keymap.set("n", "<leader>ld", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>lD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "<leader>li", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>lt", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "<leader>lrf", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>lc", function() vim.lsp.buf.code_action() end, opts)


    -- Diagnostic
    vim.keymap.set("n", "<leader>ll", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)


end)

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = {
        'lua_ls', -- Lua
        'cmake', -- Cmake
        'bashls', -- Bash
        'clangd', -- C/C++
        'jedi_language_server', -- Python
        'rust_analyzer', -- Rust
        'gopls', -- Go
    },
    handlers = {
        lsp.default_setup,
    }
})

lsp.setup()

require('lspconfig').lua_ls.setup{
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
        },
    },
}

-- The plugin responsible for autocompletion is nvim-cmp
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})

