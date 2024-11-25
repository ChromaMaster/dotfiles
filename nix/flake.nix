{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      mkHost =
        hostname: system:
        nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            # Configuration shared by all hosts
            ./nixos/configuration.nix

            # Host specific configuration
            ./nixos/hosts/${hostname}/configuration.nix

            # Host specific hardware configuration
            ./nixos/hosts/${hostname}/hardware-configuration.nix
          ];
        };
    in
    {
      nixosConfigurations = {
        default = mkHost "personal" "x86_64-linux";
        work = mkHost "work" "x86_64-linux";
      };
    };
}
