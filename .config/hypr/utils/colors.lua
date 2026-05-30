-- Dracula theme color palette for Hyprland

local M = {}

-- Base palette
M.bg          = "#282a36"   -- Background
M.bg_dark     = "#21222c"   -- Darker background
M.bg_light    = "#343746"   -- Lighter background / selection
M.fg          = "#f8f8f2"   -- Foreground
M.comment     = "#6272a4"   -- Comments / muted

-- Accent colors
M.cyan        = "#8be9fd"
M.green       = "#50fa7b"
M.orange      = "#ffb86c"
M.pink        = "#ff79c6"
M.purple      = "#bd93f9"
M.red         = "#ff5555"
M.yellow      = "#f1fa8c"

-- Semantic roles
M.main        = M.purple    -- Primary accent
M.accent      = M.pink      -- Secondary accent
M.highlight   = M.cyan      -- Highlights / active
M.warning     = M.orange    -- Warnings
M.error       = M.red       -- Errors
M.success     = M.green     -- Success / ok
M.info        = M.yellow    -- Info

-- Hyprland window border roles
M.border_active   = M.purple
M.border_inactive = M.comment
M.border_urgent   = M.red

-- Transparency variants (for Hyprland/wlroots rgba)
M.bg_t70      = "rgba(40,42,54,0.7)"
M.bg_t90      = "rgba(40,42,54,0.9)"
M.main_t80    = "rgba(189,147,249,0.8)"

return M
