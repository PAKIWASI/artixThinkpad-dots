local common  = {}


common.default_apps = {
    terminal    = "kitty",
    fileManager = "thunar",
    menu        = "fuzzel",
    browser     = "zen-browser"
}

common.paths = {
    scripts = os.getenv("HOME") .. "/.config/hypr/scripts/",
    wallpapers = os.getenv("HOME") .. "/Pictures/Wallpapers/"
}

return common
