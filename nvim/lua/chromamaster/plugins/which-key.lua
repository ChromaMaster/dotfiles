return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	opts = {},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},

		{ "<leader>s", group = "[S]earch" },
		{ "<leader>b", group = "[B]uffer" },
		{ "<leader>d", group = "[D]iagnostics" },
		{ "<leader>g", group = "[G]it related" },
	},
}
