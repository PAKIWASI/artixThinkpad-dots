
local change_workspace_layout = function ()

    local layouts     = { "scrolling", "dwindle", "master" }
    local workspace   = hl.get_active_workspace()
    local next_layout = layouts[1]

    if not workspace then
        return
    end

    for i = 1, #layouts do
        if layouts[i] == workspace.tiled_layout then
            local next_layout_idx = (i % #layouts) + 1
            next_layout = layouts[next_layout_idx]
            break
        end
    end

    hl.exec_cmd("notify-send Layout " .. next_layout)

    hl.workspace_rule({ workspace = workspace.name, layout = next_layout })
end

return change_workspace_layout
