vim.keymap.set("n", "<leader>F", "<cmd>FzfLua files<CR>", { desc = "FZF find files" })
vim.keymap.set("n", "<leader>g", "<cmd>FzfLua live_grep<CR>", { desc = "FZF live grep" })
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<CR>", { desc = "FZF buffers" })

-- Toggle Neo tree (sidebar)
vim.keymap.set("n", "<leader>s", function()
	require("neo-tree.command").execute({ toggle = true })
end, { desc = "Toggle sidebar (neo-tree)" })

-- Toggle supermaven
vim.keymap.set("n", "<leader>ai", function()
	local api = require("supermaven-nvim.api")
	api.toggle()

	if api.is_running() then
		print("Supermaven Enabled")
	else
		print("Supermaven Disabled")
	end
end)

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

-- Other
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
