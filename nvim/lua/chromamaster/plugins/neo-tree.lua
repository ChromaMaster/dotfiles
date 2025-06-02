-- Neovim plugin to manage the file system and other tree like structures.
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			symlink_target = {
				enabled = true,
			},
			window = {
				position = "float",
				width = 40,
				mappings = {
					["-"] = "open_split",
					["|"] = "open_vsplit",
				},
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				hijack_netrw_behavior = "open_current",
			},
		})

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- vim.keymap.set("n", "<C-b>", ":Neotree focus<CR>", { desc = "Toggle file browser" })
		vim.keymap.set("n", "\\", ":Neotree focus<CR>", { desc = "Toggle file browser" })

		-- Replace netrw :Rex command so it opens neo-tree instead
		vim.api.nvim_create_user_command("Rex", function()
			vim.cmd(":Neotree position=current")
		end, {})
	end,
}
