-- Highlight, edit, and navigate code
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

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
		-- Use tresitter for folding
		-- vim.wo.foldmethod = "expr"
		-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		-- vim.opt.foldenable = false
	end,
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
	},
}
