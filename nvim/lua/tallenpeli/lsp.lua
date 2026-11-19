-- =============================================================================
-- Native LSP Configuration (Neovim 0.11+)
-- =============================================================================
-- How to add a new Language Server:
--   1. Add an entry to the `servers` table below:
--        <language_name> = "<executable_name>"
--      Neovim will automatically check if `<executable_name>` is on your PATH
--      and ignore it if it is not installed.
--   2. Define the server using the exact same `<config_name>`:
--        vim.lsp.config("<config_name>", {
--            cmd = { "<executable_name>" },
--            filetypes = { "<ft1>", "<ft2>" },
--            root_markers = { "<root_file>", ".git" },
--        })
--
-- Further Reading & Reference Sources:
--   - Neovim Built-in Docs:  :help lsp-config  |  :help vim.lsp.config()
--                            :help lsp-quickstart  |  :help vim.lsp.completion
--   - Official Server Configs (reference cmd, filetypes, & root_markers):
--     https://github.com/neovim/nvim-lspconfig/tree/master/lsp
--   - nvim-lspconfig Server Docs (full list of language servers & settings):
--     https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- =============================================================================

-- Language Servers
local servers = {
	-- <language_name> = "<executable_name>"
	nixd = "nixd",
	qmlls = "qmlls",
	lua_ls = "lua-language-server", -- The name is `lua_ls` specifically as a work around for lazydev
	rust = "rust-analyzer",
	c_cpp = "clangd",
	python = "pyright-langserver",
	css = "vscode-css-language-server",
	html = "vscode-html-language-server",
	json = "vscode-json-language-server",
	eslint = "vscode-eslint-language-server",
	ts_ls = "typescript-language-server",
}

vim.lsp.config("nixd", {
	cmd = { servers.nixd },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
})

vim.lsp.config("qmlls", {
	cmd = { servers.qml },
	filetypes = { "qml" },
	root_markers = { ".qmlls.ini", "shell.qml", ".git" },
	on_init = function(client, _)
		if client.server_capabilities then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

vim.lsp.config("lua_ls", {
	cmd = { servers.lua_ls },
	filetypes = { "lua", "luau" },
	root_markers = { ".luarc.json" },
	workspace_required = false,
})

vim.lsp.config("rust", {
	cmd = { servers.rust },
	filetypes = { "rust" },
	root_markers = { "rust-project.json", ".rustc", "Cargo.toml" },
})

vim.lsp.config("python", {
	cmd = { servers.python, "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	workspace_required = false,
})

vim.lsp.config("css", {
	cmd = { servers.css, "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { "package.json", ".git" },
	workspace_required = false,
})

vim.lsp.config("html", {
	cmd = { servers.html, "--stdio" },
	filetypes = { "html", "templ" },
	root_markers = { "package.json", ".git" },
	workspace_required = false,
})

vim.lsp.config("json", {
	cmd = { servers.json, "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { ".git" },
	workspace_required = false,
})

-- JavaScript / TypeScript
vim.lsp.config("ts_ls", {
	cmd = { servers.ts_ls, "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	workspace_required = false,
})

-- ESLint
vim.lsp.config("eslint", {
	cmd = { servers.eslint, "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
	root_markers = {
		".eslintrc",
		".eslintrc.js",
		".eslintrc.json",
		"eslint.config.js",
		"eslint.config.mjs",
		"package.json",
	},
})

-- Custom command for clangd, not defined in servers.c_cpp

local clangd_cmd = {
	"clangd",
	"--background-index",
	"--clang-tidy",
}

-- Check if the user is on NixOS
if vim.fn.isdirectory("/nix/store") == 1 then
	table.insert(clangd_cmd, "--query-driver=/nix/store/*-gcc-wrapper-*/bin/g++,/nix/store/*-gcc-wrapper-*/bin/gcc")
end

vim.lsp.config("c_cpp", {
	cmd = clangd_cmd,
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_markers = { "compile_commands.json", ".git" },
})

-- If using another c/c++ lsp, comment out the clang configuration above and uncomment this
-- vim.lsp.config("c_cpp", {
--     cmd = { servers.c_cpp },
--     filetypes = { "c", "cpp", "objc", "objcpp" },
--     root_markers = { "compile_commands.json", ".git" }
-- })

-- Enable available servers in the server object
for server, bin in pairs(servers) do
	if vim.fn.executable(bin) == 1 then
		vim.lsp.enable(server)
	end
end

-- Automatically enable native completions when an LSP attached to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})
