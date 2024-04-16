{ lib, stdenv, python3Packages, fetchFromGitHub, gfal2, cmake, glib, pcre2, pkg-config}:

with python3Packages;

buildPythonPackage rec {
  format="setuptools";
  pname = "gfal2-python";
  version = "1.12.1";

  src = fetchFromGitHub {
    owner = "cern-fts";
    repo  = "${pname}";
    rev="v${version}";
    hash="sha256-Q070sDLGtsAbY3x6zJxOiTw45+9WxBvyjIlQRoyfub0=";
  };

  dontUseCmakeConfigure="true";
  nativeBuildInputs = [ cmake pkg-config glib.dev];
  buildInputs = [ glib gfal2 pcre2 boost];

  meta = with lib; {
    description = "Multi-protocol data management library";
    homepage = "https://cern-fts/gfal2";
    maintainers = [];
    license = licenses.asl20;
  };
}
