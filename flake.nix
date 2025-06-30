{
  description = "NixOS System Flake";

  # channels to pull source/packages from.
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs: {
    # Configure nixos as defined below.
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        stylix.nixosModules.stylix # import stylix module.
        ./configuration.nix # import everything in configuration.nix (which in turn imports hardware-configuration.nix).
        home-manager.nixosModules.home-manager # import home-manager module.
        {
          # home manager configuration
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # user-specific configuration
          home-manager.users."apl" = {
            imports = [ ./apl_home.nix ]; # home.nix file for my user account.
          };
        }
      ];
    };
  };
}

