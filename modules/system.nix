{ config, pkgs, stateVersion, system, ... }:

{
	system.stateVersion = stateVersion;
	nixpkgs.hostPlatform = system;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
