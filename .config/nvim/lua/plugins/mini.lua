

require("mini.pairs").setup({
    modes = { insert = true, command = true, terminal = false },
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    skip_ts = { "string" },
    skip_unbalanced = true,
    markdown = true,
})


require("mini.move").setup({})


require("mini.surround").setup({
    mappings = {
        add = "gsa",
        delete = "gsd",
        replace = "gsr",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        update_n_lines = "gsn",
    },
})

--[[
    gsaiw"     → surround inner word with "
    gsaiw)     → surround inner word with ()  ← adds no spaces
    gsaiw(     → surround inner word with ( ) ← adds spaces inside
    gsa visual "  → surround selection with "
    gsd"       → delete surrounding "
    gsr"'      → replace " with '
    gsr({ →    → replace () with {}
]]
