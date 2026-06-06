{ config, pkgs, ... }:

{
	boot = {
		initrd = {
			availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
			kernelModules = [ "dm-snapshot" ];
		};
		kernelModules = [ "kvm-intel" ];
		extraModulePackages = [ ];
	};

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

	nixpkgs.hostPlatform = "x86_64-linux";
}
