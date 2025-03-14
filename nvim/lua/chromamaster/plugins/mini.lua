-- Collection of various small independent plugins/modules
return {
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Move any selection in any direction
		--
		-- M-h - Move Left
		-- M-j - Move Down
		-- M-k - Move Up
		-- M-l - Move Right
		-- require("mini.move").setup()

		-- Simple and easy statusline.
		--  You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		local statusline = require("mini.statusline")
		statusline.setup()

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we disable the section for
		-- cursor information because line numbers are already enabled
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return ""
		end

		-- Override the section_filename. In this case it will show only the
		-- relative file name, if motified and if read only
		-- f S  Path to the file in the buffer, as typed or relative to current directory.
		-- m F  Modified flag, text is "[+]"; "[-]" if 'modifiable' is off.
		-- r F  Readonly flag, text is "[RO]".
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_filename = function()
			return "%f%m%r"
		end

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
	end,
}
