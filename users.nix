{ config, pkgs, ... }:
{
	users.users.zach = {
		description = "Zach user";
		isNormalUser = true;
		initialPassword = "12345";
		extraGroups = [ "wheel" "networkmanager" ];
		packages = with pkgs; [
			discord spotify
		];
	};
}
