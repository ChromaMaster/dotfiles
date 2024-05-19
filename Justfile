all: zsh tmux git starship nvim kitty helix

# Install zsh config
zsh:
    rm -rf ~/.zshrc ~/.zprofile ~/.profile
    ln -s $PWD/zsh/.zshrc-zinit ~/.zshrc
    ln -s $PWD/zsh/.zprofile ~/
    ln -s $PWD/zsh/.profile ~/

# Install tmux config
tmux:
    rm -rf ~/.config/tmux/
    mkdir -p ~/.config/tmux
    ln -s $PWD/tmux/tmux.conf ~/.config/tmux/tmux.conf
    ln -s $PWD/tmux/theme_*.conf ~/.config/tmux/

# Install zellij config
zellij:
	rm -rf ~/.config/zellij/
	mkdir ~/.config/zellij
	ln -s $PWD/zellij/config.kdl ~/.config/zellij/config.kdl

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
nvim:
    rm -rf ~/.config/nvim
    ln -s $PWD/nvim ~/.config/nvim

# Install kitty config
kitty:
    rm -rf ~/.config/kitty
    ln -s $PWD/kitty ~/.config

# Install  helix config
helix:
    rm -rf ~/.config/helix
    ln -s $PWD/helix ~/.config
