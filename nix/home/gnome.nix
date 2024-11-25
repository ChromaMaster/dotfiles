{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs = {
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          lockAll = true;
          settings = {
            "org/gnome/desktop/peripherals/touchpad" = {
              natural-scroll = false;
              two-finger-scrolling-enabled = true;
            };

            "org/gnome/desktop/wm/preferences" = {
              num-workspaces = "4";
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
              switch-windows-backwards = [ "<Super><Shift>Tab" ];
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
              command = "kitty";
              binding = "<Super>Return";
            };
          };
        }
      ];
    };
  };
}
