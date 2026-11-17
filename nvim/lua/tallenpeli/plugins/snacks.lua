local settings = require("tallenpeli.settings").load()

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        image = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = settings.ui.animations },
        statuscolumn = { enabled = true },
        words = { enabled = true },

        -- Allow closing the file viewer with 'ZZ' instead of 'q'
        picker = {
            enabled = true,
            sources = {
                explorer = {
                    win = {
                        list = {
                            keys = {
                                ["Z"] = false,
                                ["ZZ"] = "cancel"
                            }
                        }
                    }
                }
            }
        },
    },
}
