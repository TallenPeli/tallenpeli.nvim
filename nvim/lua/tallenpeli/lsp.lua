-- Automatically enable native completions when an LSP attached to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

-- Nix
vim.lsp.config("nixd", {
	cmd = { "nixd" },
	filetypes = { "nix" },
})

vim.lsp.enable("nixd")

-- QML
vim.lsp.config("qmlls", {
	cmd = { "qmlls" },
	filetypes = { "qml", "qmljs" },
	root_markers = { ".qmlls.ini", "shell.qml", ".git" },
	on_init = function(client, _)
		if client.server_capabilities then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})
vim.lsp.enable("qmlls")

-- Lua
vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua", "luau" },
	root_markers = { ".luarc.json" },
})
vim.lsp.enable("lua_ls")
