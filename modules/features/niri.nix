{ self, inputs, ... }: {
	flake.nixosModules.niri = { pkgs, ... }: {
		programs.niri.enable = true;
	};

	perSystem = { pkgs, lib, ... }: {
		packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
			inherit pkgs;

			settings = {
				input.keyboard = {
					xkb.layout = "us,ua";
				};

				binds = {
					"T".spawn-sh = lib.getExe pkgs.kitty;
				};
			};
		};
	};
}
