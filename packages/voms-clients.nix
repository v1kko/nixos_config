{ lib, stdenv, fetchurl, openjdk, makeWrapper, coreutils }:

let
  archive = "voms-clients-3.3.2-h27aab58_1.tar.bz2";
in
stdenv.mkDerivation rec{
  pname = "voms-clients";
  version = "3.3.2";

  src = fetchurl {
    url = "https://anaconda.org/conda-forge/${pname}/${version}/download/linux-64/${archive}";
    sha256="a76b6c6aff840fb599585018dc8c96416646c5da73a82e2bce79189d2f3f0708";
  };

  sourceRoot = ".";

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ openjdk ];

  buildPhase = ''sed -i '/placehold_placehold/d' ./bin/*'';

  installPhase = ''
    mkdir -p $out
    cp -r bin $out
    cp -r share $out
  '';

  postFixup = ''
   wrapProgram $out/bin/voms-proxy-init --set PATH ${lib.makeBinPath [ openjdk coreutils]} \
   --set VOMSCLIENTS_LIBS $out/share/voms-clients/lib/voms-clients
   wrapProgram $out/bin/voms-proxy-destroy --set PATH ${lib.makeBinPath [ openjdk coreutils]} \
   --set VOMSCLIENTS_LIBS $out/share/voms-clients/lib/voms-clients
   wrapProgram $out/bin/voms-proxy-info --set PATH ${lib.makeBinPath [ openjdk coreutils]} \
   --set VOMSCLIENTS_LIBS $out/share/voms-clients/lib/voms-clients
  '';

  meta = with lib; {
    description = "Command-line clients for Virtual Organization Membership Service (VOMS)";
    homepage = "https://italiangrid.github.io/voms-clients/";
    license = licenses.asl20;
    maintainers = [ ];
  };
}
