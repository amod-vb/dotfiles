{
  description = "A flake template for nix-darwin and Determinate Nix";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:amodkala/catppuccin-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs
  outputs =
    { self, ... }@inputs:
    let
      # Darwin modules
      darwinModules = [
        ./modules/darwin.nix
        {
          nixpkgs.overlays = [
            inputs.neovim-nightly-overlay.overlays.default
          ];
        }
      ];

      determinateDarwinModules = [
        ./modules/determinate.nix
        inputs.determinate.darwinModules.default
      ];

      homeManagerDarwinModules = [
        ./modules/home-manager-darwin.nix
        {
          home-manager.users.amodkala.imports = [ inputs.catppuccin.homeModules.catppuccin ];
        }
        inputs.home-manager.darwinModules.home-manager
      ];

      # NixOS modules
      nixosModules = [
        ./modules/nixos
        {
          nixpkgs.overlays = [
            inputs.neovim-nightly-overlay.overlays.default
          ];
        }
      ];

      determinateNixosModules = [
        inputs.determinate.nixosModules.default
      ];

      homeManagerNixosModules = [
        ./modules/home-manager-vm.nix
        {
          home-manager.users.amod.imports = [ inputs.catppuccin.homeModules.catppuccin ];
        }
        inputs.home-manager.nixosModules.home-manager
      ];

      # Shared modules
      remoteBuilderModules = [
        ./modules/remote-builders.nix
      ];
    in
    {
      # NixOS VM configuration
      nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = nixosModules ++ determinateNixosModules ++ homeManagerNixosModules ++ remoteBuilderModules;
      };

      # nix-darwin configuration
      darwinConfigurations.mac = inputs.nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = darwinModules ++ determinateDarwinModules ++ homeManagerDarwinModules ++ remoteBuilderModules;
      };
    };
}
