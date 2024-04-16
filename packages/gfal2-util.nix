{ lib, python3Packages, python3, fetchFromGitHub, gfal2 }:

with python3Packages;

buildPythonPackage rec {
  pname = "gfal2-util";
  version = "1.8.0";

  src = fetchFromGitHub {
    owner = "cern-fts";
    repo  = "${pname}";
    rev="v${version}";
    hash="sha256-ruFvnraF5oNe3qP76j6XqmWAEg3TR7N+bDGYTrG/p1o=";
  };

  buildInputs = [ gfal2 ];

  postInstall = ''
   sed -i 's~/usr/bin/python~${python3}/bin/python3~g' $out/bin/*
  '';



  meta = with lib; {
    description = "CLI for gfal2";
    homepage = "https://cern-fts/gfal2";
    maintainers = [];
    license = licenses.asl20;
  };
}
