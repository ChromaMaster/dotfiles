local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.just = {
    install_info = {
        url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main",
        -- use_makefile = true -- this may be necessary on MacOS (try if you see compiler errors)
    },
    maintainers = { "@IndianBoy42" },
}

require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
        "c",
        "rust",
        "go",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "just",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

--local ts_parsers = require "nvim-treesitter.parsers"
--print(parser_config.get_parser_configs())
--if not ts_parsers.has_parser("just") then
--    vim.cmd [[:TSInstall just]]
--end

