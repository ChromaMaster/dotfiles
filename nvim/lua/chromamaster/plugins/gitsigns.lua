return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")

		gitsigns.setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = true,
		})

		-- Mappings
		vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk_inline, { desc = "[G]it [P]review hunk" })
		vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { desc = "[G]it [R]eset hunk" })
		vim.keymap.set("n", "<leader>gj", gitsigns.next_hunk, { desc = "[G]it [N]ext hunk" })
		vim.keymap.set("n", "<leader>gk", gitsigns.prev_hunk, { desc = "[G]it [P]revious hunk" })
	end,
}
