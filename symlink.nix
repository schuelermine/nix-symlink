{ busybox ? (import <nixpkgs> { }).busybox, system ? builtins.currentSystem
, link, target, link-name ? link, target-name ? target }:
derivation {
  system = system;
  name = "symlink-${builtins.baseNameOf link-name}-${
      builtins.baseNameOf target-name
    }";
  builder = "${busybox}/bin/sh";
  args = [ ./symlink.sh ];
  dir = let dir = builtins.dirOf link; in if dir == "." then "" else dir;
  inherit link target busybox;
}
