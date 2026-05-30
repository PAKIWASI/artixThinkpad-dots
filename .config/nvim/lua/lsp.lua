

-- blink.cmp merges its own + neovim's default capabilities internally
local capabilities = require("blink.cmp").get_lsp_capabilities()


-- LspAttach fires every time ANY language server attaches to a buffer.
vim.api.nvim_create_autocmd("LspAttach", {

    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(ev)
        -- ev.buf  = the buffer the server attached to
        -- ev.data.client_id = the server that just attached
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
        end

        -- Navigation   -- these overwritten by snacks
        map("gd", vim.lsp.buf.definition, "Go to Definition")
        map("gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("gr", vim.lsp.buf.references, "Go to References")
        map("gi", vim.lsp.buf.implementation, "Go to Implementation")
        map("gy", vim.lsp.buf.type_definition, "Go to Type Definition")

        -- Docs
        map("K", vim.lsp.buf.hover, "Hover Docs")
        -- map("<C-K>", vim.lsp.buf.signature_help, 'Signature Help')
        vim.keymap.set({"n", "i"}, "<C-K>", vim.lsp.buf.signature_help, { desc="Signature Help" })

        -- Refactor
        map("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("<leader>cf", vim.lsp.buf.format, "Format Buffer")

        -- Diagnostics
        map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
        map("<leader>cj", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next Diagnostic")
        map("<leader>ck", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev Diagnostic")
        map("]e", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end,
            "Next Error")
        map("[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end,
            "Prev Error")
        map("]w", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN }) end,
            "Next Warning")
        map("[w", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN }) end,
            "Prev Warning")

        -- Highlight symbol under cursor
        if client and client:supports_method("textDocument/documentHighlight") then
            local highlight_group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
            vim.api.nvim_clear_autocmds({ buffer = ev.buf, group = highlight_group })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = ev.buf,
                group = highlight_group,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                buffer = ev.buf,
                group = highlight_group,
                callback = vim.lsp.buf.clear_references,
            })
        end

        -- disable formatting for servers you don't want formatting from.
        -- if client and client.name == "lua_ls" then
        --     client.server_capabilities.documentFormattingProvider = false
        -- end
    end,
})



local servers = {
    "clangd",
    "ts_ls",
    "lua_ls",
}


for _, name in ipairs(servers) do
    -- reads your lsp/<name>.lua and merges capabilities into it
    local ok, user_config = pcall(require, "lsp." .. name)
    local config = ok and user_config or {}
    config.capabilities = capabilities

    vim.lsp.config(name, config)
    vim.lsp.enable(name)
end


-- diagnostic ui config
vim.diagnostic.config({
    virtual_text = {
        prefix = function(diagnostic)
            local icons = {
                [vim.diagnostic.severity.ERROR] = "✘",
                [vim.diagnostic.severity.WARN]  = "●",
                [vim.diagnostic.severity.HINT]  = "⚑",
                [vim.diagnostic.severity.INFO]  = "»",
            }
            return icons[diagnostic.severity] or "●"
        end,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "if_many",
    },
})


