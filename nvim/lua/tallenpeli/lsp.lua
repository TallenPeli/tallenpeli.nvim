-- Nix
vim.lsp.config.nixd = {
	cmd = { "nixd" },
	filetypes = { "nix" },
}
vim.lsp.enable("nixd")

-- QML
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("qmlls", {
	cmd = { "qmlls" },
	filetypes = { "qml", "qmljs" },
	root_markers = { ".qmlls.ini", "shell.qml", ".git" },
	capabilities = capabilities,
	on_init = function(client, _)
		if client.server_capabilities then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})
vim.lsp.enable("qmlls")
