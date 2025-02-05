-- Smart and Powerful commenting plugin for neovim
return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
	},
	keys = {
		{ "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
		{ "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
		{ "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
		{ "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
	},
}
