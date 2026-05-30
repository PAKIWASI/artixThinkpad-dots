

require("bufferline").setup({
    options = {
        diagnostics              = "nvim_lsp",
        show_close_icon          = false,
        show_buffer_close_icons  = false,
        always_show_bufferline   = false,
        separator_style          = "slope",
        offsets = {
            { filetype = "oil", text = "Oil", highlight = "Directory", text_align = "left", separator = true },
        },
    },
})

local map = vim.keymap.set
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>",  { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>",  { desc = "Next Buffer" })
map("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Close Buffers Right" })
map("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>",  { desc = "Close Buffers Left" })
map("n", "[b", "<cmd>BufferLineMovePrev<cr>", { desc = "Move Buffer Prev" })
map("n", "]b", "<cmd>BufferLineMoveNext<cr>", { desc = "Move Buffer Next" })
