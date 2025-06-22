{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    nvix.url = "github:picharsiu/nvix";
    apple-silicon.url = "github:nix-community/nixos-apple-silicon";
  };

  outputs = { self, nixpkgs, home-manager, apple-fonts, nvix, apple-silicon, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          apple-silicon.nixosModules.default
          ./configuration.nix
	        ./fonts.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.picharsiu = ./home-manager/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
