-- animations/fancy.lua
-- Smooth, expressive animations with overshoot and spring feel.

hl.curve("easeOutExpo",   { type = "bezier", points = { {0.16, 1},    {0.3,  1}    } })
hl.curve("easeOutBack",   { type = "bezier", points = { {0.34, 1.56}, {0.64, 1}    } })
hl.curve("easeInOutExpo", { type = "bezier", points = { {0.87, 0},    {0.13, 1}    } })
hl.curve("softSpring",    { type = "spring", mass = 1, stiffness = 120, dampening = 18 })

-- windows
hl.animation({ leaf = "windows",     enabled = true, speed = 3.5,  bezier = "easeOutBack",   style = "popin 60%"  })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 3.5,  bezier = "easeOutBack",   style = "popin 60%"  })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 2.5,  bezier = "easeInOutExpo", style = "popin 80%"  })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3.5, bezier = "easeOutBack" })

-- fade
hl.animation({ leaf = "fade",        enabled = true, speed = 3.0,  bezier = "easeOutExpo"   })
hl.animation({ leaf = "fadeIn",      enabled = true, speed = 3.0,  bezier = "easeOutExpo"   })
hl.animation({ leaf = "fadeOut",     enabled = true, speed = 2.0,  bezier = "easeInOutExpo" })
hl.animation({ leaf = "fadeSwitch",  enabled = true, speed = 2.5,  bezier = "easeOutExpo"   })
hl.animation({ leaf = "fadeShadow",  enabled = true, speed = 2.5,  bezier = "easeOutExpo"   })
hl.animation({ leaf = "fadeDim",     enabled = true, speed = 3.0,  bezier = "easeOutExpo"   })

-- layers (fuzzel, waybar)
hl.animation({ leaf = "layers",      enabled = true, speed = 3.0,  bezier = "easeOutBack",   style = "slide top" })
hl.animation({ leaf = "layersIn",    enabled = true, speed = 3.0,  bezier = "easeOutBack",   style = "slide top" })
hl.animation({ leaf = "layersOut",   enabled = true, speed = 2.0,  bezier = "easeInOutExpo", style = "fade"      })

-- workspaces
hl.animation({ leaf = "workspaces",      enabled = true, speed = 3.5, bezier = "easeOutExpo",   style = "slidefade 15%"     })
hl.animation({ leaf = "workspacesIn",    enabled = true, speed = 3.5, bezier = "easeOutBack",   style = "slidefade 15%"     })
hl.animation({ leaf = "workspacesOut",   enabled = true, speed = 2.5, bezier = "easeInOutExpo", style = "slidefade 15%"     })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3.0, bezier = "easeOutBack",  style = "slidefade 30%"     })
