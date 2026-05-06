{ config, pkgs, ... }:
{
  home.username = "elyfheim";
  home.homeDirectory = "/home/elyfheim";
  home.stateVersion = "25.11";
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 20;
  };

  programs.bash = {
    enable = true;
    # profileExtra = ''
    #   			if uwsm check may-start; then
    #   				exec uwsm start hyprland-uwsm.desktop
    #   			fi
    #   		'';
    profileExtra = ''
      			exec mango
      		'';
  };

  home.file.".config/starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/starship.toml";
  home.file.".config/fish/config.fish".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/fish/config.fish";
  home.file.".config/hypr".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/hypr";
  home.file.".config/mango".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/mango";
  home.file.".config/kitty".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/kitty";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/nvim";
  home.file.".config/quickshell".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/quickshell";
  home.file.".config/mpd/mpd.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/mpd/mpd.conf";
}
