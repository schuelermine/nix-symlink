# Create a symlink in Nix

This is a utility for creating a derivation containing a single symlink.

You can import this as a flake or via default.nix.
If you import it in a flake, you will need to provide the arguments `system`, a reference to BusyBox or GNU Coreutils as `utils`, and the path to a shell like bash or sh as `shell`.
If your utils derivation provides a shell under `…/bin/sh`, you can omit `shell`.
If you use this in impure mode (e.g. outside a flake), you can omit `utils` and `system`. `utils` is automatically substituted by BusyBox from nixpkgs, and `system` uses `builtins.currentSystem`.
If you specify GNU Coreutils in `utils`, you will need to provide a separate shell, as `sh` isn’t in coreutils.

If your link or target are dependent on another derivation, you need to use the arguments `link-label` and `target-label`. They control parts of the name of the symlink derivation (`symlink-${link-label}-${target-label}`), and default to the arguments `link` and `label`, respectively.
Because names of derivations should’t contribute to their dependencies, Nix prohibits the names from referencing other derivations. This means you need to specify your own static labels.

## Example

This is an example flake showing all arguments’ uses.
It creates a symlink from `/nix/store/fl1i9dhpd26amw49w6r2y2bmcw9rbybs-symlink-link-label-target-label/link` to `/target`.

```nix
{
  inputs.symlink.url =
    "github:schuelermine/nix-symlink?rev=c0efee35a02b779d75b4a103e1df5067249cb5a9";
  outputs = { self, symlink, nixpkgs }: {
    defaultPackage.x86_64-linux = symlink.symlink {
      system = "x86_64-linux";
      utils = nixpkgs.legacyPackages.x86_64-linux.coreutils;
      # ↑ This is optional if in impure mode. It is replaced with busybox from nixpkgs.
      shell = "${nixpkgs.legacyPackages.x86_64-linux.bash}/bin/sh";
      # ↑ This is optional if utils provides …/bin/sh, like if using busybox.
      link = "link";
      target = "/target";
      link-label = "link-label";
      # ↑ This is optional if link doesn't depend on a derivation.
      target-label = "target-label";
      # ↑ This is optional if target doesn't depend on a derivation.
    };
  };
}
```
