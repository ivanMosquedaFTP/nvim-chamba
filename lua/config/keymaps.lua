-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("n", "<leader>cx", "<cmd>terminal<CR>")
vim.keymap.set("n", "<leader>cx", "<cmd>close<CR>", { desc = "Close tab" })

-- oil.nvim
vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory on floating window" })

-- transparent.nvim
vim.keymap.set("n", "<leader>ut", "<CMD>TransparentToggle<CR>", { desc = "Toggle transparency" })

-- harpoon.nvim
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add to harpoon" })
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon list" })
vim.keymap.set("n", "<leader>p", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
vim.keymap.set("n", "<leader>n", function() harpoon:list():next() end, { desc = "Harpoon next" })

-- deleted useless fucking stupid ass keymap
vim.keymap.del("n", "<leader><leader>")
