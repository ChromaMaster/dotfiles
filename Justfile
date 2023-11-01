all: zsh tmux git

zsh:
    rm -rf ~/.zshrc
    ln -s $PWD/zsh/.zshrc ~/

tmux:
    rm -rf ~/.tmux.conf
    ln -s $PWD/tmux/.tmux.conf ~/

git:
    rm -rf ~/.gitignore ~/.gitconfig ~/.git-template
    ln -s $PWD/git/.gitignore ~/
    ln -s $PWD/git/.gitconfig ~/
    ln -s $PWD/git/.git-template ~/
