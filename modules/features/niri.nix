{ self, inputs, ... }: {
	flake.nixosModule.niri = { pkgs, ... }: {
		programs.niri = {
			enable = true;
			package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
		};
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
