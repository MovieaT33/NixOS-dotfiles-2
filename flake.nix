{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }: let
	  system = "x86_64-linux";
	  stateVersion = "26.11";
	in {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;

			modules = [
				./modules/boot.nix
				./modules/config.nix
				./modules/hardware.nix
				./modules/system.nix
			];
		};
	};
}
