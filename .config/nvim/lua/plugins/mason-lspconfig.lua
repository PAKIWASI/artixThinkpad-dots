

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "ts_ls",
        "gopls",
    },
    automatic_installation = true,
})
