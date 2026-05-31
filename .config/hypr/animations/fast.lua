-- animations/fast.lua
-- Snappy, minimal-latency animations. Everything under 150ms.

hl.curve("fastOut",   { type = "bezier", points = { {0.15, 0},    {0.1,  1}    } })
hl.curve("fastInOut", { type = "bezier", points = { {0.4,  0},    {0.6,  1}    } })
hl.curve("snap",      { type = "bezier", points = { {0.05, 0.9},  {0.1,  1}    } })

-- windows
hl.animation({ leaf = "windows",     enabled = true, speed = 2.5,  bezier = "fastOut",   style = "popin 80%" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 2.0,  bezier = "fastOut",   style = "popin 80%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 1.5,  bezier = "fastInOut", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2.5,  bezier = "fastOut"  })

-- fade
hl.animation({ leaf = "fade",        enabled = true, speed = 2.5,  bezier = "fastOut"   })
hl.animation({ leaf = "fadeIn",      enabled = true, speed = 2.0,  bezier = "fastOut"   })
hl.animation({ leaf = "fadeOut",     enabled = true, speed = 1.5,  bezier = "fastInOut" })
hl.animation({ leaf = "fadeSwitch",  enabled = true, speed = 2.0,  bezier = "snap"      })
hl.animation({ leaf = "fadeShadow",  enabled = true, speed = 2.0,  bezier = "snap"      })
hl.animation({ leaf = "fadeDim",     enabled = true, speed = 2.0,  bezier = "snap"      })

-- layers (fuzzel, waybar)
hl.animation({ leaf = "layers",      enabled = true, speed = 2.0,  bezier = "fastOut",   style = "fade"  })
hl.animation({ leaf = "layersIn",    enabled = true, speed = 2.0,  bezier = "fastOut",   style = "fade"  })
hl.animation({ leaf = "layersOut",   enabled = true, speed = 1.5,  bezier = "fastInOut", style = "fade"  })

-- workspaces
hl.animation({ leaf = "workspaces",  enabled = true, speed = 2.5,  bezier = "fastOut",   style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2.0, bezier = "fastOut", style = "slidefade 20%" })
