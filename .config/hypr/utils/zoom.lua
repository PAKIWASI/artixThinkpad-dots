
local M = {}


local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5

---@param offset number
---@return nil
M.set = function (offset)
    local config = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        config = config + offset
    elseif config ~= MIN_ZOOM then
        config = MIN_ZOOM
    else
        config = ZOOM_TOGGLE_FACTOR
    end
    config = math.max(MIN_ZOOM, math.min(MAX_ZOOM, config))
    hl.config({ cursor = { zoom_factor = config } })
end

M.reset = function ()
    hl.config({ cursor = { zoom_factor = 0 } })
end

return M
