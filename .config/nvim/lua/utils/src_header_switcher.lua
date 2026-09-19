-- Utility for Clangd switching src/header files
-- If clangd fails, we switch manually, using project structure


local M = {}



-- returns the corresponding file (.h -> .c or .c -> .h etc)
function M.find_corresponding(bufnr)
    local extensions = {
        c   = { "h" },
        h   = { "c" },
        cpp = { "hpp", "h" },
        hpp = { "cpp", "cc", "cxx" },
        cc  = { "hpp", "h" },
        cxx = { "hpp", "h" },
    }

    local current = vim.api.nvim_buf_get_name(bufnr)
    local ext = current:match("^.+%.(.+)$")
    local targets = extensions[ext]

    if not targets then
        vim.notify("No known pair for: " .. ext, vim.log.levels.WARN)
        return false
    end

    local root = require("utils.root").get(bufnr)
    local base = current:match("^.+/(.+)%..+$")

    for _, target_ext in ipairs(targets) do
        for _, dir in ipairs({ "include", "src", "." }) do
            local candidate = root .. "/" .. dir .. "/" .. base .. "." .. target_ext
            if vim.fn.filereadable(candidate) == 1 then
                -- vim.cmd("edit " .. candidate)
                -- return
                return candidate
            end
        end
    end

    vim.notify("No corresponding file found for: " .. base, vim.log.levels.WARN)
end

-- check if we can get LSP switch, if not do manual
function M.switcher(bufnr)
    local client = vim.lsp.get_clients({ bufnr = 0, name = "clangd" })[1]
    if not client then
        local found = M.find_corresponding(bufnr)
        if found then
            vim.cmd("edit " .. found)
        end
        return
    end

    -- TODO:
    client:request("textDocument/switchSourceHeader" --[[@as any]],
        vim.lsp.util.make_text_document_params(),
        function(err, result)
            if err or not result or result == "" then
                local found = M.find_corresponding(bufnr)
                if found then
                    vim.cmd("edit " .. found)
                end
            else
                vim.cmd("edit " .. vim.uri_to_fname(result))
            end
        end, 0)
end

return M
