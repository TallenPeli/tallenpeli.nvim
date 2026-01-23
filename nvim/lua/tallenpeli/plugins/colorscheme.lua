vim.opt.termguicolors = true

return {
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		-- Comment the following lines to disable the vscode theme
		config = function()
			vim.cmd("colorscheme vscode")
		end,
	},
	{

		"comfysage/evergarden",
		lazy = false,
		priority = 1000,
		-- Uncomment the following lines to enable the evergarden theme
		-- config = function()
		--     vim.cmd("colorscheme evergarden")
		-- end,
	},
	{
		"Mofiqul/adwaita.nvim",
		lazy = false,
		priority = 1000,
		-- Uncomment the following lines to enable the adwaita theme
		-- config = function()
		--     vim.cmd("colorscheme adwaita")
		-- end,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		-- Uncomment the following lines to enable the catppuccin theme
		-- config = function()
		-- 	vim.cmd("colorscheme catppuccin-macchiato")
		-- end,
	},
}
