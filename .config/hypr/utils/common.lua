local common  = {}


common.default_apps = {
    terminal    = "kitty",
    fileManager = "thunar",
    menu        = "fuzzel",
    browser     = "zen-browser"
}

common.scripts_path = os.getenv("HOME") .. "/.config/hypr/scripts/"

return common
