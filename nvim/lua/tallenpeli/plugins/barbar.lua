local settings = require("tallenpeli.settings").load()

if settings.ui.barbar == true then
	return {
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false

			local function match_barbar_offset()
				-- Links barbar's sidebar offset header to snacks.explorer's list background
				vim.api.nvim_set_hl(0, "BufferOffset", { link = "SnacksPickerList" })
			end

			match_barbar_offset()
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = match_barbar_offset,
			})
		end,
		opts = {
			animations = settings.ui.animations,
			auto_hide = false,

			sidebar_filetypes = {
				snacks_picker_list = {
					text = " NeoVim",
					align = "left",
					event = "BufWinLeave",
				},
				undotree = {
					text = "undotree",
					align = "center",
				},
				["neo-tree"] = { event = "BufWipeout" },
				Outline = { event = "BufWinLeave", text = "symbols-outline", align = "right" },
			},
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	}
else
	return {}
end
