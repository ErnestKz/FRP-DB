{ nixpkgs ? import (import ./nix/sources.nix).nixpkgs {}, compiler ? "default", doBenchmark ? false }:
let
  inherit (nixpkgs) pkgs;
  f = ./default.nix;
  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};
  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;
  drv = variant ((haskellPackages.callPackage f) {});
in
  if pkgs.lib.inNixShell then drv.env else drv
