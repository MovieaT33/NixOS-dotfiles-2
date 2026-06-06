{ config, pkgs, ... }:

{
	boot = {
		initrd = {
			luks.devices."luks_root".device = "/dev/vda2";
			availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
			kernelModules = [ "dm-snapshot" ];
		};

		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};

		kernelPackages = pkgs.linuxPackages_latest;
		kernelModules = [ "kvm-intel" ];
		extraModulePackages = [ ];
	};
}
