{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let
  haskellDeps = ps: with ps; [
    base
    hakyll
    haskell-language-server
  ];
  haskellEnv = haskell.packages.ghc924.ghcWithPackages haskellDeps;
in mkShell {
  buildInputs = [
    haskellEnv
    haskellPackages.cabal-install
  ];
  shellHook = ''
      export PATH=$PATH:$HOME/.cabal/bin/
  '';
}
