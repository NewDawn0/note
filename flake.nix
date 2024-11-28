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
            name = "note";
            src = ./.;
            vendorHash = "sha256-kzMvksDjhqKlHvBwl0spOApFKHKM7lm0WG2hifP6+Ro=";
            meta = with pkgs.lib; {
              description = "A tool for taking temporary notes";
              homepage = "https://github.com/NewDawn0/note";
              maintainers = with maintainers; [ NewDawn0 ];
              license = licenses.mit;
            };
          };
        });
    };
}
