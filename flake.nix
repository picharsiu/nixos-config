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
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.quickshell.follows = "quickshell";  # Use same quickshell version
    };
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    waybar.url = "github:Alexays/Waybar";
  };

  outputs = { self, nixpkgs, home-manager, apple-fonts, nvix, apple-silicon, waybar, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          apple-silicon.nixosModules.default
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
                waybar = waybar.packages.${prev.stdenv.hostPlatform.system}.waybar;
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
