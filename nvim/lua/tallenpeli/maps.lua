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

-- Other
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
