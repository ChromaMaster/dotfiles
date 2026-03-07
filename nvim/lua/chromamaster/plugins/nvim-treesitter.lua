-- Highlight, edit, and navigate code
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	branch = "main",
	config = function()
		local filetypes = {
			"lua",
			"vim",
			"vimdoc",
			"query",
			"bash",
			"html",
			"markdown",
			"markdown_inline",
			"diff",
			"lua",
			"luadoc",
			"c",
			"go",
			"rust",
			"zig",
			"python",
		}

		require("nvim-treesitter").install(filetypes)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				vim.treesitter.start()
			end,
		})

		-- Use treesitter for folding
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
	end,
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
	},
}
