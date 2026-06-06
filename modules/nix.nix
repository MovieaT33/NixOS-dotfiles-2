{ config, pkgs, ... }:

{
	nixpkgs.hostPlatform = "x86_64-linux";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
