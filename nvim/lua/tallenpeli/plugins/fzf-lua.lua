return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			"default",
			winopts = {
				height = 0.85,
				width = 0.80,
				preview = {
					border = "border",
					wrap = "nowrap",
				},
			},
		})
	end,
}
