{ mkDerivation
, stdenv
, base
, haskell-language-server
, reflex
, niv
, time
, random
}:

mkDerivation {
  pname = "frp-db";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base
    reflex
    time
    random
  ];
  buildTools = [
    haskell-language-server
    niv
  ];
  license = "MIT";
  hydraPlatforms = stdenv.lib.platforms.none;
}
