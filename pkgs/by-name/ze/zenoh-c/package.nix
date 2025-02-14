{
  lib,
  stdenv,
  fetchFromGitHub,

  # nativeBuildInputs
  cmake,
  rustPlatform,
  rustc,
  cargo,

  # flags
  enableSharedMemory ? true,
  enableUnstableApi ? true,
}:

stdenv.mkDerivation rec {
  pname = "zenoh-c";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "eclipse-zenoh";
    repo = "zenoh-c";
    rev = "refs/tags/${version}";
    hash = "sha256-7WUy7TcsAKeG8a58bTvhM4vso8FVfbWyqxcwQRtoWCk=";
  };

  nativeBuildInputs = [
    cmake
    rustPlatform.cargoSetupHook
    rustc
    cargo
  ];

  patches = [
    ./cmake-absolute-install-path.patch
  ];

  cmakeFlags = [
    (lib.cmakeBool "ZENOHC_BUILD_WITH_SHARED_MEMORY" enableSharedMemory)
    (lib.cmakeBool "ZENOHC_BUILD_WITH_UNSTABLE_API" enableUnstableApi)
  ];

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = "sha256-XQJ6XpJjf2cj/zfdE94QZ515SW2c3XGJHAzrtkxwykY=";
  };

  meta = {
    description = "C bindings for the Zenoh pub/sub/query protocol";
    homepage = "https://zenoh.io";
    license = with lib.licenses; [
      asl20
      epl20
    ];
    platform = lib.platforms.all;
  };
}
