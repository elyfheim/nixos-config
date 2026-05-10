{ config, pkgs, ... }:
{
  home.username = "jun";
  home.homeDirectory = "/home/jun";
  home.stateVersion = "25.11";
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 20;
  };

  programs.bash = {
    enable = true;
    profileExtra = ''
      			if uwsm check may-start; then
      				exec uwsm start mango-uwsm.desktop
      			fi
      		'';
  };

  home.file.".config/starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/starship.toml";
  home.file.".config/fish/config.fish".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/fish/config.fish";

  home.file.".config/fastfetch/config.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/fastfetch/config.jsonc";
  home.file.".config/mango".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/mango";
  home.file.".config/kitty".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/kitty";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/nvim";
  home.file.".config/quickshell".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/quickshell";

}
