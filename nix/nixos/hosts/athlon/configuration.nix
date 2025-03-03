{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/athlon.nix
  ];

  networking.hostName = "athlon"; # Define your hostname.

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ ];
}
