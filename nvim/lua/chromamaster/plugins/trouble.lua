-- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local trouble = require("trouble")

		trouble.setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			preview = {
				type = "split",
				relative = "win",
				position = "right",
				size = 0.3,
			},
		})

		-- Ignore formatting to not format functions inside this
		-- stylua: ignore start
		vim.keymap.set("n", "<leader>tw", function() trouble.open("diagnostics") end, { desc = "[T]rouble [W]orkspace diagnostics" })
		vim.keymap.set("n", "<leader>td", function() trouble.open({mode = "diagnostics", filter = {buf = 0}}) end, { desc = "[T]rouble [D]ocument diagnostics" })
		vim.keymap.set("n", "<leader>tn", function() trouble.next({skip_groups = true, jump = true}) end, { desc = "[T]rouble [N]ext item" })
		vim.keymap.set("n", "<leader>tp", function() trouble.previous({skip_groups = true, jump = true}) end, { desc = "[T]rouble [P]revious item" })
		vim.keymap.set("n", "<leader>tq", function() trouble.close() end, { desc = "[T]rouble [Q]uit" })
		-- stylua: ignore end
	end,
}
