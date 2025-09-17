return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} },
<<<<<<< HEAD
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
=======
<<<<<<< HEAD
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local nvim_lsp = require("lspconfig")
=======
>>>>>>> 8d44679cff336950fabe07620398afe37ceb04d5
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
<<<<<<< HEAD
		local nvim_lsp = require("lspconfig")
=======

>>>>>>> 33935393b7f45202c46dc008eda56b8e74595332
>>>>>>> 8d44679cff336950fabe07620398afe37ceb04d5
		local protocol = require("vim.lsp.protocol")

		local on_attach = function(client, bufnr)
			-- format on save
			if client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("Format", { clear = true }),
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format()
					end,
				})
			end
		end

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

<<<<<<< HEAD
		mason_lspconfig.setup({
=======
<<<<<<< HEAD
		mason_lspconfig.setup({
=======
		mason_lspconfig.setup_handlers({
>>>>>>> 33935393b7f45202c46dc008eda56b8e74595332
>>>>>>> 8d44679cff336950fabe07620398afe37ceb04d5
			function(server)
				nvim_lsp[server].setup({
					capabilities = capabilities,
				})
			end,
			["ts_ls"] = function()
				nvim_lsp["ts_ls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["cssls"] = function()
				nvim_lsp["cssls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["tailwindcss"] = function()
				nvim_lsp["tailwindcss"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["html"] = function()
				nvim_lsp["html"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["jsonls"] = function()
				nvim_lsp["jsonls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["eslint"] = function()
				nvim_lsp["eslint"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["pyright"] = function()
				nvim_lsp["pyright"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["clangd"] = function()
				nvim_lsp["clangd"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["rust_analyzer"] = function()
				nvim_lsp["rust_analyzer"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true, -- Enable all features in Cargo.toml
							},
							procMacro = {
								enable = true, -- Enable procedural macros
							},
						},
					},
				})
			end,
			["lua_ls"] = function()
				nvim_lsp["lua_ls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["omnisharp"] = function()
				nvim_lsp.omnisharp.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					cmd = {
						vim.fn.expand("~/.local/share/nvim/mason/packages/omnisharp/OmniSharp"),
						"--languageserver",
						"--hostPID",
						tostring(vim.fn.getpid()),
					},
					root_dir = nvim_lsp.util.root_pattern("*.sln", "*.csproj", ".git"),
				})
			end,
		})
	end,
}
