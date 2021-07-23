{ stdenv
, fetchFromGitHub

, SDL2
, readline
, lib
}:
let
  version = "c07caa063a0c070759863d41ecb6094271417ae2";
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

  patches = [ ./patches/0001-Make-INSTALL_BINDIR-configurable.patch ];
  
  makeFlagsArray = [ "INSTALL_BINDIR=\${out}/bin" ];

  buildInputs = [ SDL2.dev readline.dev ];

  meta = with lib; {
    homepage = "https://github.com/lgblgblgb/xemu/";
    description = "Emulations of some - mainly - 8 bit machines, including the Commodore LCD, Commodore 65, and the MEGA65 as well.";
    license = licenses.gpl2Only;
    platforms = platforms.unix;
    maintainers = with maintainers; [ magic_rb ];
    mainProgram = "xemu-xc65";
  };

  enableParallelBuilding = true;
}
