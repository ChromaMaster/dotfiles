# Set zinit home directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if not present
if ! [ -d $ZINIT_HOME ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add oh-my-zsh key-bindings. This basically fixes the Home/End/PageUp/PageDown keybindings
zinit snippet OMZL::key-bindings.zsh

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab # Replace zsh's default completion selection menu with fzf!

# Shell integrations
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
# eval "$(atuin init zsh --disable-up-arrow)"
eval "$(fzf --zsh)"

# Global configurations
export EDITOR="nvim"
export GPG_TTY=$(tty) # Needed to sign using pinentry-tty
export JUST_UNSTABLE=1
export DIRENV_WARN_TIMEOUT=0 # Disable timeout warning (useful when using nix flakes)


## Needed for japanese input
export XMODIFIERS DEFAULT=@im=fcitx
export GTK_IM_MODULE DEFAULT=fcitx
export QT_IM_MODULE DEFAULT=fcitx

export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'

# fzf configuration
# Need to set it like this otherwise the FZF_DEFAULT_OPTS interferes with the fzf-tab plugin
FZF_DEFAULT_OPTS_CUSTOM='--no-height --no-reverse --border'
export FZF_CTRL_T_OPTS="
	$FZF_DEFAULT_OPTS_CUSTOM
	--preview '([ ! -d {} ] && bat {} || tree -L 1 -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="
	$FZF_DEFAULT_OPTS_CUSTOM
	--preview 'echo {}' --preview-window down:3:hidden:wrap
	--bind '?:toggle-preview'
	--bind 'ctrl-y:accept'"

# Load completions
## If the .zcompdump file has been modified more than 24h ago, regenerate the completions.
## Otherwise use the cached
autoload -Uz compinit
if [ "$(find ~/.zcompdump -mtime +1)" ] ; then
    compinit
fi
compinit -C

# Define what is a word
## (b)ash:       Word characters are alphanumerics only
autoload -Uz select-word-style
select-word-style bash

zinit cdreplay -q

# Completion styling
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ":fzf-tab:*" fzf-bindings "enter:accept"
zstyle ":fzf-tab:complete:*" fzf-preview 'eza --icons --color $realpath' # Preview directories when doing cd


# Custom keybindings
## Use ctrl + y to accept the zsh-autosuggestion
bindkey "^y" autosuggest-accept
## This enables to search commands that match the current prefix typed
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

# History configuration
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase # Do not allow duplicates in the history
## Entire documentation here: https://zsh.sourceforge.io/Doc/Release/Options.html
setopt append_history # append to the history file rather than replace it
setopt share_history # share historyfile across multiple shells
setopt hist_ignore_space # ignore space prefixed commands
setopt hist_ignore_dups # do not enter command lines into the history list if they are duplicates of the previous event
setopt hist_ignore_all_dups # if a new command line being added to the history list duplicates an older one, the older command is removed from the list
setopt hist_save_no_dups # when writing out the history file, older commands that duplicate newer ones are omitted 
setopt hist_find_no_dups # when searching for history entries in the line editor, do not display duplicates of a line previously found

# Aliases
## Removed aliases
unalias zi # zinit alias colides with zoxide

## Command replacement
alias vim="nvim"
alias cat="bat"

## Shortcuts
alias nv="nvim"
alias open="xdg-open"
alias hx="helix"
alias lg="lazygit"
alias zed="zeditor"

alias nvrc="nvim ~/.config/nvim/init.vim"
alias zshrc="nvim ~/.zshrc"

## Default flags
alias ls="eza --color --icons --git"
alias tree="eza -T"

## Docker
alias docker_rm_all='docker rm $(docker ps --filter status=exited -q)'

## Distro specific
DISTRO=$(cat /etc/os-release | grep -e '^ID=' | cut -d '=' -f 2)

## Distro specific
case "$DISTRO" in
        "debian")
                alias apt="sudo apt"
                alias aptlu="sudo apt list --upgradable"
        ;;

        "arch")
                alias pacman="yay"
                alias pacman_autoremove="pacman -Qqdt | pacman -Rsu -"
		;;
		"nixos")	
        ;;
        *)
                echo "Distro $DISTRO not supported"
        ;;
esac

# Helpful functions
function untilSucceeds() {
    while true; do $@ && break; sleep 0.5; done
}

function untilFails() {
    while true; do $@ || break; sleep 0.5; done
}

function fdiff(){
	if [ "$#" -ne 2 ]; then
            echo "ERROR: Usage $0 <file1> <file2>"
	        return
	fi

	diff -u $1 $2 | diff-so-fancy | less -R
}

function umount_all() {
	if [ "$#" -ne 1 ]; then
		echo "ERROR: Usage $0 <disk> (example $0 sda)"
		return
	fi

	sudo umount $(lsblk --list | grep $1 | grep part | gawk '{ print $7 }' | tr '\n' ' ')
}

function git-set-remotes(){
	if [ $1 = "help" ]; then
		echo "Usage: $0 <srht-remote> <github-remote>"
		return 0
	fi

    if [ -z "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]; then
        echo "ERROR: Not inside git repository"
        return 1 
    fi
 
    if [ $# -lt 2 ]; then
        echo "ERROR: Need 4 arguments: <srht ulr> <gh url>"
        return 1
    fi
 
    for remote in $(git remote show); do
        echo "Removing remote: $remote"
        git remote -v remove $remote
    done
 
    git remote add srht $1
    git remote add github $2
 
    git remote add origin $1
    git remote set-url --add --push origin $1
    git remote set-url --add --push origin $2
}

# Execute tmux if available
if which tmux &> /dev/null && [ -z "$TMUX" ]; then
  #tmux attach -t default || tmux new -s default
  exec tmux
fi

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi

