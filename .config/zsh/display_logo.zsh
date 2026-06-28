


if [[ $- == *i* ]]; then

    # Skip display in neovim terminal or tmux popup             set in .tmux.conf
    if [ -n "$NVIM" ] || [ "$TERM_PROGRAM" = "nvim" ] || [ -n "$TMUX_POPUP" ]; then

    else

        # Regular terminal - decide between fastfetch or random logo
        if [ -n "$TMUX" ]; then
            # In tmux (but not popup) - show random logo
            rand_img    # ~/.local/bin/rand_img

        else
            # In normal kitty terminal (not tmux) - show fastfetch
            fetch       # ~/.local/bin/fetch

        fi
    fi
fi



# # tmux cursor fix
# if [[ -n "$TMUX" ]]; then
#   _tmux_cursor_fix() { echo -ne '\e[5 q'; }
#   precmd_functions+=(_tmux_cursor_fix)
#
#   zle-keymap-select() {
#     [[ $KEYMAP == vicmd ]] && echo -ne '\e[1 q' || echo -ne '\e[5 q'
#     zle reset-prompt
#   }
#   zle -N zle-keymap-select
# fi
