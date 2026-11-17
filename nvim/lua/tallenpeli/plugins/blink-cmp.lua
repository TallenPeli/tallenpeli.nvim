return {
    "saghen/blink.cmp",
    dependencies = {
        "saghen/blink.lib",
        "rafamadriz/friendly-snippets",
    },
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = "enter" },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        fuzzy = { implementation = "rust" },

        -- cmdline config to automatically show
        cmdline = {
            keymap = {
                ['<Tab>'] = { 'show', 'accept' },
            },
            completion = { menu = { auto_show = true } }
        },
    },
}
