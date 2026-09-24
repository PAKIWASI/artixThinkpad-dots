<div align="center">

# artixThinkpad-dots

My lean **Artix Linux** (dinit) setup on a ThinkPad E14, running **Hyprland**.

<img src="Pictures/Showcase/ss1.png" alt="Desktop" width="100%">

</div>

## Setup

| | |
|---|---|
| **OS / init** | Artix Linux / dinit |
| **WM** | Hyprland (Lua config) |
| **Bar / notifs / launcher** | Waybar / mako / fuzzel |
| **Lock / idle** | hyprlock / hypridle |
| **Terminal** | kitty + tmux |
| **Shell** | zsh + starship |
| **Editor** | Neovim (native `vim.pack`) |
| **Keyboard** | kanata (as a dinit service) |
| **Browser / files / music** | Zen / Thunar / Spotify (spicetify) |
| **Theme** | Dracula, JetBrains Mono |

## Showcase

<table>
  <tr>
    <td><img src="Pictures/Showcase/ss-fastfetch1.png" alt="fastfetch"></td>
    <td><img src="Pictures/Showcase/ss-nvim-tmux.png" alt="nvim + tmux"></td>
  </tr>
  <tr>
    <td><img src="Pictures/Showcase/ss-nvim1.png" alt="nvim dashboard"></td>
    <td><img src="Pictures/Showcase/ss-zen.png" alt="Zen"></td>
  </tr>
  <tr>
    <td><img src="Pictures/Showcase/ss-spotify.png" alt="Spotify"></td>
    <td><img src="Pictures/Showcase/ss-thunar.png" alt="Thunar"></td>
  </tr>
</table>

<details>
<summary>More</summary>

<img src="Pictures/Showcase/ss2.png" alt="fastfetch pfps">
<img src="Pictures/Showcase/ss3.png" alt="Wallpaper + lyrics overlay">
<img src="Pictures/Showcase/ss-spotify2.png" alt="Spotify">

</details>

## Notes

- Random wallpaper on login from `Pictures/Wallpapers`.
- `fetch` shows fastfetch with a random image from `Pictures/Pfps`.
- Zsh lives in `~/.config/zsh` (`.zshenv` sets `ZDOTDIR`).

## Install

The repo mirrors `$HOME`.

```sh
git clone https://github.com/PAKIWASI/artixThinkpad-dots.git
cd artixThinkpad-dots
```

Copy or symlink what you want into `~`. Back up your existing configs first.
