-- Lightweight yet powerful formatter plugin for Neovim

local confort = {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				json = { "prettier" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				-- javascript = { { "prettierd", "prettier" } },
			},
		})

		-- The conform formatexpr should fall back to LSP when no formatters are available, and fall back to
		-- the internal default if no LSP clients are available. So it should be safe to set it globally.
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}

return confort
