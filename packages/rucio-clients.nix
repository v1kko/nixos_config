{ lib, stdenv, python3Packages }:

with python3Packages;
buildPythonApplication rec {
  pname = "rucio-clients";
  version = "34.1.0";
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-0GuNo338Ry+uBfhmbHvpBt7/Va/7Fm3eLECb/x8535c=";
  };
  
  propagatedBuildInputs = [ tabulate requests urllib3 dogpile-cache jsonschema ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://rucio.cern.ch";
    description = "Rucio clients";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
  };
}
