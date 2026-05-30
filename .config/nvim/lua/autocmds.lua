
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup


-- Highlight yanked text
local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.hl.on_yank({ timeout = 170 })
    end,
    group = highlight_group,
})


-- Show cmdline when entering command mode
autocmd("CmdlineEnter", {
    callback = function()
        vim.o.cmdheight = 1
    end,
    desc = "Show command line on command mode",
})
-- Hide cmdline when leaving command mode
autocmd("CmdlineLeave", {
    callback = function()
        vim.o.cmdheight = 0
    end,
    desc = "Hide command line after command mode",
})


-- .h files were set to cpp by default
autocmd('BufEnter', {
    pattern = '*.h',
    command = "setfiletype c",
})


