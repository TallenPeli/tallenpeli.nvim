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

-- Rust
vim.lsp.config("rust-analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "rust-project.json", ".rustc", "Cargo.toml" },
})
vim.lsp.enable("rust-analyzer")

-- C/C++
local clangd_cmd = {
	"clangd",
	"--background-index",
	"--clang-tidy",
}

-- Check if the user if on NixOS
if vim.fn.isdirectory("/nix/store") == 1 then
	table.insert(clangd_cmd, "--query-driver=/nix/store/*-gcc-wrapper-*/bin/g++,/nix/store/*-gcc-wrapper-*/bin/gcc")
end

vim.lsp.config("clangd", {
	cmd = clangd_cmd,
	filetypes = { "c", "cc", "cpp", "c++", "objc", "objcpp" },
})
vim.lsp.enable("clangd")
