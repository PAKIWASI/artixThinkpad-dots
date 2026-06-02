local M = {}

---@param dir "left" | "right" | "up" | "down"
M.change_scroll_dir = function(dir)
    if not dir then
        error("no direction provided")
    end
    --hl.dispatch("keyword", "scrolling:direction " .. dir)
end

return M
