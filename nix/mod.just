# Lists all the possible recipes
default:
	@just --list nix

# Switch to current configuration
switch:
	sudo nixos-rebuild switch --show-trace --flake $PWD#default
	
