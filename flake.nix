{
  inputs = {
    nixpkgs.url = "nixpkgs";
  };

  outputs = { nixpkgs, self }:
    let
      supportedSystems = [ "x86_64-linux" "i686-linux" "aarch64-linux" ];
      forAllSystems' = systems: fun: nixpkgs.lib.genAttrs systems fun;
      forAllSystems = forAllSystems' supportedSystems;
    in
      with nixpkgs.lib;
      {
        overlays.xemu = final: prev:
          {
            xemu = final.callPackage ./xemu.nix {}; 
          };

        overlay = self.xemu.overlay;

        packages = forAllSystems (system:
          { xemu = self.defaultPackage.${system}; }
        );

        defaultPackage = forAllSystems (system:
          let
            pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.xemu ]; };
          in
            pkgs.xemu
        );

        devShell = forAllSystems (system:
          let
            pkgs = import nixpkgs { inherit system; overlays = mapAttrsToList (_: id) self.overlays; };
          in
            pkgs.mkShell {
              buildInputs = with pkgs; [
                readline
                SDL2
              ];
            }
        );

        hydraJobs = forAllSystems (system: {
          build = self.defaultPackage.${system};
        });
      };
}
