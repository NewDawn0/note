{
  description = "A temporary scratch buffer";

  inputs.utils.url = "github:NewDawn0/nixUtils";

  outputs = { self, utils, ... }: {
    overlays.default = final: prev: {
      note = self.packages.${prev.system}.default;
    };
    packages = utils.lib.eachSystem { } (pkgs: {
      default = pkgs.buildGoModule {
        pname = "note";
        version = "1.0.0";
        src = ./.;
        vendorHash = "sha256-kzMvksDjhqKlHvBwl0spOApFKHKM7lm0WG2hifP6+Ro=";
        meta = {
          description = "A lightweight tool for capturing short-term notes";
          longDescription = ''
            This tool is designed for quick note-taking.
            It's perfect for jotting down temporary ideas or reminders from the command line without leaving any clutter.
          '';
          homepage = "https://github.com/NewDawn0/note";
          license = pkgs.lib.licenses.mit;
          maintainers = with pkgs.lib.maintainers; [ NewDawn0 ];
          platforms = pkgs.lib.platforms.all;
        };
      };
    });
  };
}
