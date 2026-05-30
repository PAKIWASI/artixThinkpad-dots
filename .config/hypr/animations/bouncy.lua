-----------------------
---- BOUNCY ----
-----------------------

-- Bezier curves (kept for fades/layers where springs don't apply)
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeOutBack",    { type = "bezier", points = { {0.34, 1.56}, {0.64, 1}    } }) -- slight overshoot
hl.curve("softOut",        { type = "bezier", points = { {0.25, 1},    {0.5, 1}     } })
hl.curve("quickFade",      { type = "bezier", points = { {0.25, 0},    {0.25, 1}    } })

-- Springs
-- "bouncy"  : low damping → overshoots and oscillates a little
-- "snappy"  : higher stiffness → fast settle with a small kick
-- "gentle"  : used for fades/workspaces so they don't feel jerky
hl.curve("bouncy",  { type = "spring", mass = 1,    stiffness = 180,  dampening = 12 })
hl.curve("snappy",  { type = "spring", mass = 0.85, stiffness = 220,  dampening = 18 })
hl.curve("gentle",  { type = "spring", mass = 1,    stiffness = 100,  dampening = 20 })

-- Windows: bouncy open, quick snappy close
hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier  = "default"      })
hl.animation({ leaf = "border",        enabled = true,  speed = 4,    bezier  = "easeOutBack"   })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4,    spring  = "bouncy"        })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 3.5,  spring  = "bouncy",        style = "popin 75%"  })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 2.5,  spring  = "snappy",        style = "popin 90%"  })

-- Fades: soft so they don't compete with the spring motion
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 2.5,  bezier  = "softOut"       })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 2,    bezier  = "quickFade"     })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3,    bezier  = "softOut"       })

-- Layers (rofi, waybar popups): bouncy in, instant-ish out
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.5,  spring  = "bouncy"        })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 3.5,  spring  = "bouncy",        style = "fade"       })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 2,    bezier  = "quickFade",     style = "fade"       })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 2,    bezier  = "softOut"       })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.5,  bezier  = "quickFade"     })

-- Workspaces: gentle spring slide so switching feels weighty not floaty
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 3,    spring  = "gentle",        style = "slidevert"  })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 3,    spring  = "gentle",        style = "slidevert"  })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 2.5,  spring  = "gentle",        style = "slidevert"  })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 5,    spring  = "bouncy"        })
