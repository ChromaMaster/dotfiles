-- Lightweight yet powerful formatter plugin for Neovim

return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable autoformat on certain filetypes
				local ignore_filetypes = { "markdown" }
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return
				end

				return { timeout_ms = 500, lsp_format = "fallback" }
			end,

			formatters_by_ft = {
				lua = { "stylua" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				xml = { "xmlformat" },
				-- nix = { "alejandra" },
				nix = { "nixfmt" },
				bash = { "shfmt" },
				python = { "isort", "black" },
			},
		})

		-- The conform formatexpr should fall back to LSP when no formatters are available, and fall back to
		-- the internal default if no LSP clients are available. So it should be safe to set it globally.
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, { desc = "[C]ode [F]ormat" })
	end,
}
