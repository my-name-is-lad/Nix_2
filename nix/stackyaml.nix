{
  haskellNix ? import (builtins.fetchTarball "https://github.com/input-output-hk/haskell.nix/archive/b0d03596f974131ab64d718b98e16f0be052d852.tar.gz") {}
, nixpkgsSrc ? haskellNix.sources.nixpkgs-2009
, nixpkgsArgs ? haskellNix.nixpkgsArgs
, pkgs ? import nixpkgsSrc nixpkgsArgs
}:

let
  sourceCode = pkgs.haskell-nix.haskellLib.cleanGit {
    name = "hello-world";
    src = ../.;
    keepGitDir = true;
  };
  project = pkgs.haskell-nix.stackProject {
    name = "hello-world";
    src = sourceCode;

    modules = [{
      doCheck = false;
    }];
  };

in { inherit project; inherit sourceCode; inherit pkgs; }
