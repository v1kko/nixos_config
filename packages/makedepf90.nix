{ lib, stdenv, fetchFromGitHub, pkgs }:

stdenv.mkDerivation rec {
  pname = "makedepf90";
  version = "2.8.8";

  src = fetchFromGitHub {
    owner = "v1kko";
    repo  = "makedepf90";
    rev="1f3ba6915a4289e6b421d873e84bdb86c224a4dc";
    sha256="1bmc47cwbdpyvqbfi1vkw7lnhzsrshb7xxdmlv1rpyqjzrp489rs";
  };

  nativeBuildInputs = with pkgs; [ autoconf gcc yacc flex];

  installPhase = ''
    mkdir -p $out/bin
    cp makedepf90 $out/bin
  '';

  doCheck = false;

  meta = with lib; {
    description="makedepf90, an old time classic dpendency tree generator for Fortran files";
    homepage = "doesn't exist anymore";
    license = "gpl1Only";
    maintainers = [ ];
  };
}
