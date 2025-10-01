# ===== @folder <project> ===== #

# https://nixos.wiki/wiki/Rust

let
  rust_overlay = import (fetchTarball
    "https://github.com/oxalica/rust-overlay/archive/master.tar.gz");

  pkgs = import
    (fetchTarball "https://github.com/nixos/nixpkgs/tarball/nixos-25.05") {
      overlays = [ rust_overlay ];
    };

  rust = (pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml);
in with pkgs;

mkShell {
  nativeBuildInputs = [
    cargo-audit
    cargo-cache
    cargo-edit
    cargo-flamegraph
    cargo-llvm-cov
    cargo-make
    cargo-nextest
    cargo-outdated
    cargo-tarpaulin
    cargo-udeps
    cargo-zigbuild
    clippy
    diesel-cli
    llvmPackages.bintools # To use lld
    pkg-config
    rust
    taplo
    trunk
    typos
    wasm-bindgen-cli_0_2_100
    playwright-driver.browsers
  ];
  depsHostHostPropagated = [
    pkgsCross.aarch64-multiplatform.stdenv.cc
    pkgsCross.armv7l-hf-multiplatform.stdenv.cc
    stdenv.cc
  ];
  buildInputs = [
    cargo-expand
    cargo-leptos
    cargo-watch
    commitizen
    cz-cli
    dioxus-cli
    fontconfig
    leptosfmt
    nodejs
    patchelf
    pnpm
    postgresql
    rustywind
    yew-fmt
  ];

  LIBCLANG_PATH = "${libclang.lib}/lib";
  RUST_SRC_PATH = "${rust}/lib/rustlib/src/rust/library";

  CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER =
    let inherit (pkgsCross.aarch64-multiplatform.stdenv) cc;
    in "${cc}/bin/${cc.targetPrefix}cc";

  CARGO_TARGET_AARCH64_UNKNOWN_LINUX_MUSL_LINKER =
    let inherit (pkgsCross.aarch64-multiplatform.stdenv) cc;
    in "${cc}/bin/${cc.targetPrefix}cc";

  CC_armv7_unknown_linux_gnueabihf =
    let inherit (pkgsCross.armv7l-hf-multiplatform.stdenv) cc;
    in "${cc}/bin/${cc.targetPrefix}cc";

  CC_armv7_unknown_linux_musleabihf =
    let inherit (pkgsCross.armv7l-hf-multiplatform.stdenv) cc;
    in "${cc}/bin/${cc.targetPrefix}cc";

  CC_aarch64_unknown_linux_musl =
    let inherit (pkgsCross.aarch64-multiplatform.stdenv) cc;
    in "${cc}/bin/${cc.targetPrefix}cc";

  CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_LINKER =
    let inherit (pkgsCross.armv7l-hf-multiplatform.stdenv) cc;
    in "${cc}/bin/${cc.targetPrefix}cc";

  CARGO_TARGET_ARMV7_UNKNOWN_LINUX_MUSLEABIHF_LINKER =
    let inherit (pkgsCross.armv7l-hf-multiplatform.stdenv) cc;
    in "${cc}/bin/${cc.targetPrefix}cc";

  CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER = let inherit (stdenv) cc;
  in "${cc}/bin/${cc.targetPrefix}cc";

  PLAYWRIGHT_BROWSERS_PATH = "${playwright-driver.browsers}";
  PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true;
  RUSTFMT = "yew-fmt";
}
