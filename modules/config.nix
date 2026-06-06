{ config, pkgs, ... }:

{
	networking = {
		hostName = "nixos";
		networkmanager.enable = true;
	};

	time.timeZone = "Europe/Kyiv";

	i18n.defaultLocale = "en_US.UTF-8";

  users.users = {
    "mvt33" = {
      isNormalUser = true;
    };
  };

	environment.systemPackages = with pkgs; [
		git
		just
		neovim
	];

	programs.niri.enable = true;

	services.displayManager.gdm = {
		enable = true;
		wayland = true;
	};
}
