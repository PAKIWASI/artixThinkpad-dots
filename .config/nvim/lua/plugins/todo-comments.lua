require("todo-comments").setup({})

local map = vim.keymap.set
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next Todo Comment" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous Todo Comment" })

map("n", "<leader>st", function() Snacks.picker.todo_comments() end, { desc = "Todo" })
map("n", "<leader>sT", function()
        Snacks.picker.todo_comments({
            keywords = { "TODO", "FIX", "FIXME", "BUG", "NOTE", "WARN", "WARNING", "TEST" }
        })
    end,
    { desc = "Todo/Fix/Fixme" }
)
