{
  lib,
  pkgs,
  ...
}:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GDM Display Manager
  services.displayManager.gdm.enable = true;

  environment.systemPackages = with pkgs; [
    wofi
    nwg-displays # Output management utility for Hyprland
  ];

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };

    # Highly customizable Wayland bar for Sway and Wlroots based compositors.
    waybar = {
      enable = true;
    };
  };
}
