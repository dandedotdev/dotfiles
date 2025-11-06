# ===== @file /etc/nixos/configuration.nix ===== #

{ config, pkgs, ... }:
let
  unstable_pkgs = import (builtins.fetchTarball
    "https://github.com/nixos/nixpkgs/tarball/nixos-unstable") {
      config = config.nixpkgs.config;
    };
in {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."xxxx-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx".device =
    "/dev/disk/by-uuid/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";

  networking = {
    hostName = "dandedotdev-P14s-NixOS";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [ 443 80 ];
      logReversePathDrops = true;
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
    };
  };

  time.timeZone = "Asia/Taipei";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_TW.UTF-8";
    LC_IDENTIFICATION = "zh_TW.UTF-8";
    LC_MEASUREMENT = "zh_TW.UTF-8";
    LC_MONETARY = "zh_TW.UTF-8";
    LC_NAME = "zh_TW.UTF-8";
    LC_NUMERIC = "zh_TW.UTF-8";
    LC_PAPER = "zh_TW.UTF-8";
    LC_TELEPHONE = "zh_TW.UTF-8";
    LC_TIME = "zh_TW.UTF-8";
  };

  # Mandarin/Chinese input method (fcitx5-chewing)
  # https://nixos.org/manual/nixos/stable/#module-services-input-methods
  # https://nixos.org/manual/nixos/stable/#module-services-input-methods-fcitx
  # https://nixos.wiki/wiki/Fcitx5
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chewing fcitx5-gtk ];
  };
  # And then install GNOME extension manually
  # https://extensions.gnome.org/extension/261/kimpanel/
  # The 3rd step is to add the relevant settings to environment.system packages
  # Just take a look when go through environment.system settings

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };
  services.printing = {
    enable = true;
    drivers = [ pkgs.foomatic-db pkgs.foomatic-db-ppds ];
  };
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.dandedotdev = {
    isNormalUser = true;
    description = "dandedotdev";
    extraGroups = [ "networkmanager" "wheel" "dialout" "wireshark" "docker" ];
    packages = with pkgs;
      [
        #  thunderbird
      ];
  };

  virtualisation = {
    containers.enable = true;
    docker.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # For the path for `uv`
  environment.localBinInPath = true;

  environment.systemPackages = with pkgs; [
    # ===== Browser ===== #
    chromium
    #microsoft-edge
    firefox

    # ===== Communication ===== #
    #discord
    #element-desktop

    # ===== Terminal ===== #
    #alacritty
    #alacritty-theme
    #fzf-zsh
    neofetch
    oh-my-posh
    #oh-my-zsh
    warp-terminal
    #zsh

    # ===== Media ===== #
    ffmpeg
    gimp-with-plugins
    inkscape-with-extensions
    libreoffice-fresh
    libsForQt5.kdenlive
    obs-studio
    vlc

    # ===== Networking ===== #
    nettools
    wireshark

    # ===== System Tools ===== #
    gnome-tweaks
    gparted
    mkcert
    #ventoy-full
    curl
    docker-compose
    ttf-tw-moe
    wget
    wpsoffice
    xorg.xeyes
    zip

    # ===== DEV ===== #
    git
    postman
    #hoppscotch
    mdbook
    #nixpkgs-fmt
    nixfmt-classic
    #saleae-logic-2
    #stm32cubemx
    uv

    # ===== Color Management ===== #
    #gnome.gnome-color-manager

    # ===== IDE ===== #
    vim
    neovim
    unstable_pkgs.code-cursor
    (unstable_pkgs.vscode-with-extensions.override {
      vscode = unstable_pkgs.vscodium;
      vscodeExtensions = with unstable_pkgs.vscode-extensions;
        [
          alefragnani.bookmarks
          adpyke.codesnap
          streetsidesoftware.code-spell-checker
          editorconfig.editorconfig
          usernamehw.errorlens
          tamasfe.even-better-toml
          fill-labs.dependi
          eamodio.gitlens
          mhutchie.git-graph
          yzhang.markdown-all-in-one
          shd101wyy.markdown-preview-enhanced
          pkief.material-icon-theme
          bbenoist.nix
          jnoortheen.nix-ide
          esbenp.prettier-vscode
          alefragnani.project-manager
          ms-vscode-remote.remote-containers
          ms-vscode-remote.remote-ssh
          rust-lang.rust-analyzer
          supermaven.supermaven
          svelte.svelte-vscode
          gruntfuggly.todo-tree
          github.vscode-github-actions
          ecmel.vscode-html-css
          wix.vscode-import-cost
          davidanson.vscode-markdownlint
          bradlc.vscode-tailwindcss
          wakatime.vscode-wakatime
          redhat.vscode-yaml

        ] ++ unstable_pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "dioxus";
            publisher = "DioxusLabs";
            version = "0.6.0";
            sha256 = "UYMJf0F8YjH1s7szIdTDG7t31/xjryD3wxogQM4ywOU=";
          }
          {
            name = "monokai-vibrant-rust";
            publisher = "DioxusLabs";
            version = "0.1.0";
            sha256 = "2KWgFrBEjiHsqBx9xmOLF0s0bdbLalVeVbzBFRvfbB0=";
          }
          {
            name = "triggertaskonsave";
            publisher = "gruntfuggly";
            version = "0.2.17";
            sha256 = "sha256-ax/hkewlH0K+sLkFAvgofD6BjEheRYObAAvt8MA3pqc=";
          }
          {
            name = "vscode-html-css";
            publisher = "ecmel";
            version = "2.0.9";
            sha256 = "fDDVfS/5mGvV2qLJ9R7EuwQjnKI6Uelxpj97k9AF0pc=";
          }
          {
            name = "vscode-todo-highlight";
            publisher = "wayou";
            version = "1.0.5";
            sha256 = "CQVtMdt/fZcNIbH/KybJixnLqCsz5iF1U0k+GfL65Ok=";
          }
        ];
    })

    # ===== Input Method (fcitx5-chewing) ===== #
    gnomeExtensions.kimpanel

    # ===== Customized ===== #
    # A cat clone with syntax highlighting and Git intergration
    bat
    # A modern, maintained replacement for ls
    eza
    # An interactive process viewer
    htop
    # Command-line wrapper for git that makes you better at GitHub
    hub
    # A focused launcher for your desktop
    unstable_pkgs.vicinae
  ];

  users.defaultUserShell = pkgs.zsh;
  # Dynamically linked executable
  programs.nix-ld.enable = true;
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "bureau";
        plugins = [ "git" "npm" "history" "node" "rust" "deno" ];
      };
    };
  };

  fonts = {
    fontDir.enable = true;
    packages = with unstable_pkgs; [
      font-awesome
      nerd-fonts.caskaydia-cove
      nerd-fonts.fira-code
      nerd-fonts.meslo-lg
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji-blob-bin
      source-code-pro
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace =
          [ "Source Code Pro" "Noto Sans Mono TC" "DejaVu Sans Mono" ];
        sansSerif = [ "Noto Sans TC" "DejaVu Sans" ];
        serif = [ "Noto Serif TC" "DejaVu Serif" ];
      };
    };
  };

  system.stateVersion = "25.05";

  # ===== Customized ===== #
  # Power Management
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=yes
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
}
