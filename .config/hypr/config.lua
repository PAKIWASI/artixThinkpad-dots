-----------------------
---- LOOK AND FEEL ----
-----------------------

local c = require('utils.colors')

hl.config({

    xwayland = {
        enabled = false,
    },

    general = {
        gaps_in  = 2,
        gaps_out = 8,
        border_size = 1,

        col = {
            active_border   = { colors = { c.accent, c.main .. "ee" }, angle = 45 },
            inactive_border = { colors = { c.green .. "aa", c.cyan .. "aa"}, angle = 45 },
        },

        resize_on_border = true,
        allow_tearing    = false,

        layout = "scrolling",
    },


    decoration = {
        rounding       = 8,
        rounding_power = 2,
        active_opacity   = 0.9,
        inactive_opacity = 0.8,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = c.bg_dark,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },


    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = -0.3,
    },


    animations = {
        enabled = true,
    },


    dwindle = {
        preserve_split = true,
    },


    master = {
        new_status = "master",
    },


    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.7,
        focus_fit_method = 1,
        follow_focus = true,
        follow_min_visible = 0.3,
        explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
        wrap_focus = true,
        wrap_swapcol = true,
        direction = "right",
    },


    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})


