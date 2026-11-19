return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- Optional: adds file icons (requires a Nerd Font)
	},
	opts = {
		view = {
			width = 35,
		},
		filters = {
			dotfiles = false, -- Set to true if you want hidden files hidden by default
		},
		actions = {
			open_file = {
				quit_on_open = false, -- Keeps the tree open after selecting a file
			},
		},
	},
}
