

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        -- "clangd",    -- clangd not managed via mason
        "ts_ls",
    },
    automatic_installation = true,
})
