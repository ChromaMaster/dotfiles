# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/work.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    slack
    # zoom-us
    (pkgs.zoom-us.overrideAttrs {
      version = "6.2.11.5069";
      src = pkgs.fetchurl {
        url = "https://zoom.us/client/6.2.11.5069/zoom_x86_64.pkg.tar.xz";
        hash = "sha256-k8T/lmfgAFxW1nwEyh61lagrlHP5geT2tA7e5j61+qw=";
      };
    })
  ];

  # nixpkgs.overlays = [
  #   # Fixes the version of zoom to a working one
  #   (final: prev: {
  #     zoom-us = prev.zoom-us.overrideAttrs (old: {
  #       version = "6.2.11.5069";
  #       src = final.fetchurl {
  #         url = "https://zoom.us/client/6.2.11.5069/zoom_x86_64.pkg.tar.xz";
  #         hash = "sha256-k8T/lmfgAFxW1nwEyh61lagrlHP5geT2tA7e5j61+qw=";
  #       };
  #     });
  #   })
  # ];
}
