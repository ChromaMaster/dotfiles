all: zsh tmux git starship neovim kitty helix

zsh:
    rm -rf ~/.zshrc ~/.zprofile ~/.profile
    ln -s $PWD/zsh/.zshrc ~/
    ln -s $PWD/zsh/.zprofile ~/
    ln -s $PWD/zsh/.profile ~/

tmux:
    rm -rf ~/.tmux.conf
    ln -s $PWD/tmux/.tmux.conf ~/

git:
    rm -rf ~/.gitignore ~/.gitconfig ~/.git-template
    ln -s $PWD/git/.gitignore ~/
    ln -s $PWD/git/.gitconfig ~/
    ln -s $PWD/git/.git-template ~/

starship:
    rm -rf ~/.config/starship.toml
    ln -s $PWD/starship/starship.toml ~/.config

neovim:
    rm -rf ~/.config/nvim
    ln -s $PWD/neovim ~/.config/nvim

kitty:
    rm -rf ~/.config/kitty
    ln -s $PWD/kitty ~/.config

helix:
    rm -rf ~/.config/helix
    ln -s $PWD/helix ~/.config
