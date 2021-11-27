# Create a symlink in Nix

This is a utility for creating a derivation containing a single symlink.

You can import this as a flake or via default.nix.  
If you import this in a flake, you will need to provide arguments for `busybox` and `system`.   When in impure mode, the defaults can be evaluated, which attempt to find BusyBox in Nixpkgs and use `builtins.currentSystem`.

## Example

The flake

```nix
{
  inputs.symlink.url = "github:schuelermine/nix-symlink?rev=9130ad485f410f8ec160378e8153ee7e5856e710";
  outputs = { self, symlink, nixpkgs }: {
    defaultPackage.x86_64-linux = symlink.symlink {
      system = "x86_64-linux";
      busybox = nixpkgs.legacyPackages.x86_64-linux.busybox;
      link = "link";
      target = "/target";
    };
  };
}
```

will produce a symlink from `/nix/store/p402xp95ynm3z210874h64xg37qifc52-symlink-link-target/link` to `/target`.