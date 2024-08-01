# Lists all the possible recipes
default:
	@just --list nix

# Format all nix files using alejandra formatter
format:
	find . -type f -iname "*.nix" -exec alejandra {} \;

# Switch to current configuration
switch:
	sudo nixos-rebuild switch --show-trace --flake $PWD#default

build:	
	sudo nixos-rebuild dry-build --show-trace --flake $PWD#default
	
# Upgrade & switch to current configuration
upgrade: && switch
	sudo nix flake update

# Remove old builds of nix
collect-garbage:
	sudo nix-collect-garbage --delete-old
