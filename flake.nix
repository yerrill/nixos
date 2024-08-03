{
  description = "github:yerrill/nixos config";

  # https://nixos.wiki/wiki/NixOS_modules
  # https://nixos.wiki/wiki/flakes
  # https://nixos.wiki/wiki/Home_Manager

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs outputs; };
      modules = [ ./hosts/desktop/configuration.nix ];
    };
    
    homeConfigurations."zach" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

	extraSpecialArgs = { inherit inputs outputs;};

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
    };
  };
}
