local M = {}

--- Open a folder picker scoped to XDG_CONFIG_HOME, then drill into
--- the chosen folder with a normal Snacks file picker.
function M.pick()
    local config_home = vim.env.XDG_CONFIG_HOME or (vim.env.HOME .. "/.config")

    local raw = vim.fn.systemlist({
        "fd", "--type", "d", "--hidden", "--follow",
        "--exclude", ".git", "--max-depth", "1", ".", config_home,
    })

    local items = {}
    for _, path in ipairs(raw) do
        local name = vim.fs.basename((path:gsub("/$", "")))
        table.insert(items, {
            text = name,
            file = config_home .. "/" .. name,
            dir = true,
            cwd = config_home,
        })
    end

    Snacks.picker.pick({
        source = "config_folders",
        title = "Config Folders",
        items = items,
        format = "file",
        hidden = true,
        confirm = function(picker, item)
            picker:close()
            Snacks.picker.files({ cwd = item.file, hidden = true })
        end,
    })
end

return M
