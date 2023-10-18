all: zsh

zsh:
    rm -rf ~/.zshrc
    ln -s $PWD/zsh/.zshrc ~/
