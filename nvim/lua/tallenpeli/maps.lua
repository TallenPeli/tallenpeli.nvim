local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>F", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
