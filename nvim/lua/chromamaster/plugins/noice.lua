-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("noice").setup({
			cmdline = {
				enabled = true,
			},
			messages = {
				enabled = false,
			},
			popup_menu = {
				enabled = false,
			},
		})
	end,
}
