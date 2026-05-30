local map = vim.keymap.set;
local s = { silent = true }
-- local opts = { noremap = true, silent = true }


-- unset spacebar
map({ "n", "v" }, "<Space>", "<Nop>", s)
-- leader key (spacebar)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- save with C-s
map({ 'n', 'v', 'i' }, '<C-s>', function()
        if vim.bo.modified then
            vim.cmd("noautocmd write")
        end
    end,
    { desc = 'Write Changes' }
)


-- force quit
map({ 'n', 'v' }, '<leader>qq', function() vim.cmd("q!") end, { desc = 'Force Quit' })

-- Change directory to the current file's directory
map("n", "<leader>bcd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')

-- split navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- clear search highlight
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Stay in visual mode after indenting
map('v', '<', '<gv', { desc = 'Indent left and reselect' })
map('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Paste without overwriting the default register
map("v", "<leader>p", '"_dP')




