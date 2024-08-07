# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Powerlevel10k initialize
ZSH_THEME="powerlevel10k/powerlevel10k"

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Oh My Zsh updates
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git 
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
  zsh-autopair
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR="nvim"
export TERM="alacritty"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='nvim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias n="nvim"
alias g="git"
alias b="bat"
alias cat="bat"
alias cls="clear"
alias cp="cp -vr"
alias grep="rg"
alias ls="clear; eza --long --header --tree --icons=always --all --level=1 --group-directories-first --no-permissions --no-user --no-time --no-filesize"
alias mv="mv -v"
alias rm="rm -rfv"
alias untar="tar -xvf"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias mirrors-update="sudo reflector --verbose --protocol https --age 12 --sort rate --latest 10 --country France,Germany,Finland,Russia,Netherlands --save /etc/pacman.d/mirrorlist"

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Zoxide
eval "$(zoxide init zsh)"
