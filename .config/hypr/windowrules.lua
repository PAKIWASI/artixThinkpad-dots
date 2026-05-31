--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------



-- TODO: 
-- layer rule to blur everything else when fuzzel window is opened



hl.window_rule({ match = { class =  "^(zen|zen-browser)$" }, idle_inhibit = "focus"})
hl.window_rule({ match = { class =  "^([Ss]potify)$" }, idle_inhibit = "focus"})
hl.window_rule({ match = { class =  "^(mpv)$" }, idle_inhibit = "focus"})


-- all picture in picture mini windows
hl.window_rule( {
    name    = "pip windows",
    match   = { title = "^((?i)picture[-\\s]?in[-\\s]?picture.*)$"},
    float   = true,
    pin     = true,
    move    = { "(monitor_w*.73)", "(monitor_h*.72)" },
    size    = { "(monitor_w*.25)", "(monitor_h*.25)" }
})



-- browser opens file picker etc
hl.window_rule({
    name    = "xdg desktop portal windows",
    match   = { class = "xdg-desktop-portal-gtk" },
    float   = true,
    center  = true,
    size    = { "(monitor_w*0.5)", "(monitor_h*0.7)" }
})

hl.window_rule({
    -- Ignore maximize requests from all apps
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
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



-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
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
