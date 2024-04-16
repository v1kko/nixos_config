{ lib, stdenv, fetchFromGitHub, curl, webkitgtk, libmicrohttpd, libsecret, qrencode, libsodium, pkg-config, help2man }:

stdenv.mkDerivation rec {
  pname = "oidc-agent";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "indigo-dc";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "sha256-cOK/rZ/jnyALLuhDM3+qvwwe4Fjkv8diQBkw7NfVo0c=";
  };

  buildInputs = [
    pkg-config
    help2man
  ];
  nativeBuildInputs = [
    curl
    webkitgtk
    libmicrohttpd
    libsecret
    qrencode
    libsodium
  ];

  installPhase = ''
    make install_bin PREFIX=$out BIN_PATH=$out
    make install_lib PREFIX=$out LIB_PATH=$out/lib
    make install_conf install_bash install_scheme_handler install_xsession_script PREFIX=$out
  '';
  postFixup = ''
    cp -r $out/bin/* bin
    make install_man PREFIX=$out
  '';


  meta = with lib; {
    description = "oidc-agent for managing OpenID Connect tokens on the command line";
    homepage = "https://github.com/indigo-dc/oidc-agent";
    maintainers = [ ];
    license = licenses.mit;
  };
}
