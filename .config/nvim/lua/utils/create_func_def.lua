-- Create a function definition using the function declaration in the header file
local M = {}


-- TODO: use treesitter for the entire function select?

function M.create_func_def(bufnr)
    -- only header files containing function decls can call this
    local current = vim.api.nvim_buf_get_name(bufnr)
    local ext = current:match("^.+%.(.+)$")
    if ext ~= "h" and ext ~= "hpp" then
        vim.notify("Not a header file", "warn")
        return
    end

    -- find the function name. Cursor must be placed on the function decl line
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
    vim.notify(line)
    local start = line:find("(")
    vim.notify(start)

    -- start from the top and read each function name until you find the one
    ---@type string[]
    local func_names_in_order = {}


    local switch = require("utils.src_header_switcher").find_corresponding(bufnr)
    if ~switch then return end
    vim.cmd("edit " .. switch)

    -- insert the function defintion in the right order


end

return M
