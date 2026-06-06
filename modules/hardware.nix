{ config, pkgs, ... }:

{
	fileSystems = {
		"/boot" = {
			device = "/dev/disk/by-uuid/B86F-160E";
			fsType = "vfat";

		};
		"/home" = {
			device = "/dev/mapper/vg0_root-home";
			fsType = "ext4";
		};

		"/" = {
			device = "/dev/mapper/vg0_root-root";
			fsType = "ext4";
		};
	};

	swapDevices = [
		{ device = "/dev/mapper/vg0_root-swap"; }
	];
}
