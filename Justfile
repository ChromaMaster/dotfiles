all: zsh tmux

zsh:
    rm -rf ~/.zshrc
    ln -s $PWD/zsh/.zshrc ~/

tmux:
    rm -rf ~/.tmux.conf
    ln -s $PWD/tmux/.tmux.conf ~/
