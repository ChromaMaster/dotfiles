{
  lib,
  pkgs,
  ...
}:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    # Gnome dependencies
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.advanced-alttab-window-switcher
    gnomeExtensions.focus-follows-workspace
  ];

  programs = {
    #gnome config
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          lockAll = true;
          settings = {
            "org/gnome/settings-daemon/plugins/power" = {
              power-button-action = "nothing";
              power-saver-profile-on-low-battery = false;
              sleep-inactive-ac-type = "nothing";
              sleep-inactive-battery-timeout = lib.gvariant.mkInt32 7200;
              sleep-inactive-battery-type = "suspend";
            };

            "org/gnome/desktop/screensaver" = {
              lock-enabled = false;
            };

            "org/gnome/desktop/session" = {
              idle-delay = lib.gvariant.mkUint32 0;
            };

            "org/gnome/desktop/peripherals/touchpad" = {
              natural-scroll = false;
              two-finger-scrolling-enabled = true;
            };

            "org/gnome/desktop/wm/preferences" = {
              num-workspaces = "4";
            };

            "org/gnome/desktop/interface" = {
              color-scheme = "prefer-dark";
              show-battery-percentage = true;
            };

            "org/gnome/mutter" = {
              workspaces-only-on-primary = true;
              dynamic-workspaces = false;
            };

            "org/gnome/shell" = {
              disable-user-extensions = false;
              enabled-extensions = [
                pkgs.gnomeExtensions.appindicator.extensionUuid
                pkgs.gnomeExtensions.user-themes.extensionUuid
                pkgs.gnomeExtensions.removable-drive-menu.extensionUuid
                pkgs.gnomeExtensions.advanced-alttab-window-switcher.extensionUuid
                pkgs.gnomeExtensions.focus-follows-workspace.extensionUuid
              ];
            };

            "org/gnome/shell/extensions/user-theme" = {
              # name = "Arc";
            };

            "org/gnome/shell/extensions/advanced-alt-tab-window-switcher" = {
              switcher-popup-monitor = lib.gvariant.mkInt32 3;
              win-switcher-popup-ws-indexes = false;
            };

            "org/gnome/shell/keybindings" = {
              switch-to-application-1 = [ "disabled" ];
              switch-to-application-2 = [ "disabled" ];
              switch-to-application-3 = [ "disabled" ];
              switch-to-application-4 = [ "disabled" ];

              screenshot = [ "<Shift><Super>p" ];
              screenshot-window = [ "<Shift><Super>o" ];
              show-screenshot-ui = [ "<Shift><Super>i" ];
            };

            "org/gnome/desktop/wm/keybindings" = {
              close = [ "<Super>q" ];
              toggle-maximized = [ "<Super>f" ];

              move-to-monitor-down = [ "<Super><Shift>Down" ];
              move-to-monitor-left = [ "<Super><Shift>Left" ];
              move-to-monitor-right = [ "<Super><Shift>Right" ];
              move-to-monitor-up = [ "<Super><Shift>Up" ];
              switch-to-workspace-1 = [ "<Super>1" ];
              switch-to-workspace-2 = [ "<Super>2" ];
              switch-to-workspace-3 = [ "<Super>3" ];
              switch-to-workspace-4 = [ "<Super>4" ];
              move-to-workspace-1 = [ "<Super><Shift>1" ];
              move-to-workspace-2 = [ "<Super><Shift>2" ];
              move-to-workspace-3 = [ "<Super><Shift>3" ];
              move-to-workspace-4 = [ "<Super><Shift>4" ];

              switch-applications = [ "disabled" ];
              switch-applications-backwards = [ "disabled" ];

              switch-windows = [ "<Super>Tab" ];
              switch-windows-backwards = [ "<Super><Alt>Tab" ];

              switch-input-source = [ "<Control><Alt>space" ];
              switch-input-source-backward = [ "<Shift><Control><Alt>Space" ];
            };

            "org/gnome/settings-daemon/plugins/media-keys" = {
              calculator = [ "<Super>c" ];
              home = [ "<Super>e" ];
              www = [ "<Super>b" ];

              screensaver = [ "disabled" ];
              terminal = [ "disabled" ];

              custom-keybindings = [
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
              ];
            };

            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
              name = "Terminal";
              command = "ghostty";
              binding = "<Super>Return";
            };
          };
        }
      ];
    };
  };
}
