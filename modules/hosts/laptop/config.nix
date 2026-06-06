{ self, inputs, ... }: {
	flake.nixosModules.laptopConfig = { config, pkgs, ... }: {
		imports = [
			self.nixosModules.laptopHardware
			self.nixosModules.niri
		];

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

		system.stateVersion = "26.11";
		nix.settings.experimental-features = [ "nix-command" "flakes" ];

		time.timeZone = "Europe/Kyiv";

		i18n.defaultLocale = "en_US.UTF-8";

		users.users = {
			"mvt33" = {
				isNormalUser = true;
			};
		};

		security = {
			sudo.enable = false;
			doas = {
				enable = true;
				extraRules = [
					users = [ "mvt33" ];
					keepEnv = true;
				];
			};
		};

		networking = {
			hostName = "nixos";
			networkmanager.enable = true;
		};

		environment.systemPackages = with pkgs; [
			git
			just
			neovim
		];

		services = {
			xserver.enable = true;
			displayManager.sddm = {
				enable = true;
				wayland.enable = true;
			};
			desktopManager.plasma6.enable = true;
		};
	};
}
