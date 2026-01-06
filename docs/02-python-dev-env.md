# Python Development Environment

**Time:** 15 minutes  
**Prerequisites:** Nix installed ([Installation Guide](00-installation.md)) + [nix-shell Basics](01-nix-shell-basics.md)  
**Goal:** Create a Python dev environment with specific packages using nix-shell

## Scenario

Build a CLI that fetches GitHub repository stats (stars, forks, issues) using `requests` and displays them nicely with `rich`. Instead of `pip install`, use Nix to get the exact Python + libraries.

## The shell.nix

Create `shell.nix` in your project:

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "python-github-analyzer";
  
  buildInputs = with pkgs; [
    python3
    python3Packages.requests
    python3Packages.rich
  ];
  
  shellHook = ''
    echo "🐍 Python GitHub Analyzer environment loaded"
    python3 --version
  '';
}
```

## Using It

```bash
# From your project directory
nix-shell

# Analyze a repo
python3 app.py octocat/Hello-World
python3 app.py torvalds/linux
```

Expected output: repo info + stats in a nicely formatted table. If a repo has no license, it shows "None" (handled safely).

## Find More Packages

Want a different Python package? Search it:

```bash
# Search for packages
nix search nixpkgs python3Packages.requests

# Or online: https://search.nixos.org/packages
```

## Real Example

See the working example in `examples/python-dev-env/` (app is already written; just run it).

---

**Next:** Try [Node.js Development](03-nodejs-dev-env.md) or [Full-Stack Example](04-fullstack-dev-env.md)
