# Create a symlink in Nix

This is a utility for creating a derivation containing a single symlink.

You can import this as a flake or via default.nix.  
If you import this in a flake, you will need to provide arguments for `busybox` and `system`.   When in impure mode, the defaults can be evaluated, which attempt to find BusyBox in Nixpkgs and use `builtins.currentSystem`.

## Example

```nix
{
  inputs.symlink.url = "github:schuelermine/nix-symlink";
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

will produce a symlink from `/nix/store/$something/link` to `/target`, where `$something` is determined by Nix.