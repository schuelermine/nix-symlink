{
  description = "Create a derivation containing a single symlink.";
  outputs = { ... }: { symlink = import ./symlink.nix; };
}
