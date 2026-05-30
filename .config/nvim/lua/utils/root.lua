
-- util to find root of a project iNTELIGENTLY. Prefers LSP, then patterns

local M = {}

-- Root markers 
local root_patterns = {
    -- directories
    "src",
    "build",
    -- C / C++
    "CMakeLists.txt",
    "compile_commands.json",
    -- JS / TS
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
    -- Python
    "pyproject.toml",
    "setup.py",
    -- Generic
    ".git",
}

function M.get(bufnr)
    bufnr = bufnr or 0

    -- 1. LSP root
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    for _, client in ipairs(clients) do
        if client.config.root_dir then
            return client.config.root_dir
        end
    end

    -- 2. Find root by patterns
    local path = vim.api.nvim_buf_get_name(bufnr)
    if path == "" then
        path = vim.uv.cwd() or vim.loop.cwd()
    end

    local found = vim.fs.find(root_patterns, {
        path = path,
        upward = true,
        stop = vim.uv.os_homedir() or vim.loop.os_homedir(),
    })[1]

    if found then
        return vim.fs.dirname(found)
    end

    -- 3. Fallback to cwd
    return vim.uv.cwd() or vim.loop.cwd()
end

return M


