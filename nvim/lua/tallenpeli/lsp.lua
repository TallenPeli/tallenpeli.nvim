-- Nix
vim.lsp.config.nixd = {
	cmd = { "nixd" },
	filetypes = { "nix" },
}
vim.lsp.enable("nixd")

-- QML
vim.lsp.config("qmlls", {
	cmd = { "qmlls" },
	filetypes = { "qml", "qmljs" },
	root_markers = { ".qmlls.ini" },
})
vim.lsp.enable("qmlls")
