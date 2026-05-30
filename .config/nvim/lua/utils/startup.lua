
local M = {}

M.start = 0  -- set from init.lua

function M.get()
    return (vim.loop.hrtime() - M.start) / 1e6
end

function M.format()
    return string.format("\t\t\t\t\t    Startup: %.2f ms", M.get())
end

return M
