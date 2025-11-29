return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},

	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local nvim_lsp = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local on_attach = function(client, bufnr)
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

		local capabilities = cmp_nvim_lsp.default_capabilities()

		mason.setup()

		mason_lspconfig.setup({
			ensure_installed = {
				"ts_ls",
				"cssls",
				"tailwindcss",
				"html",
				"jsonls",
				"eslint",
				"pyright",
				"clangd",
				"rust_analyzer",
				"lua_ls",
				"omnisharp",
			},
		})

		mason_lspconfig.setup({
			function(server_name)
				nvim_lsp[server_name].setup({
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
							cargo = { allFeatures = true },
							procMacro = { enable = true },
						},
					},
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
