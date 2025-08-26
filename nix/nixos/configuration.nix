# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
    # Japanese
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
  };

  services = {
    logind = {
      lidSwitchExternalPower = "ignore";
      lidSwitchDocked = "ignore";
      lidSwitch = "ignore";
    };

    fwupd.enable = true;

    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "intl";
    };

    # Enable CUPS to print documents.
    printing.enable = true;
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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
        patches = [ ];
      });
    })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Nix
    nix-index

    ## Formatter
    alejandra
    nixfmt-rfc-style

    # Basics
    nautilus
    vim
    git
    wget
    curl
    file
    zip
    htop
    unzip
    telegram-desktop
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.droid-sans-mono
    jetbrains.clion
    jetbrains.pycharm-community
    xclip
    killall
    zed-editor
    vscode
    librewolf

    # Terminal emulators
    kitty
    ghostty

    # Build essentials
    binutils
    gnumake
    gcc
    cmake
    ninja
    pkg-config

    just
    meson
    poetry

    # Shell tools
    starship
    zoxide
    fzf
    atuin # Shell history
    eza
    bat
    diff-so-fancy
    pre-commit
    gh
    fd
    ripgrep
    lazygit
    tldr
    jq
    jqp # jq TUI
    yq

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
    ruff # python
    rust-analyzer # rust
    gopls # go
    lua-language-server # Lua

    # Formatters
    stylua
    xmlformat
    nodePackages.prettier

    # Other software
    obsidian
  ];

  programs = {
    nix-ld = {
      enable = true;
    };

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

    firefox = {
      enable = true;
    };

    neovim = {
      enable = true;
    };

    direnv = {
      enable = true;
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
