(import ./symlink.nix) {
    busybox = (import <nixpkgs> {}).busybox;
    system = builtins.currentSystem;
}