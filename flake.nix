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
    waybar.url = "github:Alexays/Waybar/456f78ecb1cf16e5397a29691e69fc2906843387";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          inputs.apple-silicon.nixosModules.apple-silicon-support
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
          {
            nixpkgs.overlays = [
              (final: prev: {
                waybar = inputs.waybar.packages.${prev.stdenv.hostPlatform.system}.waybar;
              })
            ];
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
