# Nix-Shell Basics

**Time:** 10 minutes  
**Prerequisites:** Nix installed ([Installation Guide](00-installation.md))  
**Goal:** Understand what nix-shell does and create your first isolated development environment

## What is nix-shell?

`nix-shell` creates an isolated development environment with specific versions of tools and libraries. Think of it like a lightweight container just for your terminal.

### Why use it?

- **No system pollution** - Tools don't get installed globally
- **Reproducible** - Everyone on your team uses the same versions
- **Easy cleanup** - `exit` the shell and it's gone
- **No conflicts** - Different projects can need different versions of the same tool

## Quick Example

The simplest nix-shell definition is a file called `shell.nix`:

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    python3Packages.pip
  ];
}
```

### Using it:

```bash
# Enter the environment
nix-shell

# Now you have python3 available (even if your system doesn't)
python3 --version

# Exit the environment
exit

# python3 is gone again
python3 --version  # (command not found)
```

## Your First nix-shell

1. Create a file called `shell.nix` in your project:

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "dev-environment";
  
  buildInputs = with pkgs; [
    # Your tools here
  ];
}
```

2. Add tools you need in `buildInputs`
3. Run `nix-shell`
4. You're inside! Use the tools like normal

## Platform Note

- **Linux:** Works directly
- **macOS:** Works directly (both Intel and ARM)
- **WSL2 (Windows):** Works, might need WSL2 setup
- **NixOS:** Works, this is how you typically work

---

**Next:** Try [Python Development](02-python-dev-env.md) or [Node.js Development](03-nodejs-dev-env.md)
