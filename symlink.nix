{ system ? builtins.currentSystem, utils ? (import <nixpkgs> { }).busybox
, shell ? "${(import <nixpkgs> { }).busybox}/bin/sh", link, target
, link-label ? link, target-label ? target }:
derivation {
  system = system;
  name = "symlink-${builtins.baseNameOf link-label}-${
      builtins.baseNameOf target-label
    }";
  builder = shell;
  args = [ ./symlink.sh ];
  dir = let dir = builtins.dirOf link; in if dir == "." then "" else dir;
  inherit link target utils;
}
