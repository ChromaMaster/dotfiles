all: zsh tmux git starship neovim2 kitty helix

# Install zsh config
zsh:
    rm -rf ~/.zshrc ~/.zprofile ~/.profile
    ln -s $PWD/zsh/.zshrc ~/
    ln -s $PWD/zsh/.zprofile ~/
    ln -s $PWD/zsh/.profile ~/

# Install tmux config
tmux:
    rm -rf ~/.tmux.conf
    ln -s $PWD/tmux/.tmux.conf ~/

# Install git config (gitignore, config, templates and message)
git:
    rm -rf ~/.gitignore ~/.gitconfig ~/.git-template ~/.gitmessage
    ln -s $PWD/git/.gitignore ~/
    ln -s $PWD/git/.gitconfig ~/
    ln -s $PWD/git/.git-template ~/
    ln -s $PWD/git/.gitmessage ~/

# Install starship config
starship:
    rm -rf ~/.config/starship.toml
    ln -s $PWD/starship/starship.toml ~/.config

# Install neovim config
neovim:
    rm -rf ~/.config/nvim
    ln -s $PWD/neovim ~/.config/nvim

# Install neovim2 configuration (WIP config)
neovim2:
    rm -rf ~/.config/nvim
    ln -s $PWD/neovim2 ~/.config/nvim

# Install kitty config
kitty:
    rm -rf ~/.config/kitty
    ln -s $PWD/kitty ~/.config

# Install  helix config
helix:
    rm -rf ~/.config/helix
    ln -s $PWD/helix ~/.config
