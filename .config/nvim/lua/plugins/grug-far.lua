
-- require("grug-far").setup({ headerMaxWidth = 80 })

vim.keymap.set({ "n", "x" }, "<leader>sr", function()
    -- lazy load grug-far for this keymap
    local grug = require("grug-far")
    grug.setup({ headerMaxWidth = 80 })
    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
    grug.open({
        transient = true,
        prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
        },
    })
end, { desc = "Search and Replace" })
