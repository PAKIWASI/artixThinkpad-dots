-- Create a function definition using the function declaration in the header file
local M = {}

---@param line string
---@return string|nil
local function get_func_name(line)
    return line:match("^.+%s(.+)%(.+[%);,]$") -- TODO: how to disallow ) then EMPTY: no , or ;
end

---@param line string
---@return boolean
local function not_a_func(line)
    return line:find("[%-%.?/]") ~= nil
end

-- TODO: use treesitter for the entire function select?
-- like if the function declaration is mulitline?
-- and what if user envokes this on a comment containing `()`
-- what if the funciton decl has a comment after it? like ..(..); // ..

function M.create_func_def(bufnr)
    -- only header files containing function decls can call this
    local current = vim.api.nvim_buf_get_name(bufnr)
    local ext = current:match("^.+%.(.+)$")
    if ext ~= "h" and ext ~= "hpp" then
        vim.notify("Not a header file", "warn")
        return
    end

    -- get the lineno where the cursor is placed
    local row = unpack(vim.api.nvim_win_get_cursor(0))
    -- get all the lines from the top till the curr line
    local lines = vim.api.nvim_buf_get_lines(0, 0, row, false)
    if not_a_func(lines[row]) then
        vim.notify("Cursor must be placed on the function decl", "warn")
        return
    end
    -- get the function name
    local func_name = get_func_name(lines[row])
    if not func_name then
        vim.notify("Malformed function decl", "warn")
        return
    end
    vim.notify(func_name)
    -- get all the params
    local params = lines[row]:match("%((.+)%)")
    vim.notify(params)

    -- TODO: is there a better way to do this
    -- store all function names from the top till the curr so we can search the corresponding .c file
    -- to know where to place the function. we try to find the def of the function whose decl is right
    -- above the func_name. if not present, then the one above it and so on
    ---@type string[]
    local func_names_in_order = {}

    for _, line in ipairs(lines) do
        local name = get_func_name(line)
        if name and not not_a_func(line) then
            table.insert(func_names_in_order, name)
            vim.notify(name)
        end
    end

    local switch = require("utils.src_header_switcher").find_corresponding(bufnr)
    if not switch then return end
    vim.cmd("edit " .. switch)

    -- insert the function defintion in the right order

end



return M
