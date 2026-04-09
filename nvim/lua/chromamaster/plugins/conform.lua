-- Lightweight yet powerful formatter plugin for Neovim

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end

			-- Disable autoformat on certain filetypes
			local ignore_filetypes = { "markdown", "xml", "cmake", "proto" }
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
			python = function(bufnr)
				local conform = require("conform")
				local black_available = conform.get_formatter_info("black", bufnr).available
				local isort_available = conform.get_formatter_info("isort", bufnr).available

				-- Use black & isort whenever is available, if not, use ruff
				if black_available and isort_available then
					return { "isort", "black" }
				else
					return { "ruff_fix", "ruff_format", "ruff_organize_imports" }
				end
			end,
			ocaml = { "ocamlformat" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			cmake = { "cmake_format" },
		},
	},
	init = function()
		-- The conform formatexpr should fall back to LSP when no formatters are available, and fall back to
		-- the internal default if no LSP clients are available. So it should be safe to set it globally.
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})
		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
}
