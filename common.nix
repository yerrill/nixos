{ config, pkgs, inputs, ... }:
{
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_US.UTF-8";
	
	users.users.zach = {
		description = "Zach";
		isNormalUser = true;
		initialPassword = "12345";
		extraGroups = [ "wheel" "networkmanager" ];
	};

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		curl wget tree kitty
		gcc
		zig
	];

	programs.git.enable = true;

	programs.firefox.enable = true;

	programs.neovim.enable = true;

	fonts.packages = with pkgs; [
		nerdfonts
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		liberation_ttf
		fira-code
		fira-code-symbols
		mplus-outline-fonts.githubRelease
		dina-font
		proggyfonts
	];
}
