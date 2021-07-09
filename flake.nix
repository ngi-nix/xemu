{
  inputs = {
    nixpkgs.url = "nixpkgs";
  };

  outputs = { nixpkgs, self }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems' = systems: fun: nixpkgs.lib.genAttrs systems fun;
      forAllSystems = forAllSystems' supportedSystems;
    in
      {
        overlays.xemu = final: prev:
          {
            xemu = final.callPackage ./xemu.nix {}; 
          };

        defaultPackage = forAllSystems (system:
          let
            pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.xemu ]; };
          in
            pkgs.xemu
        );
      };
}
