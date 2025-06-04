return {
	"ChromaMaster/gitpermalink.nvim",
	dependencies = {
		{ "j-hui/fidget.nvim", opts = { notification = { window = { align = "top" } } } },
	},
	keys = {
		{
			"<leader>gpl",
			function()
				require("gitpermalink").permalink()
			end,
			mode = { "n", "v" },
			desc = "[G]it [P]erma[L]ink",
		},
		{
			"<leader>gpr",
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
			provider = function()
				return require("fidget.notification").notify
			end,
		},
		debug = {
			enable = false,
		},
	},
}
