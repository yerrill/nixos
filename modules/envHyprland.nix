{ config, pkgs, lib, inputs, ... }:
let
	cfg = config.envHyprland;
in {
	imports = [

	];

	options = {
		envHyprland.enable = lib.mkEnableOption "Enable Hyprland window manager / environment";	
	};

	config = lib.mkIf cfg.enable {
		programs.hyprland = {
			enable = true;
			package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
			xwayland.enable = true;
		};

		environment.systemPackages = with pkgs; [
			libnotify waybar dunst swww rofi-wayland networkmanagerapplet
		];
	};
}
