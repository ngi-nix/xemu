{ stdenv
, fetchFromGitHub

, SDL2
, readline
}:
let
  version = "master";
  pname = "xemu";
in
stdenv.mkDerivation {
  inherit version pname;

  src = fetchFromGitHub {
    owner = "lgblgblgb";
    repo = pname;
    rev = version;
    sha256 = "sha256-IZT92W4/U+rcWDk4N8PrfHez/ndzpZBzQxriOveFnG4=";
  };

  postUnpack = ''
    sed -i 's/INSTALL_BINDIR[[:space:]]*=[[:space:]]*\/usr\/local\/bin/INSTALL_BINDIR := \/usr\/local\/bin/' source/build/Makefile.common
  '';

  makeFlagsArray = [ "INSTALL_BINDIR=\${out}/bin" ];

  buildInputs = [ SDL2.dev readline.dev ];
}
