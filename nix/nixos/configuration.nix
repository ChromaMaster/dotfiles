# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.

  boot = {
    supportedFilesystems = ["ntfs"];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = false;
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
        extraEntries = ''
          menuentry "Windows" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root 00001DD8-97CC-417E-9BE5-173F2199B394
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vlad = {
    isNormalUser = true;
    description = "Vlad";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      #  thunderbird
    ];
    shell = pkgs.zsh;
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    # Have the current version of tmux replaces until the next release.
    # Waiting on this to be in the upsteam: https://github.com/tmux/tmux/pull/3958
    (final: prev: {
      tmux = prev.tmux.overrideAttrs (old: {
        src = final.fetchFromGitHub {
          owner = old.src.owner;
          repo = old.src.repo;
          rev = "34807388b064ed922293f128324b7d5d96f0c84d";
          hash = "sha256-zG3oRaahQCOVGTWfWwhDff5/iNbbWbxwIX/clK3vEPM=";
        };
        patches = [];
      });
    })
  ];

  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    docker.enable = true;
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Nix
    nix-index

    ## Formatter
    alejandra

    # Basics
    vim
    git
    kitty
    wget
    curl
    file
    zip
    unzip
    telegram-desktop
    (nerdfonts.override {fonts = ["DejaVuSansMono" "DroidSansMono"];})
    jetbrains.clion
    xclip
    killall

    # Build essentials
    binutils
    gnumake
    gcc
    cmake
    ninja
    pkg-config

    just
    meson

    # Shell tools
    starship
    zoxide
    direnv
    fzf
    eza
    bat
    diff-so-fancy
    pre-commit
    gh
    fd
    ripgrep
    lazygit
    tldr

    # Programming languages
    go
    zig
    python3
    rustc
    lua
    nodejs
    ruby

    # LSP Servers
    clang-tools # c/c++
    zls # zig
    cmake-language-server # cmake
    bash-language-server # bash
    pyright # python
    rust-analyzer # rust
    gopls # go
    lua-language-server # Lua

    # Formatters
    stylua
    xmlformat
    nodePackages.prettier

    # Gnome dependencies
    # gnome.dconf-editor
    gnome-tweaks
    gnomeExtensions.appindicator
  ];

  programs = {
    gnupg = {
      agent = with pkgs; {
        enable = true;
        pinentryPackage = pinentry-curses;
      };
    };
    zsh = {
      enable = true;
    };
    tmux = {
      enable = true;
    };
    neovim = {
      enable = true;
    };
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
              sleep-inactive-battery-timeout = "1800";
              sleep-inactive-battery-type = "suspend";
            };

            "org/gnome/desktop/peripherals/touchpad" = {
              natural-scroll = false;
              two-finger-scrolling-enabled = true;
            };

            "org/gnome/desktop/wm/preferences" = {
              num-workspaces = "4";
            };

            "org/gnome/desktop/interface" = {
              how-battery-percentage = true;
            };

            "org/gnome/mutter" = {
              workspaces-only-on-primary = true;
            };

            "org/gnome/shell" = {
              enabled-extensions = ["appindicatorsupport@rgcjonas.gmail.com"];
            };

            "org/gnome/shell/keybindings" = {
              switch-to-application-1 = ["disabled"];
              switch-to-application-2 = ["disabled"];
              switch-to-application-3 = ["disabled"];
              switch-to-application-4 = ["disabled"];

              screenshot = ["<Shift><Super>p"];
              screenshot-window = ["<Shift><Super>o"];
              show-screenshot-ui = ["<Shift><Super>i"];
            };

            "org/gnome/desktop/wm/keybindings" = {
              close = ["<Super>q"];
              toggle-maximized = ["<Super>f"];

              move-to-monitor-down = ["<Super><Shift>Down"];
              move-to-monitor-left = ["<Super><Shift>Left"];
              move-to-monitor-right = ["<Super><Shift>Right"];
              move-to-monitor-up = ["<Super><Shift>Up"];
              switch-to-workspace-1 = ["<Super>1"];
              switch-to-workspace-2 = ["<Super>2"];
              switch-to-workspace-3 = ["<Super>3"];
              switch-to-workspace-4 = ["<Super>4"];
              move-to-workspace-1 = ["<Super><Shift>1"];
              move-to-workspace-2 = ["<Super><Shift>2"];
              move-to-workspace-3 = ["<Super><Shift>3"];
              move-to-workspace-4 = ["<Super><Shift>4"];

              switch-applications = ["disabled"];
              switch-applications-backwards = ["disabled"];
              switch-windows = ["<Super>Tab"];
              switch-windows-backwards = ["<Super><Shift>Tab"];
            };

            "org/gnome/settings-daemon/plugins/media-keys" = {
              calculator = ["<Super>c"];
              home = ["<Super>e"];
              www = ["<Super>b"];

              screensaver = ["disabled"];
              terminal = ["disabled"];

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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
