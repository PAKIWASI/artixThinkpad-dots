-- require("flash").setup({})

local map = vim.keymap.set

map({ "n", "x", "o" }, "S",     function() require("flash").jump()              end, { desc = "Flash" })
map({ "n", "o", "x" }, "<A-s>", function() require("flash").treesitter()        end, { desc = "Flash Treesitter" })
-- map({ "o", "x" },      "R",     function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
-- map("o",               "r",     function() require("flash").remote()            end, { desc = "Remote Flash" })
-- map("c",               "<A-s>", function() require("flash").toggle()            end, { desc = "Toggle Flash Search" })


-- Show diagnostics at target, without changing cursor position
map("n", "<leader>cD", function()
    require("flash").jump({
        matcher = function(win)
            return vim.tbl_map(function(diag)
                return {
                    pos = { diag.lnum + 1, diag.col },
                    end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
                }
                ---@diagnostic disable-next-line
            end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
        end,
        action = function(match, state)
            vim.api.nvim_win_call(match.win, function()
                vim.api.nvim_win_set_cursor(match.win, match.pos)
                vim.diagnostic.open_float()
            end)
            state:restore()
        end,
    })
end, { desc = "Flash Diagnostic" })


-- Treesitter incremental search
vim.keymap.set({ "n", "x", "o" }, "<c-space>", function()
    require("flash").treesitter({
        actions = {
            ["<c-space>"] = "next",
            ["<BS>"] = "prev"
        }
    })
end, { desc = "Treesitter incremental selection" })




