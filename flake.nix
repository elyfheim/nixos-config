{
  description = "Hyprland + NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.ps42 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/ps42-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.elyfheim = import ./machines/ps42.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
      nixosConfigurations.m8 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/m8-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.elyfheim = import ./machines/m8.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}
