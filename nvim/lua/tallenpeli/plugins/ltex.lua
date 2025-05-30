return {
    "vigoux/ltex-ls.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
        require("ltex-ls").setup({
            on_attach = function(client, bufnr) end,
            use_spellfile = false,
            capabilities = capabilities,
            settings = {
                ltex = {
                    enabled = { "latex", "tex", "bib", "markdown" },
                    language = "en-US",
                    checkFrequency = "save",
                    additionalRules = {
                        enablePickyRules = true,
                        motherTongue = "en-US",
                    },
                },
            },
        })
    end,
    ft = { "tex", "latex", "markdown", "text" },
}
