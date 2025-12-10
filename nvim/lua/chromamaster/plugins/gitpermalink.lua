return {
	"ChromaMaster/gitpermalink.nvim",
	-- dir = "~/Workspace/Personal/gitpermalink.nvim",
	keys = {
		{
			"<leader>gl",
			function()
				require("gitpermalink").permalink({ open = false })
			end,
			mode = { "n", "v" },
			desc = "[G]it Perma[L]ink",
		},
		{
			"<leader>glr",
			function()
				vim.cmd("Lazy reload gitpermalink.nvim")
			end,
			mode = "",
			desc = "[G]it [P]ermalink [R]eload",
		},
	},
	opts = {
		notifications = {
			enable = true,
		},
		debug = {
			enable = true,
		},
	},
}
