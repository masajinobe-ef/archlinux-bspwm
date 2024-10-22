#!/bin/zsh

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                     Tmux                                             ║
# ╚══════════════════════════════════════════════════════════════════════╝

ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_FIXTERM=true
ZSH_TMUX_AUTOCONNECT=false

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                     Powerlevel10k Instant Prompt                     ║
# ╚══════════════════════════════════════════════════════════════════════╝

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                          Oh My Zsh Installation                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                   Zsh Autosuggestions Strategy                       ║
# ╚══════════════════════════════════════════════════════════════════════╝

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                          Oh My Zsh Updates                           ║
# ╚══════════════════════════════════════════════════════════════════════╝

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                          Zsh Updates                                 ║
# ╚══════════════════════════════════════════════════════════════════════╝

export UPDATE_ZSH_DAYS=7

# ╔══════════════════════════════════════════════════════════════════════╗
# ║              Magic Functions and Corrections                         ║
# ╚══════════════════════════════════════════════════════════════════════╝

# DISABLE_MAGIC_FUNCTIONS="true"
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                     History Timestamp Format                         ║
# ╚══════════════════════════════════════════════════════════════════════╝

HIST_STAMPS="dd/mm/yyyy"

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                          Plugins to Load                             ║
# ╚══════════════════════════════════════════════════════════════════════╝

plugins=(
  git
  tmux
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
  zsh-autopair
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                      Environment Variables                           ║
# ╚══════════════════════════════════════════════════════════════════════╝

export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="chromium"
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export RUST_BACKTRACE=1

export PATH="$HOME/.cargo/bin:$PATH"
. "$HOME/.cargo/env"

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                             Aliases                                  ║
# ╚══════════════════════════════════════════════════════════════════════╝

# Editors
alias n="nvim"
alias v="nvim"
alias vim="nvim"
alias vi="nvim"

# Version Control
alias g="git"
alias lg="lazygit"

# Text Utilities
alias b="bat"
alias cat="bat"
alias grep="rg"

# Package Manager
alias orph="pacman -Rns $(pacman -Qdtq)"

# Notifications and Dunst Management
alias dun='killall dunst && dunst & notify-send "cool1" "yeah it is working" && notify-send "cool2" "yeah it is working"'

# IP
alias ipv4="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f6 | cut -d/ -f1"
alias ipv6="ip addr show | grep 'inet6 ' | cut -d ' ' -f6 | sed -n '2p'"

# Terminal Management
alias cls="clear"

# Directory Listing
alias ls="clear; eza --long --header --tree --icons=always --all --level=1 --group-directories-first --no-permissions --no-user --no-time --no-filesize"
alias l="ls"

# File Management
alias mv="mv -v"
alias rm="rm -rfv"
alias cp="cp -vr"
alias mkdir="mkdir -p"

# Archiving
alias tgz='tar -cvvzf'
alias tbz2='tar -cvvjf'
alias utgz='tar -xvvzf'
alias utbz2='tar -xvvjf'
alias mktar='tar -cvvf'
alias untar='tar -xvvf'
alias zz='zip -r'
alias uz='unzip'

# Bootloader and Mirror Management
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias mirror-update="sudo reflector --verbose --protocol https --age 12 --sort rate --latest 10 --country France,Germany,Finland,Russia,Netherlands --save /etc/pacman.d/mirrorlist"

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                          Yazi Function                               ║
# ╚══════════════════════════════════════════════════════════════════════╝

function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                          Search Function                             ║
# ╚══════════════════════════════════════════════════════════════════════╝

function zs() {
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Neovim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'

  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$@"
}

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                Load Powerlevel10k Configuration                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                      Zoxide Initialization                           ║
# ╚══════════════════════════════════════════════════════════════════════╝

eval "$(zoxide init zsh)"

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                      Autorun                                         ║
# ╚══════════════════════════════════════════════════════════════════════╝


