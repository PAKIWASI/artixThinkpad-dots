
---@type vim.lsp.Config
local config = {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
                nilness = true,
                unusedwrite = true,
            },
            staticcheck = true,
            usePlaceholders = true,
            completeUnimported = true,
            matcher = "Fuzzy",
            semanticTokens = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
}

local function organize_imports(bufnr)
    local params = vim.lsp.util.make_range_params(nil, "utf-8")
    params.context = { only = { "source.organizeImports" } }

    local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
    if not result then return end

    for _, res in pairs(result) do
        for _, action in pairs(res.result or {}) do
            if action.edit then
                vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
            elseif action.command then
                local client = vim.lsp.get_client_by_id(res.client_id)
                if client then
                    client:exec_cmd(action.command, { bufnr = bufnr })
                end
            end
        end
    end
end

-- walks upward from the cursor to find the nearest `func TestXxx(...)`
local function nearest_go_test()
    local view = vim.fn.winsaveview()
    local found = vim.fn.search([[^func\s\+\(Test\|Benchmark\|Fuzz\)\w*\s*(]], "bcnW")
    local name = nil
    if found > 0 then
        local line = vim.fn.getline(found)
        name = line:match("func%s+(%a[%w_]*)%s*%(")
    end
    vim.fn.winrestview(view)
    return name
end

vim.api.nvim_create_autocmd("LspAttach", {
    pattern = { "*.go" },
    group = vim.api.nvim_create_augroup("GoAttach", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client or client.name ~= "gopls" then return end

        local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end

        local float = require("utils.win").float

        -- format + organize imports on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = ev.buf,
            group = vim.api.nvim_create_augroup("GoFormatOnSave", { clear = false }),
            callback = function()
                organize_imports(ev.buf)
                vim.lsp.buf.format({ bufnr = ev.buf, async = false })
            end,
        })

        map("<leader>ci", function() organize_imports(ev.buf) end, "Organize Imports")

        map("<leader>cx", function()
            Snacks.terminal("go run .; exec $SHELL", { win = float })
        end, "Run Project")

        map("<leader>cX", function()
            vim.ui.input({ prompt = "Args: " }, function(input)
                Snacks.terminal("go run . " .. (input or "") .. "; exec $SHELL", { win = float })
            end)
        end, "Run Project (with Args)")

        map("<leader>cb", function()
            Snacks.terminal("go build ./...; exec $SHELL", { win = float })
        end, "Build Project")

        map("<leader>ct", function()
            Snacks.terminal("go test ./... -v; exec $SHELL", { win = float })
        end, "Test Package")

        map("<leader>cT", function()
            local name = nearest_go_test()
            if not name then
                vim.notify("No enclosing Test/Benchmark/Fuzz function found", vim.log.levels.WARN)
                return
            end
            Snacks.terminal("go test -run '^" .. name .. "$' -v ./...; exec $SHELL", { win = float })
        end, "Test Nearest Function")

        map("<leader>cg", function()
            Snacks.terminal("go generate ./...; exec $SHELL", { win = float })
        end, "Go Generate")

        map("<leader>cm", function()
            Snacks.terminal("go mod tidy; exec $SHELL", { win = float })
        end, "Go Mod Tidy")
    end,
})

return config
