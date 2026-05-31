-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
    hl.exec_cmd('mako')
    hl.exec_cmd('waybar')
    hl.exec_cmd('brightnessctl set 40%')
    -- TODO: not setting, even though brighness is set to 50%, maybe defer it to later?
    hl.exec_cmd('bluetooth off')
    -- hl.dsp.exec_cmd('bluetooth off')
    hl.exec_cmd('wl-paste --type text --watch cliphist store')
    hl.exec_cmd('wl-paste --type image --watch cliphist store')
    hl.exec_cmd('hypridle')
end)
