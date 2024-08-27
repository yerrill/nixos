{
	description = "github:yerrill/nixos config";

	# https://nixos.wiki/wiki/NixOS_modules
	# https://nixos.wiki/wiki/flakes

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
	};

	outputs = { self, nixpkgs, home-manager, ... } @ inputs:
	let
		inherit (self) outputs;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations = {
			desktop = nixpkgs.lib.nixosSystem {
				system = "${system}";
				specialArgs = { inherit inputs outputs; };
				modules = [
					./hosts/desktop/configuration.nix
					./modules
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.backupFileExtension = "hmmoved";

						home-manager.users.zach = { pkgs, inputs, ... }: {
							imports = [
								./home-manager
							];

							home.username = "zach";
							home.homeDirectory = "/home/theNameOfTheUser";
							home-manager.backupFileExtension = "hmmoved";
							programs.home-manager.enable = true;

							hmhyprland.enable = true;

							home.packages = with pkgs; [
								thunderbird
								discord
								spotify
							];

							home.stateVersion = "24.05";
						};
					}
				];
			};

			laptop = nixpkgs.lib.nixosSystem {
				system = "${system}";
				specialArgs = { inherit inputs outputs; };
				modules = [
					./hosts/laptop/configuration.nix
					./modules
					home-manager.nixosModules.default
				];
			};
		};

	nixosModules = import ./modules;

	};
}
