{
  description = "github:yerrill/nixos config";

  # https://nixos.wiki/wiki/NixOS_modules
  # https://nixos.wiki/wiki/flakes
  # https://nixos.wiki/wiki/Home_Manager

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@attrs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./hosts/desktop/configuration.nix ];
    };
  };
}