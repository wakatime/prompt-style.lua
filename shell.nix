{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
let
  packages = (
    p: with p; [
      ansicolors
      argparse
      luafilesystem
      luaprompt

      busted
      ldoc
    ]
  );
in
mkShell rec {
  name = "prompt-style.lua";
  buildInputs = [
    (lua5_3.withPackages packages)
    (luajit.withPackages packages)
    neovim
    pandoc
    texlive.combined.scheme-full
  ];
  shellHook = ''
    export LUAINPUTS_luatex="${./.}/lua;${builtins.elemAt buildInputs 0}/share/lua/5.3"
    export CLUAINPUTS_luatex="${builtins.elemAt buildInputs 0}/lib/lua/5.3"
    export LUAINPUTS_luajittex="${./.}/lua;${builtins.elemAt buildInputs 1}/share/lua/5.1"
    export CLUAINPUTS_luajittex="${builtins.elemAt buildInputs 1}/lib/lua/5.1"

    export LUAINPUTS_luahbtex="$LUAINPUTS_luatex"
    export CLUAINPUTS_luahbtex="$CLUAINPUTS_luatex"
    export LUAINPUTS_luajithbtex="$LUAINPUTS_luajittex"
    export CLUAINPUTS_luajithbtex="$CLUAINPUTS_luajittex"
  '';
}
