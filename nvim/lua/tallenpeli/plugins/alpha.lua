return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local top_padding = {
			type = "padding",
			val = 5,
		}

		dashboard.section.header.val = {
			"               █████                       █████               ",
			"              ████████                   ████████              ",
			"              ██████████               ██████████              ",
			"              ███████████             ███████████              ",
			"              ███████████████████████████████████              ",
			"              ███████████████████████████████████              ",
			"              ███████████████████████████████████              ",
			"              ███████████████████████████████████              ",
			"             █████████████████████████████████████             ",
			"             ████████      █████████      ████████             ",
			"            █████████       ███████       █████████            ",
			"            ██████████     █████████     ██████████            ",
			"            ███████████████████████████████████████            ",
			"             █████████████████████████████████████             ",
			"              ███████████████     ███████████████              ",
			"               ███████████████   ███████████████               ",
			"                 █████████████████████████████                 ",
			"                   ████████████ ████████████                   ",
			"                          ███  █  ███                          ",
			"                             █████                             ",
			"                                                               ",
			"                      ~ tallenpeli.nvim ~                      ",
		}

		dashboard.section.buttons.val = {
			dashboard.button("n", "  New Buffer", ":enew <CR>"),
			dashboard.button("F", "  Find File", ":FzfLua files<CR>"),
			dashboard.button("g", "  Live Grep", ":FzfLua live_grep<CR>"),
			dashboard.button("b", "  Buffers", ":FzfLua buffers<CR>"),
			dashboard.button("s", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
			dashboard.button("u", "󰚰  Update Config", ":ConfigUpdate <CR>"),
			dashboard.button("q", "󰅙  Quit", ":qa<CR>"),
		}

		dashboard.opts.layout = {
			top_padding,
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			dashboard.section.footer,
		}

		alpha.setup(dashboard.opts)
	end,
}
