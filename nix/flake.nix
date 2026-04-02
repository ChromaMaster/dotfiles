{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Custom packages
    nihongo-no-yobi.url = "git+https://codeberg.org/ChromaMaster/nihongo-no-yobi";
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
            { nixpkgs.overlays = [ inputs.nihongo-no-yobi.overlays.default ]; }

            # Configuration shared by all hosts
            ./nixos/configuration.nix

            # Modules shared by all the hosts
            ./nixos/modules

            # Include specific modules
            ./nixos/modules/${hostname}.nix

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
        athlon = mkHost "athlon" "x86_64-linux";
      };
    };
}
