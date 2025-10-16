return {
	"Mofiqul/vscode.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("colorscheme vscode")
	end,

    "comfysage/evergarden",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme evergarden")
    end,
}
