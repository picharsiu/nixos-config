{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    nvix.url = "github:picharsiu/nvix/backup";
    apple-silicon.url = "github:nix-community/nixos-apple-silicon";
    firefox-gnome-theme = { url = "github:rafaelmardojai/firefox-gnome-theme"; flake = false; };
    # waybar.url = "github:Alexays/Waybar";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    oniri.url = "github:picharsiu/oniri";
    steam-asahi.url = "github:sm-idk/steam-asahi";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          inputs.apple-silicon.nixosModules.apple-silicon-support
          inputs.nix-flatpak.nixosModules.nix-flatpak
          inputs.steam-asahi.nixosModules.default {
            programs.steam-asahi = {
              enable = true;
              # Optional: on 8 GiB machines this leaves the compositor headroom.
              memoryMiB = 6144;
            };
          }
          ./configuration.nix
          ./fonts.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.picharsiu = ./home-manager/home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
          #{
          #  nixpkgs.overlays = [
          #    (final: prev: {
          #      waybar = inputs.waybar.packages.${prev.stdenv.hostPlatform.system}.waybar;
          #    })
          #  ];
          #}
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
