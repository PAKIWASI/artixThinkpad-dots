
require("lualine").setup({
    options = {
        disabled_filetypes   = {
            statusline = {
                "snacks_dashboard",
                "oil",
                "dap-repl",
                "dapui_scopes",
                "dapui_breakpoints",
                "dapui_stacks",
                "dapui_watches",
                "dapui_console",
            },
            winbar = {
                "snacks_dashboard",
                "oil",
                "dap-repl",
                "dapui_scopes",
                "dapui_breakpoints",
                "dapui_stacks",
                "dapui_watches",
                "dapui_console",
            },
        },
        theme                = "auto",
        component_separators = { left = "", right = "" },
        section_separators   = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 }
        },
        lualine_b = {
            "branch",
            {
                'diff',
                symbols = { added = ' ', modified = ' ', removed = ' ' },
                colored = true,
            },
        },
        lualine_c = {
            "filetype",
            {
                "filename",
                path = 1, -- relative
                symbols = {
                    modified = "[]",
                    readonly = "[]",
                    unnamed = "[No Name]"
                }
            },
        },
        lualine_x = {
            require("utils.macro_recording"),
            {
                'diagnostics',
                sources = { 'nvim_diagnostic' },         -- modern source
                symbols = {
                    error = ' ',
                    warn  = ' ',
                    info  = ' ',
                    hint  = ' ',
                },
                colored = true,
                update_in_insert = false,
                separator = { left = '' },
                left_padding = 2,
            },
        },
        lualine_y = {
            { "progress" },
            { "location", left_padding = 1 },
        },
        lualine_z = {
            {
                'datetime',
                style = '%I:%M %p',
                separator = { right = '' },
                left_padding = 1
            },
        },
    },
    inactive_sections = {
        lualine_c = { "searchcount" },
    },
})


