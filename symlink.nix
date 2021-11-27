{ busybox ? (import <nixpkgs> {}).busybox,
  system ? builtins.currentSystem,
  link, target }: derivation {
    system = system;
    name = "symlink-${builtins.baseNameOf link}-${builtins.baseNameOf target}";
    builder = "${busybox}/bin/sh";
    args = [ ./symlink.sh ];
    dir = let dir = builtins.dirOf link; in if dir == "." then "" else dir;
    inherit link target busybox;
}
