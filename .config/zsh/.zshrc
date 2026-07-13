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
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_LINE_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE

source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh


# LS_COLORS (derived from eza colors)
# ==================================================
export LS_COLORS="rs=0:di=38;2;255;121;198:ln=38;2;139;233;253:mh=38;2;255;184;108:pi=38;2;98;114;164:so=38;2;98;114;164:bd=38;2;255;184;108:cd=38;2;255;184;108:ex=38;2;80;250;123:fi=38;2;248;248;242:*.jpg=38;2;255;121;198:*.jpeg=38;2;255;121;198:*.png=38;2;255;121;198:*.gif=38;2;255;121;198:*.webp=38;2;255;121;198:*.avif=38;2;255;121;198:*.svg=38;2;255;121;198:*.tiff=38;2;255;121;198:*.bmp=38;2;255;121;198:*.mp4=38;2;189;147;249:*.mkv=38;2;189;147;249:*.avi=38;2;189;147;249:*.mov=38;2;189;147;249:*.webm=38;2;189;147;249:*.mp3=38;2;139;233;253:*.flac=38;2;80;250;123:*.wav=38;2;80;250;123:*.ogg=38;2;139;233;253:*.aac=38;2;139;233;253:*.pdf=38;2;248;248;242:*.doc=38;2;248;248;242:*.docx=38;2;248;248;242:*.txt=38;2;248;248;242:*.md=38;2;248;248;242:*.zip=38;2;255;184;108:*.tar=38;2;255;184;108:*.gz=38;2;255;184;108:*.zst=38;2;255;184;108:*.xz=38;2;255;184;108:*.bz2=38;2;255;184;108:*.7z=38;2;255;184;108:*.rar=38;2;255;184;108:*.tmp=38;2;98;114;164:*.log=38;2;98;114;164:*.o=38;2;98;114;164:*.pyc=38;2;98;114;164:*.class=38;2;98;114;164:*.rs=38;2;189;147;249:*.py=38;2;189;147;249:*.js=38;2;189;147;249:*.ts=38;2;189;147;249:*.c=38;2;189;147;249:*.cpp=38;2;189;147;249:*.h=38;2;189;147;249:*.lua=38;2;189;147;249:*.sh=38;2;80;250;123:*.zsh=38;2;80;250;123:*.bash=38;2;80;250;123:*.json=38;2;241;250;140:*.yaml=38;2;241;250;140:*.yml=38;2;241;250;140:*.toml=38;2;241;250;140:*.xml=38;2;241;250;140:*.gpg=38;2;255;85;85:*.pem=38;2;255;85;85:*.key=38;2;255;85;85:"

# COMPLETION SYSTEM (CORE)
# ==================================================

# Fix completion system
if [[ -d /usr/share/zsh/functions ]]; then
    fpath=(/usr/share/zsh/functions $fpath)
fi

# Ensure complist is available
if [[ -d /usr/lib/zsh/$ZSH_VERSION ]]; then
    fpath=(/usr/lib/zsh/$ZSH_VERSION $fpath)
fi


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
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
 'r:|[._-]=* r:|=*'


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

# RESTORE KEYBINDINGS AFTER ZVM
# ==================================================
zvm_after_init() {
  function zle-keymap-select() {
    zvm_select_vi_mode
    case $KEYMAP in
      vicmd) print -n '\e[2 q' ;;  # steady block (normal mode)
      *)     print -n '\e[6 q' ;;  # steady beam  (insert mode)
    esac
  }
  zle -N zle-keymap-select

  function zle-line-init() {
    print -n '\e[6 q'  # steady beam at prompt
  }
  zle -N zle-line-init

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
alias spqe='sudo pacman -Qe'
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
alias f='fetch'
alias ff='clear && fastfetch'
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

source $XDG_CONFIG_HOME/zsh/display_logo.zsh


