# Lists all the possible recipes
default:
	@just --list nix

# Format all nix files using alejandra formatter
format:
	find . -type f -iname "*.nix" -exec nixfmt {} \;

# Switch to current configuration
switch target="default":
	sudo nixos-rebuild switch --show-trace --flake $PWD#{{target}}

build target="default":	
	sudo nixos-rebuild dry-build --show-trace --flake $PWD#{{target}}
	
# Upgrade & switch to current configuration
upgrade target="default": && (switch target)
	sudo nix flake update

# List generations
list:
	sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

targets:
	@echo "Available targets are '$(ls nixos/hosts | xargs | tr ' ' ',' | sed 's/personal/default/')'"

# Remove old builds of nix
collect-garbage:
	./collect-garbage.sh
