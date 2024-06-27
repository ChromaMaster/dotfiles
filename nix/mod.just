# Lists all the possible recipes
default:
	@just --list nix

# Format all nix files using alejandra formatter
format:
	find . -type f -iname "*.nix" -exec alejandra {} \;

# Switch to current configuration
switch:
	sudo nixos-rebuild switch --show-trace --flake $PWD#default
	
# Upgrade & switch to current configuration
upgrade:
	sudo nixos-rebuild switch --upgrade --show-trace --flake $PWD#default
