local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- The config root. This is ~/.config/nvim for a normal install, but it can be
-- a Nix store path when this config is installed as a package.
local config_root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:h:h")

-- Setup lazy.nvim
require("lazy").setup("tallenpeli.plugins", {
    lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
    -- lazy.nvim resets the runtimepath by default. Keep this config's root on
    -- it so `require("tallenpeli...")` works when the config is not in
    -- stdpath("config") (for example, a Nix store path).
    performance = {
        rtp = {
            paths = { config_root },
        },
    },
})
