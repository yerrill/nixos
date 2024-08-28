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
		services.xserver.enable = true;
		
		services.displayManager.sddm = {
			enable = true;
			wayland.enable = true;
			theme = "where_is_my_sddm_theme";
		};


		programs.hyprland = {
			enable = true;
			package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
			xwayland.enable = true;
		};

		environment.systemPackages = with pkgs; [
			libnotify waybar dunst swww rofi-wayland networkmanagerapplet
			grim slurp wl-clipboard nwg-look
			where-is-my-sddm-theme
		];

		xdg.portal.enable = true;

		environment.sessionVariables = {
			WLR_NO_HARDWARE_CURSORS = "1";
			NIXOS_OZONE_WL = "1";
		};
	};
}
