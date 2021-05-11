with import ./stackyaml.nix {};

let
  gitRev = path:
    builtins.readFile (pkgs.runCommand "git" { preferLocalBuild = true; } ''
      ${pkgs.git}/bin/git -C ${builtins.toString path} rev-parse --verify HEAD > $out
    '').out;
in { inherit gitRev; }