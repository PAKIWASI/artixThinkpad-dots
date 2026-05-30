
-- macro icon for lualine

local M = {

    function()
        local reg = vim.fn.reg_recording()
        if reg == "" then
            return ""
        end
        return " @" .. reg
    end,

    color = function()
        -- active recording → red
        if vim.fn.reg_recording() ~= "" then
            return { fg = "#f38ba8", gui = "bold" } -- Catppuccin red
        end
        return {}
    end,
}


return M
