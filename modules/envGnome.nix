{ config, pkgs, lib, inputs, ... }:
let
	cfg = config.envGnome;
in {
	imports = [

	];

	options = {
		envGnome.enable = lib.mkEnableOption "Enable Gnome desktop environment";	
	};

	config = lib.mkIf cfg.enable {
		services.xserver.enable = true;
		services.xserver.displayManager.gdm.enable = true;
		services.xserver.desktopManager.gnome.enable = true;

		services.xserver.xkb = {
			layout = "us";
			variant = "";
		};
	};
}
