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
    ./hardware/hardware-ps42.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    # terminal
    kitty
    fish
    starship

    # development tools
    zig
    gcc
    gnumake
    nodejs
    tree-sitter

    # language servers & formatters
    lua-language-server
    stylua
    nil
    typescript-language-server
    clang-tools
    kdePackages.qtdeclarative # qml language server

    # tools
    ripgrep
    wget
    git
    fastfetch
    unzip
    p7zip
    tokei
    file
    fzf
    zoxide
    yt-dlp

    # mount drives
    udisks2
    udiskie

    # file manager
    yazi

    # audio related
    pwvucontrol
    mpd
    rmpc

    # editor
    vim
    neovim

    # browser
    brave

    # desktop
    awww
    quickshell
  ];

  services.getty.autologinUser = "jun";

  services.udisks2.enable = true;
  services.upower.enable = true;

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

  # Enable the uinput module
  boot.kernelModules = [ "uinput" ];

  # Enable uinput
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = { };

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
            caps nonusbslash lalt lctrl
          )
          (deflayer base
            esc ret lctrl lalt
          )
        '';
      };
    };
  };

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jun = {
    isNormalUser = true;
    description = "jun";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    noto-fonts
    noto-fonts-cjk-sans
    inter
  ];

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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
