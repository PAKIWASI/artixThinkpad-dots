
vim.g.lavender = {
    ------------------------------------------------------------------
    -- Transparency controls
    ------------------------------------------------------------------
    transparent = {
        background = false,         -- main editor background
        float      = true,          -- floating windows (:LspInfo, hover, etc.)
        popup      = true,          -- popup menus (completion)
        sidebar    = true,          -- sidebars (NvimTree, Oil, etc.)
    },

    ------------------------------------------------------------------
    -- Contrast handling
    -- If true: sidebars & floats use a slightly different bg
    ------------------------------------------------------------------
    contrast = true,

    ------------------------------------------------------------------
    -- Italic styling
    ------------------------------------------------------------------
    italic = {
        comments  = true,
        functions = true,
        keywords  = false,
        variables = false,
    },

    ------------------------------------------------------------------
    -- Diagnostic signs
    -- Uses patched fonts (Nerd Font icons)
    ------------------------------------------------------------------
    signs = false,

    ------------------------------------------------------------------
    -- Overrides
    -- WARNING:
    --  • Overriding an existing highlight group replaces it ENTIRELY
    --  • Colors added here can be reused anywhere below
    ------------------------------------------------------------------
    overrides = {
        --------------------------------------------------------------
        -- Highlight group overrides / additions
        -- See: lua/lavender/theme.lua in the repo
        --------------------------------------------------------------
        theme = {
            -- Example: override an existing group
            -- Normal = {
            --     fg = "white",
            --     bg = "bg_alt",
            --     ctermfg = "white",
            --     ctermbg = "bg_alt",
            -- },

            -- Example: add a brand-new group
            -- NormalFoo = {
            --     fg = "fg",
            --     bg = "purple3",
            --     bold = true,
            -- },

            -- Example: mix lavender colors + raw values
            -- NormalBar = {
            --     fg = "Red",        -- nvim built-in color
            --     bg = "#303030",    -- raw hex
            --     ctermfg = 196,
            --     ctermbg = 236,
            -- },



            -- FIX for highlight too light
            -- Make cursor line clearly visible

            -- LSP reference highlights
            LspReferenceText  = { bg = "purple4" },
            LspReferenceRead  = { bg = "purple4" },
            LspReferenceWrite = { bg = "purple4", bold = true },

            -- Treesitter keyword under cursor
            ["@keyword"]      = {
                fg = "purple1",
                bold = true,
            },
        },

        --------------------------------------------------------------
        -- Color overrides / additions
        --------------------------------------------------------------
        colors = {
            -- True color (GUI / terminal with RGB)
            hex = {
                -- custom_red = "#ff3300",
                -- custom_bg  = "#101018",
            },

            -- 256-color terminals
            cterm = {
                -- custom_blue = 33,
            },
        },
    },
}

vim.cmd("colorscheme lavender")

