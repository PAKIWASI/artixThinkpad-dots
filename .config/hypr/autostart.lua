-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
    hl.exec_cmd('swaybg -i ' .. require('utils.common').paths.wallpapers .. "dracula_1.jpg" .. ' -m fill')
    hl.exec_cmd('mako')
    hl.exec_cmd('waybar')
    hl.exec_cmd('wl-paste --type text --watch cliphist store')
    hl.exec_cmd('wl-paste --type image --watch cliphist store')
    hl.exec_cmd('hypridle')
    hl.exec_cmd('brightnessctl set 40%')
    hl.exec_cmd('bluetooth off')
end)
