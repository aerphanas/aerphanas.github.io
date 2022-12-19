{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let
  haskellDeps = ps: with ps; [
    hakyll
    haskell-language-server
    cabal-install
  ];
  haskellEnv = haskell.packages.ghc902.ghcWithPackages haskellDeps;
in mkShell {
  buildInputs = [
    haskellEnv
  ];
  shellHook = ''
      export PATH=$PATH:$HOME/.cabal/bin/
  '';
}
