vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.grm",
    callback = function()
        vim.bo.filetype = "grammar_notation"
    end,
})
