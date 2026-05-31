local common  = {}


common.default_apps = {
    terminal    = "kitty",
    fileManager = "thunar",
    menu        = "fuzzel",
    browser     = "zen-browser"
}

common.scripts_path = os.getenv("HOME") .. "/.config/hypr/scripts/"

common.wallpaper_path = os.getenv("HOME") .. "/Pictures/new_p/dracula_wall_1.jpg"

return common
