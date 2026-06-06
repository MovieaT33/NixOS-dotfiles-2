{ config, pkgs, ... }:

{
	imports = [ ./hardware.nix ];

	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};

		kernelPackages = pkgs.linuxPackages_latest;

		initrd.luks.devices."luks_root".device = "/dev/vda2";
	};

	networking = {
		hostName = "nixos";
		networkmanager.enable = true;
	};

	time.timeZone = "Europe/Kyiv";

	i18n.defaultLocale = "en_US.UTF-8";

	environment.systemPackages = with pkgs; [
		git
		just
		neovim
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	system.stateVersion = "26.05";
}
