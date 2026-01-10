# Testing GitHub Projects: kew + ytmdl

Quick test setup for downloading and playing music from terminal.

## What's Here

- `shell.nix` - Temporary testing environment (test without installing)
- `home.nix` - Example Home Manager config to install permanently

## Quick Start

### Option 1: Test Without Installing (Safe)

```bash
cd testing-github-projects
nix-shell
```

Now you have `kew` and `ytmdl`:

```bash
# Download a song
ytmdl "Scarlet Forest"

# Play it
kew

# Exit when done
exit
```

Your system is unchanged—everything was temporary.

### Option 2: Install Permanently

Copy the `home.nix` example to your Home Manager config location:

```bash
# If using standard setup:
cp home.nix ~/.config/home-manager/home.nix

# Or if you use a custom path:
cp home.nix /your/custom/path/home.nix
```

Then apply:

```bash
home-manager switch
```

Now `kew` and `ytmdl` are part of your system, plus zsh with agnoster theme and aliases.

### If You Change Your Mind

To remove them:

```bash
# Edit your home.nix and remove these lines:
# - kew
# - ytmdl

home-manager switch
```

See the main tutorial: [Testing Nixpkgs Programs](../../docs/07-testing-nixpkgs-programs.md) for full explanations.
