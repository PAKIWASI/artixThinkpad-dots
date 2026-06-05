---------------------
---- KEYBINDINGS ----
---------------------

local mainMod   = "SUPER"


local apps  = require('utils.common').default_apps
local paths = require('utils.common').paths


-- apps
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(apps.terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(apps.fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(apps.browser))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(apps.menu))

-- lock/logout
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(apps.lock))
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.exit()'"))

-- windows
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + N", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + O", hl.dsp.layout("togglesplit"))    -- dwindle only


-- TODO: add keybind for prev and next wallpaper as well
-- wallpaper
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(paths.scripts .. 'random_wall.sh ' .. paths.wallpapers))

-- screenshot
hl.bind(mainMod .. " + P",          hl.dsp.exec_cmd("bash " .. paths.scripts .. 'screenshot.sh' .. " region"))
hl.bind(mainMod .. " + SHIFT + P",  hl.dsp.exec_cmd("bash " .. paths.scripts .. 'screenshot.sh' .. " window"))
hl.bind(mainMod .. " + CTRL + P",   hl.dsp.exec_cmd("bash " .. paths.scripts .. 'screenshot.sh' .. " output"))


-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L",  hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",  hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,            hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,    hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Scroll through existing workspaces with h and l for left and right
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + L ",   hl.dsp.focus({ workspace = "e+1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Swap windows (dwindle/master/scrolling)
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.swap({ direction = "left"}))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.swap({ direction = "right"}))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.swap({ direction = "up"}))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.swap({ direction = "down"}))

-- Change the layout for the current workspace
hl.bind(mainMod .. " + tab", require('utils.change_workspace_layout'))

-- zoom focused on cursor
local zoom = require('utils.zoom')
hl.bind(mainMod .. " + Equal", function() zoom.set(0.5) end)
hl.bind(mainMod .. " + Minus", function() zoom.set(-0.5) end)
hl.bind(mainMod .. " + SHIFT + Equal", function() zoom.reset() end)

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
-- TODO: i have this printscreen button on my thinkpad, how to map that?

-- playerctl -- My laptop doesnot have these
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


