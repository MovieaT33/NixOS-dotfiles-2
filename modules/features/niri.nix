{ self, inputs, ... }: {
	perSystem = { pkgs, lib, ... }: {
		packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
			settings = {
				input.keyboard = {
					xkb.layout = "us,ua";
				};

				layout.gaps = 5;

				binds = {
					"T".spawn-sh = lib.getExe pkgs.kitty;
				};
			};
		};
	}
}
