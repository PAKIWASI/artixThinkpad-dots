-------------------
---- AUTOSTART ----
-------------------

local paths = require('utils.common').paths

hl.on("hyprland.start", function()
    hl.exec_cmd(paths.scripts .. 'random_wall.sh ' .. paths.wallpapers)
    hl.exec_cmd('mako')
    hl.exec_cmd('waybar')
    hl.exec_cmd('wl-paste --type text --watch cliphist store')
    hl.exec_cmd('wl-paste --type image --watch cliphist store')
    hl.exec_cmd('hypridle')
    hl.exec_cmd('brightnessctl set 30%')
end)
