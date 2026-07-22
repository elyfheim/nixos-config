# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware/hardware-m8.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # bluetooth stuff
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    # terminal
    foot
    fish
    starship

    # development tools
    zig
    gcc
    clang
    rustc
    cargo
    gnumake
    emscripten
    tectonic
    nodejs
    pnpm
    typescript
    tree-sitter

    # language servers & formatters
    lua-language-server
    stylua
    nil
    typescript-language-server
    astro-language-server
    clang-tools
    rust-analyzer
    kdePackages.qtdeclarative # qml language server
    zls

    # tools
    ripgrep
    wget
    git
    fastfetch
    hyfetch
    unzip
    p7zip
    tokei
    file
    fzf
    zoxide
    yt-dlp
    btop
    bluetui
    eza

    # file manager
    yazi

    # audio related
    pwvucontrol
    mpd
    rmpc

    # editor
    vim
    neovim
    helix

    # browser
    brave

    # desktop
    swaybg
    quickshell

    # screenshot
    grim
    slurp
    satty

    # clipboard
    wl-clipboard

    # multimedia
    tdf
    mpv
    vlc
    qimgv
    libresprite
  ];

  services.getty.autologinUser = "elyfheim";

  # automount drives
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.devmon.enable = true;

  services.upower.enable = true;

  # enable various programs
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
    ];
  };

  programs.mango.enable = true;
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      mango = {
        prettyName = "Mango";
        comment = "Wayland Compositor";
        binPath = "/run/current-system/sw/bin/mango";
      };
    };
  };

  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      		Host github.com
      			IdentityFile ~/.ssh/id_github
      		Host codeberg.org
      			IdentityFile ~/.ssh/id_codeberg
      	'';
  };

  # setup audio stuff
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc # Japanese Input Engine
      fcitx5-bamboo # Korean Input Engine
    ];
  };

  # 2. Add necessary locales
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
    "ko_KR.UTF-8/UTF-8"
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.elyfheim = {
    isNormalUser = true;
    description = "elyfheim";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    inter
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11"; # Did you read the comment?
}
