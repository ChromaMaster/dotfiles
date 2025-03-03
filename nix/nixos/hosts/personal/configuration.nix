{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/personal.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ ];
}
