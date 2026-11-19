local settings = require("tallenpeli.settings").load()

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		image = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = settings.ui.animations },
		statuscolumn = { enabled = true },
		words = { enabled = true },

		-- Open the terminal under the currently open file buffer
		terminal = {
			enabled = true,
			win = {
				position = "bottom",
				relative = "win",
				height = 0.25,
				wo = {
					winbar = "",
				},
			},
		},

		-- Allow closing the file viewer with 'ZZ' instead of 'q'
		picker = {
			enabled = true,
			sources = {
				explorer = {
					layout = {
						auto_hide = { "input" },
						layout = {
							width = 35,
						},
					},
					win = {
						list = {
							keys = {
								["Z"] = false,
								["ZZ"] = "cancel",
							},
						},
					},
				},
			},
		},
	},
}
