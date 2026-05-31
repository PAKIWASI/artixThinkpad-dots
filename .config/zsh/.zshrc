# XDG BASE DIRS
# ==================================================
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# EDITOR / ENV
# ==================================================
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# PATH
# ==================================================
export PATH="$HOME/.local/bin:$PATH"

# HISTORY
# ==================================================
HISTFILE="$HOME/.config/zsh/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY
setopt HIST_VERIFY

# CORE ZSH BEHAVIOR
# ==================================================
setopt AUTO_CD
setopt NO_BEEP
setopt INTERACTIVE_COMMENTS
setopt NO_CLOBBER

# ZSH-VI-MODE
# ==================================================
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_LINE_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK

source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# COMPLETION SYSTEM (CORE)
# ==================================================
autoload -Uz compinit

if [ -d /usr/share/zsh/plugins/zsh-completions ]; then
  fpath=(/usr/share/zsh/plugins/zsh-completions $fpath)
fi

compinit

setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt AUTO_MENU
setopt NUMERIC_GLOB_SORT
setopt NO_CASE_GLOB

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# DIRECTORY STACK
# ==================================================
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
alias d='dirs -v'

# STARSHIP PROMPT
# ==================================================
export STARSHIP_CONFIG=~/.config/starship/starship.toml
if command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi

# ZOXIDE
# ==================================================
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
fi

# FZF (CORE CONFIG)
# ==================================================
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --border
  --prompt='❯ '
  --preview-window=right:60%
  --highlight-line
  --info=inline-right
  --ansi
  --border=none
  --color=bg+:#44475a
  --color=bg:#282a36
  --color=border:#6272a4
  --color=fg:#f8f8f2
  --color=gutter:#282a36
  --color=header:#ffb86c
  --color=hl+:#8be9fd
  --color=hl:#8be9fd
  --color=info:#6272a4
  --color=marker:#ff79c6
  --color=pointer:#ff79c6
  --color=prompt:#bd93f9
  --color=query:#f8f8f2:regular
  --color=scrollbar:#6272a4
  --color=separator:#44475a
  --color=spinner:#ff79c6
"

# FZF CTRL-R HISTORY SEARCH
# ==================================================
fzf-history() {
  local cmd
  cmd=$(
    fc -rl 1 |
    sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//' |
    fzf --tac --no-sort --query="$LBUFFER" \
        --prompt='history ❯ '
  ) || return
  LBUFFER="$cmd"
}

# HISTORY SUBSTRING SEARCH
# ==================================================
if [ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

# AUTOSUGGESTIONS
# ==================================================
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# BUG: cursor blink is gone
# RESTORE KEYBINDINGS AFTER ZVM
# ==================================================
zvm_after_init() {
  # Fix starship/zvm zle-keymap-select recursion
  function zle-keymap-select() {
    zvm_select_vi_mode
  }
  zle -N zle-keymap-select

  zle -N fzf-history
  bindkey '^R' fzf-history
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^ ' autosuggest-accept
}

# ALIASES
# ==================================================

# pacman
alias sp='sudo pacman'
alias sps='sudo pacman -S'
alias spss='sudo pacman -Ss'
alias spsi='sudo pacman -Si'
alias spsyu='sudo pacman -Syu'
alias spr='sudo pacman -R'
alias sprns='sudo pacman -Rns'
alias spq='sudo pacman -Q'
alias pacorphs='pacman -Qtdq'
alias pacorphs-rm='sudo pacman -Rns $(pacman -Qtdq)'
alias pacforeign='pacman -Qqm'

# directories
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias mkdir='mkdir -p'

# applications
alias pic='kitty icat'
alias camera='guvcview'
alias f='fastfetch --logo-type kitty-icat --logo-width 35'
alias ff='fastfetch -l small'
alias n='nvim'
alias nd='VIMRUNTIME=/home/wasi/Documents/projects/foss/neovim/runtime /home/wasi/Documents/projects/foss/neovim/build/bin/nvim'
alias ndc='VIMRUNTIME=/home/wasi/Documents/projects/foss/neovim/runtime /home/wasi/Documents/projects/foss/neovim/build/bin/nvim --clean'
alias C='cmake -G Ninja -S . -B build/'
alias b='ninja -C build'
alias x='./build/main'
alias t='./build/tests'
alias bx='ninja -C build && ./build/main'
alias bt='ninja -C build && ./build/tests'

# misc
alias c='clear'

# safety
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

# dotfiles
alias dots='/usr/bin/git --git-dir=$HOME/Documents/dotfiles/ --work-tree=$HOME'
alias lazydots='lazygit --git-dir=$HOME/Documents/dotfiles --work-tree=$HOME'

# TMUX HELPERS
# ==================================================
tn() {
  [[ $# -eq 0 ]] && echo "Usage: tn <session>" || tmux new-session -s "$1"
}

ta() {
  [[ $# -eq 0 ]] && tmux list-sessions || tmux attach-session -t "$1"
}

alias tl='tmux list-sessions'
alias tks='tmux kill-session'
alias tkS='tmux kill-server'

# EZA
# ==================================================
export EZA_CONFIG_DIR="$HOME/.config/eza"

alias ls='eza --icons'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias lls='eza -l --icons --git --total-size'
alias las='eza -la --icons --git --total-size'
alias lm='eza -l --sort=modified --icons --git'
alias lz='eza -l --sort=size --icons --git'
alias lx='eza -l --sort=extension --icons --git'
alias lg='eza -l --git --git-ignore --git-repos --icons'

lt() {
  if [[ $# -eq 0 ]]; then
    eza -lT --icons --git -L 1
  else
    eza -lT --icons --git -L "$@"
  fi
}

ltg() {
  if [[ $# -eq 0 ]]; then
    eza -lT --icons --git --git-ignore --git-repos -L 1
  else
    eza -lT --icons --git --git-ignore --git-repos -L "$@"
  fi
}

lta() {
  if [[ $# -eq 0 ]]; then
    eza -laT --icons --git -L 1
  else
    eza -laT --icons --git -L "$@"
  fi
}

tree() {
  eza --tree --icons "$@"
}

# FZF EXTRAS
# ==================================================
fcdt() {
  local dir
  dir=$(fd --type d --hidden --follow --exclude .git \
    | fzf --preview 'eza --tree --level=3 --icons --color=always {}') || return
  cd "$dir"
}

# SYNTAX HIGHLIGHTING (MUST BE LAST)
# ==================================================
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

