local wk = require("which-key")

-- Switched to which-key to manage keymaps
wk.add({
	-- Search Group
	{
		{ "<leader>f", group = "Search" },
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Search: Filename",
			mode = "n",
		},
		{
			"<leader>fl",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Search: LSP Symbols",
			mode = "n",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Search: File Contents",
			mode = "n",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Search: Buffer Contents",
			mode = "n",
		},
		{
			"<leader>fG",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Search: Git Logs",
			mode = "n",
		},
	},

	-- Git Group
	{
		{ "<leader>g", group = "Git" },
		{
			"<leader>gb",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git: Logs",
			mode = "n",
		},
	},

	-- Snacks Explorer (sidebar)
	{
		"<leader>s",
		function()
			Snacks.explorer()
		end,
		desc = "Sidebar: Toggle",
		mode = "n",
	},

	-- Editor binds
	{
		"<leader>e",
		vim.diagnostic.open_float,
		desc = "Show line diagnostics",
		mode = "n",
	},
	{
		"<leader>t",
		function()
			Snacks.terminal.toggle()
		end,
		desc = "Terminal: Toggle",
		mode = "n",
	},

	-- Config settings menu
	{
		"<leader>S",
		function()
			require("tallenpeli.settings").open_menu()
		end,
		desc = "tallenpeli.nvim: Open Settings",
		mode = "n",
	},
	{
		"<leader>F",
		function()
			require("conform").format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end,
		{ desc = "Format file or range (in visual mode)" },
		mode = { "n", "v" },
	},
})

-- LSP
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

-- Tab to cycle forward, Shift-Tab to cycle backward through completion items
vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-n>"
	end
	return "<Tab>"
end, { expr = true, silent = true })
vim.keymap.set("i", "<S-Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-p>"
	end
	return "<S-Tab>"
end, { expr = true, silent = true })

-- Enter selects highlighted completion item; regular newline if nothing is selected
vim.keymap.set("i", "<CR>", function()
	if vim.fn.pumvisible() == 1 and vim.fn.complete_info({ "selected" }).selected ~= -1 then
		return "<C-y>"
	end
	return "<CR>"
end, { expr = true, silent = true })
