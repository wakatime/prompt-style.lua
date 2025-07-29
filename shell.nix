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
mkShell {
  name = "prompt-style.lua";
  buildInputs = [
    (luajit.withPackages packages)
    neovim

    (lua5_4.withPackages packages)
    pandoc
  ];
}
