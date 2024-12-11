{ pkgs ? import <nixpkgs> { } }:

with pkgs;
mkShell {
  name = "prompt-style.lua";
  buildInputs = [
    (luajit.withPackages (
      p: with p; [
        luaprompt
        ldoc
        discount
      ]
    ))
  ];
}
