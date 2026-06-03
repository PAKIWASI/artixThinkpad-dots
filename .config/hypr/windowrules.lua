--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local default_size      = { "(monitor_w*.50)", "(monitor_h*.75)" }
local default_move_pip  = { "(monitor_w*.74)", "(monitor_h*.735)" }
local default_size_pip  = { "(monitor_w*.25)", "(monitor_h*.25)" }




-- all picture in picture mini windows (spotify popupLyrics, youtube pip)
hl.window_rule({
    name    = "pip windows",
    match   = { title = "^((?i)picture[-\\s]?in[-\\s]?picture.*)$"},
    float   = true,
    pin     = true,
    move    = default_move_pip,
    size    = default_size_pip
})


-- spotify pip window not updating/syncing issue fix

-- register rule to keep rendering spotify
local spotifyPipRule = hl.window_rule({
    name             = "spotify-pip-render",
    match            = { class = "^([Ss]potify)$" },
    render_unfocused = true,
})

-- disable the rule at startup so it's not always active
spotifyPipRule:set_enabled(false)

-- when we actually need it
hl.on("window.open", function(w)
    if w.title == "Picture in picture" then
        spotifyPipRule:set_enabled(true)
    end
end)

-- turn it off again
hl.on("window.close", function(w)
    if w.title == "Picture in picture" then
        spotifyPipRule:set_enabled(false)
    end
end)



hl.window_rule({
    name  = "pip windows chromium",
    match = { class = "chromium-browser" },
    float = true,
    pin   = true,
    move  = default_move_pip,
    size  = default_size_pip
})



hl.window_rule({
    name    = "pavucontrol",
    match   = { class = "^(.*pulseaudio.*)$" },
    float   = true,
    center  = true,
    size    = default_size
})


-- browser opens file picker etc
hl.window_rule({
    name    = "xdg desktop portal windows",
    match   = { class = "xdg-desktop-portal-gtk" },
    float   = true,
    center  = true,
    size    = default_size
})

-- thunar popups
hl.window_rule({
    name    = "thunar popups",
    match   = {
        title = "^(.*([Rr]ename|[Pr]references).*)$",
        class = "^([Tt]hunar)$"
    },
    float   = true,
    center  = true,
    size    = default_size
})


-- Ignore maximize requests from all apps
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})


-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})


-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})


-- layer rule to blur everything else when fuzzel window is opened
hl.layer_rule({
    match = { namespace = "launcher" },
    blur = true,
    dim_around = true,
    ignore_alpha = 0.5,
})



-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({
    workspace = "10",
    layout = "dwindle"
})
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
