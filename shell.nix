{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
mkShell rec {
  name = "prompt-style.lua";
  buildInputs = [
    (lua5_3.withPackages (
      p: with p; [
        ansicolors
        argparse
        luafilesystem
        luaprompt

        busted
        ldoc
      ]
    ))
  ];
  shellHook = ''
    export LUAINPUTS_luatex='lua;${builtins.elemAt buildInputs 0}/share/lua/5.3'
    export CLUAINPUTS_luatex='${builtins.elemAt buildInputs 0}/lib/lua/5.3'
    export LUAINPUTS_luahbtex="$LUAINPUTS_luatex"
    export CLUAINPUTS_luahbtex="$CLUAINPUTS_luatex"
  '';
}
