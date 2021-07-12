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
      {
        overlays.xemu = final: prev:
          {
            xemu = final.callPackage ./xemu.nix {}; 
          };

        hydraJobs = forAllSystems (system: {
          build = self.defaultPackage.${system};
        });

        defaultPackage = forAllSystems (system:
          let
            pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.xemu ]; };
          in
            pkgs.xemu
        );
      };
}
