{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, glib
, dcap
, pcre2
, json_c
, doxygen
, pugixml
, davix-copy
, cryptopp
, libssh2
, xrootd
, gtest
, openldap
, libuuid
}:


stdenv.mkDerivation rec {
  pname = "gfal2";
  version = "2.22.0";

  src = fetchFromGitHub {
    owner = "cern-fts";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "198ql2qa9f8x77x6mhx0g004kyimvf45gy5ikwcx1v1p20avfs33";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    glib
    pcre2.dev
    json_c.dev
    doxygen
    pugixml
    cryptopp.dev
    gtest.dev
    openldap.dev
    libuuid.dev
    xrootd.dev
    davix-copy
    libssh2.dev
    dcap
  ];


  cmakeFlags = [
    "-DPLUGIN_LFC=FALSE"
    "-DPLUGIN_SRM=FALSE"
    "-DPLUGIN_RFIO=FALSE"
    "-DPLUGIN_GRIDFTP=FALSE"
    "-DCRYPTOPP_LOCATION=${cryptopp.dev}/include/cryptopp"
    "-DXROOTD_LOCATION=${xrootd.dev}/include/xrootd"
    "-DGTEST_LOCATION=${gtest.dev}/include/gtest"
  ];


  meta = with lib; {
    description = "Multi-protocol data management library";
    homepage = "https://cern-fts/gfal2";
    maintainers = [ ];
    license = licenses.asl20;
  };
}
