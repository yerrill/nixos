{ config, pkgs, lib, inputs, ... }:
let
	cfg = config.myHello;
in {
	imports = [

	];

	options = {
		myHello.enable = lib.mkEnableOption "Enable myHello";	
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [
			pkgs.hello
		];
	};
}
