
require("which-key").setup({
    preset  = "helix",
    defaults = {},
    spec = {
        {
            mode = { "n", "v" },
            { "<leader>c", group = "code" },
            { "<leader>d", group = "debug" },
            { "<leader>f", group = "file/find" },
            { "<leader>g", group = "git" },
            { "<leader>o", group = "oil" },
            { "<leader>s", group = "search" },
            { "<leader>u", group = "ui" },
            { "<leader>d", group = "debug" },
            { "<leader>x", group = "diagnostics/quickfix" },
            { "<leader>q", group = "quit/session" },
            { "[",         group = "prev" },
            { "]",         group = "next" },
            { "g",         group = "goto" },
            { "z",         group = "fold" },
            {
                "<leader>b",
                group = "buffer",
                expand = function() return require("which-key.extras").expand.buf() end,
            },
            {
                "<leader>w",
                group = "windows",
                proxy = "<c-w>",
                expand = function() return require("which-key.extras").expand.win() end,
            },
        },
    },
})

vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
end, { desc = "Buffer Keymaps (which-key)" })

vim.keymap.set("n", "<c-w><space>", function()
    require("which-key").show({ keys = "<c-w>", loop = true })
end, { desc = "Window Hydra Mode (which-key)" })

