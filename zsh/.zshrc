# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="arrow"
ZSH_THEME="lambda"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
#eval "$(mcfly init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"

autoload -Uz compinit
compinit

export EDITOR="nvim"
export GPG_TTY=$(tty)
export MCFLY_RESULTS_SORT=LAST_RUN

xhost +si:localuser:$USER &> /dev/null

# Alias

## Command replacement
alias vim="nvim"
alias cat="bat"

## Shortcuts
alias nv="nvim"
alias open="xdg-open"
alias hx="helix"

alias nvrc="nvim ~/.config/nvim/init.vim"
alias zshrc="nvim ~/.zshrc"

alias lsl="ls -l"

# Docker
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
        *)
                echo "Distro $DISTRO not supported"
        ;;
esac

# Auxiliar functions

function untilSucceeds() {
    while true; do $@ && break; sleep 0.5; done
}

function untilFails() {
    while true; do $@ || break; sleep 0.5; done
}

function gitsetremotes(){
    if [ -z "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]; then
        echo "ERROR: Not inside git repository"
        exit 1
    fi
 
    if [ $# -lt 2 ]; then
        echo "ERROR: Need 4 arguments: <srht ulr> <gh url>"
        exit 1
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


function fdiff(){
	if [ "$#" -ne 2 ]; then
            echo "ERROR: Usage $0 <file1> <file2>"
	        return
	fi

	diff -u $1 $2 | diff-so-fancy | less -R
}

# Calculate sha512sum and md5sum of all the bin files in the current directory
function binsha512sum() {
	find . -iname "*.bin" -type f -exec sh -c 'f={}; sha512sum $f > $f.sha512sum' \;
}

function binmd5sum() {
	find . -iname "*.bin" -type f -exec sh -c 'f={}; md5sum $f > $f.md5sum' \;
}

function umount_all() {
	if [ "$#" -ne 1 ]; then
		echo "ERROR: Usage $0 <disk> (example $0 sda)"
		return
	fi

	sudo umount $(lsblk --list | grep $1 | grep part | gawk '{ print $7 }' | tr '\n' ' ')
}

# Execute tmux if available
if which tmux &> /dev/null && [ -z "$TMUX" ]; then
  #tmux attach -t default || tmux new -s default
  tmux && exit
fi
