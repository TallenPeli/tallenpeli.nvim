local wk = require("which-key")

-- Switched to which-key to manage keymaps
wk.add({
    -- Search Group
    {
        { "<leader>f",  group = "Search" },
        { "<leader>ff", function() Snacks.picker.files() end,        desc = "Search: Filename",        mode = "n" },
        { "<leader>fl", function() Snacks.picker.lsp_symbols() end,  desc = "Search: LSP Symbols",     mode = "n" },
        { "<leader>fg", function() Snacks.picker.grep() end,         desc = "Search: File Contents",   mode = "n" },
        { "<leader>fb", function() Snacks.picker.grep_buffers() end, desc = "Search: Buffer Contents", mode = "n" },
        { "<leader>fG", function() Snacks.picker.git_log() end,      desc = "Search: Git Logs",        mode = "n" },
    },

    -- Snacks Explorer (sidebar)
    { "<leader>s", function() Snacks.explorer() end,                          desc = "Sidebar: Toggle",                mode = "n" },

    -- Editor binds
    { "<leader>e", vim.diagnostic.open_float,                                 desc = "Show line diagnostics",          mode = "n" },

    -- Config settings menu
    { "<leader>S", function() require("tallenpeli.settings").open_menu() end, desc = "tallenpeli.nvim: Open Settings", mode = "n" },

    -- Depricated
    {
        { "<leader>F", function() Snacks.picker.files() end,        desc = "[Depricated]: Find Files",        mode = "n" },
        { "<leader>g", function() Snacks.picker.grep() end,         desc = "[Depricated]: Live Grep",         mode = "n" },
        { "<leader>b", function() Snacks.picker.grep_buffers() end, desc = "[Depricated]: Live Grep Buffers", mode = "n" },
    }
})
