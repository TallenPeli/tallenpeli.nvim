vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.termguicolors = false

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.syntax = "on"
<<<<<<< HEAD
vim.opt.clipboard = "unnamedplus"
=======
<<<<<<< HEAD
vim.opt.clipboard = "unnamedplus"

if vim.fn.executable("wl-copy") == 1 then
	vim.g.clipboard = {
		name = "wl-clipboard",
		copy = {
			["+"] = "wl-copy",
			["*"] = "wl-copy",
		},
		paste = {
			["+"] = "wl-paste --no-newline",
			["*"] = "wl-paste --no-newline",
		},
		cache_enabled = 0,
	}
end
=======
-- Uncomment this is you want to have 'y' 'd' 'x' 'p' all copy and paste to system clipboard instead of the vim buffer.
-- vim.opt.clipboard = "unnamedplus"
>>>>>>> 8d44679cff336950fabe07620398afe37ceb04d5

if vim.fn.executable("wl-copy") == 1 then
	vim.g.clipboard = {
		name = "wl-clipboard",
		copy = {
			["+"] = "wl-copy",
			["*"] = "wl-copy",
		},
		paste = {
			["+"] = "wl-paste --no-newline",
			["*"] = "wl-paste --no-newline",
		},
		cache_enabled = 0,
	}
end
<<<<<<< HEAD
=======
]]
--
>>>>>>> 33935393b7f45202c46dc008eda56b8e74595332
>>>>>>> 8d44679cff336950fabe07620398afe37ceb04d5

vim.g.mapleader = "t"
