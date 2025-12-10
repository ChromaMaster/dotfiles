{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../../modules/work.nix
  ];

  networking.hostName = "nixos"; # Define your hostname.

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    slack
    zoom-us
    # (pkgs.zoom-us.overrideAttrs {
    #   version = "6.2.11.5069";
    #   src = pkgs.fetchurl {
    #     url = "https://zoom.us/client/6.2.11.5069/zoom_x86_64.pkg.tar.xz";
    #     hash = "sha256-k8T/lmfgAFxW1nwEyh61lagrlHP5geT2tA7e5j61+qw=";
    #   };
    # })
  ];

  # https://github.com/NixOS/nixpkgs/issues/100205#issuecomment-2225948931
  services.dbus.packages = lib.mkAfter [
    (pkgs.linkFarm "custom-dbus-policy" {
      "share/dbus-1/system.d/custom-policy.conf" = pkgs.writers.writeText "custom-policy.conf" ''
        <!-- place this in /etc/dbus-1/system.d or in some systems /usr/share/dbus-1/system.d/ -->
        <!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
         "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
        <busconfig>
        	<policy user="vlad">
        		<allow own="*"/>
        		<allow send_destination="*"/>
        	</policy>
        </busconfig>
      '';
    })
  ];

  # https://search.nixos.org/options?channel=25.05&show=security.wrappers&from=0&size=50&sort=relevance&type=packages&query=security.wrappers
  security.wrappers.btmgmt = {
    source = "${pkgs.bluez}/bin/btmgmt";
    capabilities = "cap_net_raw+eip cap_net_admin+eip";
    owner = "root";
    group = "root";
  };

  security.wrappers.hciconfig = {
    source = "${pkgs.bluez}/bin/hciconfig";
    capabilities = "cap_net_raw+eip cap_net_admin+eip";
    owner = "root";
    group = "root";
  };

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
