-- Smart and Powerful commenting plugin for neovim
return {
	"numToStr/Comment.nvim",
	lazy = false,
	config = function()
		require("Comment").setup({
			-- add any options here
		})
	end,
}
