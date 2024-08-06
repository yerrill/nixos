{ config, pkgs, ... }:
{
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_US.UTF-8";
	
	users.users.zach = {
		description = "Zach";
		isNormalUser = true;
		initialPassword = "12345";
		extraGroups = [ "wheel" "networkmanager" ];
		packages = with pkgs; [
			discord spotify
		];
	};

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		curl wget tree kitty
	];

	programs.git.enable = true;

	programs.firefox.enable = true;

	programs.neovim.enable = true;
}
