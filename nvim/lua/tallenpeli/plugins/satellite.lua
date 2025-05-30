return {
    "lewis6991/satellite.nvim",
    config = function()
        require("satellite").setup({
            current_only = false,                             -- Show marks for all buffers
            winblend = 50,                                    -- Transparency level
            zindex = 40,                                      -- Z-index to avoid overlap
            excluded_filetypes = { "dashboard", "alpha", "NvimTree" }, -- Ignore specific filetypes
            handlers = {
                search = {},                                  -- Enable search highlights
                gitsigns = {},                                -- Enable Git changes in scrollbar
                marks = {},                                   -- Enable marks in scrollbar
                diagnostics = {},                             -- Enable diagnostics in scrollbar
            },
        })
    end,
}
