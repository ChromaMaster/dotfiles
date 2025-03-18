-- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				globalstatus = true,
			},
			sections = {
				lualine_b = { "branch" },
				lualine_c = {
					{
						"filename",
						path = 1, -- 1: Relative path
					},
				},
				lualine_x = { "encoding", "filetype" },
			},
		})
	end,
}
