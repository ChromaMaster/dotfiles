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
			"cpp",
			"go",
			"rust",
			"zig",
			"python",
			"json",
			"yaml",
		}

		require("nvim-treesitter").install(filetypes)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				vim.treesitter.start()

				vim.wo.foldmethod = "expr"
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
				vim.opt.foldenable = true
				vim.opt.foldlevel = 99
			end,
		})

		-- -- Use treesitter for folding
		-- vim.opt.foldmethod = "expr"
		-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	end,
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
	},
}
