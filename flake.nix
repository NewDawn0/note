{
  description = "A temporary scratch buffer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nix-systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
    in {
      overlays.default =
        (final: prev: { note = self.packages.${prev.system}.default; });
      packages = eachSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
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
