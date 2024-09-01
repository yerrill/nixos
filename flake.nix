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
		hm = {
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
			home-manager.backupFileExtension = "hmmoved";

			home-manager.users.zach = { pkgs, inputs, ... }: {
				imports = [
					./home-manager
				];

				home.username = "zach";
				home.homeDirectory = "/home/zach";
				programs.home-manager.enable = true;

				hmhyprland.enable = true;

				home.packages = with pkgs; [
					thunderbird
					discord
					spotify
				];

				programs.git = {
					enable = true;
					userName = "Zach Yerrill";
					userEmail = "26354308+yerrill@users.noreply.github.com";
				};
				
				home.stateVersion = "24.05";
			};
			
		};
	in {
		nixosConfigurations = {
			desktop = nixpkgs.lib.nixosSystem {
				system = "${system}";
				specialArgs = { inherit inputs outputs; };
				modules = [
					./hosts/desktop/configuration.nix
					./modules
					home-manager.nixosModules.home-manager
					hm
				];
			};

			laptop = nixpkgs.lib.nixosSystem {
				system = "${system}";
				specialArgs = { inherit inputs outputs; };
				modules = [
					./hosts/laptop/configuration.nix
					./modules
					home-manager.nixosModules.home-manager
					hm
				];
			};
		};

	nixosModules = import ./modules;

	};
}
