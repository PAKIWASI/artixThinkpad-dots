require("markview").setup({

    markdown = {
        enable = true,
    },

    markdown_inline = {
        enable = true,
    },

    preview = {
        filetypes = { "markdown" },
        max_buf_lines = 100,

    },

    yaml = {
        enable = true,
    },

    html = {
        enable = false,
    },
    latex = {
        enable = false,
    },
    typst = {
        enable = false,
    },
})

-- Keymaps scoped to buffers markview has actually attached to.
-- markview fires `MarkviewAttach` / `MarkviewDetach` User autocmds,
-- so we hook those directly instead of guessing via FileType.
vim.api.nvim_create_autocmd("User", {
    pattern = "MarkviewAttach",
    callback = function(event)
        local buf = event.data.buffer
        local opts = { buffer = buf, silent = true }

        vim.keymap.set("n", "<leader>mm", "<CMD>Markview<CR>",
            vim.tbl_extend("force", opts, { desc = "Toggles `markview` previews." }))

        vim.keymap.set("n", "<leader>mh", "<CMD>Markview hybridToggle<CR>",
            vim.tbl_extend("force", opts, { desc = "Toggles `hybrid mode` (raw text at cursor)." }))

        vim.keymap.set("n", "<leader>ml", "<CMD>Markview linewiseToggle<CR>",
            vim.tbl_extend("force", opts, { desc = "Toggles `line-wise` hybrid mode." }))

        vim.keymap.set("n", "<leader>mv", "<CMD>Markview splitToggle<CR>",
            vim.tbl_extend("force", opts, { desc = "Toggles `splitview` for buffer." }))
    end,
})

-- Clean up keymaps when markview detaches (buffer closed, ignored, etc.)
vim.api.nvim_create_autocmd("User", {
    pattern = "MarkviewDetach",
    callback = function(event)
        local buf = event.data.buffer
        pcall(vim.keymap.del, "n", "<leader>mm", { buffer = buf })
        pcall(vim.keymap.del, "n", "<leader>mh", { buffer = buf })
        pcall(vim.keymap.del, "n", "<leader>ml", { buffer = buf })
        pcall(vim.keymap.del, "n", "<leader>mv", { buffer = buf })
    end,
})
