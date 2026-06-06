{ pkgs }:

{
	imports = [ ./hardware.nix ];

	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};

		kernelPackages = pkgs.linuxPackages_latest;

		initrd.luks.devices."luks_root".device = "/dev/mapper/vg0_root-root";
	};

	networking = {
		hostName = "nixos";
		networkmanager.enable = true;
	};

	time.timeZone = "Europe/Kyiv";

	i18n.defaultLocale = "en_US.UTF-8";

	environment.systemPackages = [
		just
	];

	system.stateVersion = "26.05";
}
