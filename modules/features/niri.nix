{ self, inputs, ... }: {
	flake.nixosModule.niri = { pkgs, ... }: {
		programs.niri = {
			enable = true;
			package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
		};
	};

	perSystem = { pkgs, lib, ... }: {
		packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
			inherit pkgs;
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
	};
}
