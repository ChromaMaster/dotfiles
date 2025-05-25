{
  lib,
  pkgs,
  ...
}:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

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
