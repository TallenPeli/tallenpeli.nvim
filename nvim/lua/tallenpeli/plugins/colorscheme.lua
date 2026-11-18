local settings = require("tallenpeli.settings").load()

return {
    { "Mofiqul/vscode.nvim",      lazy = false, priority = 1000 },
    { "comfysage/evergarden",     lazy = false, priority = 1000 },
    { "Mofiqul/adwaita.nvim",     lazy = false, priority = 1000 },
    { "catppuccin/nvim",          lazy = false, priority = 1000 },
    { "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },
    {
        "tallenpeli/apply-colorscheme",
        virtual = true,
        lazy = false,
        priority = 999,
        config = function()
            local name = settings.ui.colorscheme
            local ok = pcall(vim.cmd.colorscheme, name)
            if not ok then
                vim.notify(
                    ("tallenpeli.nvim: unknown colorscheme '%s', falling back to vscode"):format(name),
                    vim.log.levels.WARN
                )
                vim.cmd.colorscheme("vscode")
            end
        end
    }
}
