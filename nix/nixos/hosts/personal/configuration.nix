{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/personal.nix
  ];

  networking.hostName = "nixos"; # Define your hostname.

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ ];
}
