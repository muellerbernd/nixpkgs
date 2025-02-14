{
  lib,
  stdenv,
  fetchFromGitHub,
  # nativeBuildInputs
  cmake,
  zenoh-c,
}:
stdenv.mkDerivation rec {
  pname = "zenoh-cpp";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "eclipse-zenoh";
    repo = "zenoh-cpp";
    rev = "refs/tags/${version}";
    hash = "sha256-fKV87BQZsxVykfWiy0WwaVTFKrKsZjPXxrLbHZ/rd5M=";
  };

  nativeBuildInputs = [
    cmake
    zenoh-c
  ];

  patches = [
    ./cmake-absolute-install-path.patch
  ];

  meta = {
    description = " C++ API for zenoh Resources";
    homepage = "https://zenoh.io";
    license = with lib.licenses; [
      asl20
      epl20
    ];
    platform = lib.platforms.all;
  };
}
