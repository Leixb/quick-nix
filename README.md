# Quick-nix

Create development shells quickly with nix.

## Usage

Chain you dependencies joined by dots:

- `<package>` adds the package into the shell
- `@<package>` adds the packages needed to build `<package>`

```bash
nix develop github:LeixB/quick-nix#@nosv.clang-tools.hyperfine
```

This can be used along with `direnv`:

```bash
use flake github:LeixB/quick-nix#@nosv.clang-tools.hyperfine
```
