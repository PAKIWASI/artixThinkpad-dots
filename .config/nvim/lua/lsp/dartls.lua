
---@type vim.lsp.Config
local config = {
    cmd = { "dart", "language-server", "--protocol=lsp" },
    filetypes = { "dart" },
    root_markers = { "pubspec.yaml" },
    init_options = {
        onlyAnalyzeProjectsWithOpenFiles = true,
        suggestFromUnimportedLibraries = true,
        closingLabels = true,
        outline = true,
        flutterOutline = true,
    },
    settings = {
        dart = {
            completeFunctionCalls = true,
            showTodos = true,
            renameFilesWithClasses = "prompt",
        },
    },
}

vim.api.nvim_create_autocmd("LspAttach", {
    pattern = { "*.dart" },
    group = vim.api.nvim_create_augroup("DartAttach", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client or client.name ~= "dartls" then return end

        local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end

        local float = require("utils.win").float

        map("<leader>cR", function()
            Snacks.terminal("flutter run", { win = float })
        end, "Flutter Run")

        map("<leader>cT", function()
            Snacks.terminal("flutter test", { win = float })
        end, "Flutter Test")

        map("<leader>cC", function()
            Snacks.terminal("flutter clean", { win = float })
        end, "Flutter Clean")
    end,
})

return config
