# Platform Differences

**Reference:** 5 minutes  
**Goal:** Understand how Nix works differently across Linux, macOS, and WSL

## Quick Comparison

| Feature | Linux | macOS | WSL2 | NixOS |
|---------|-------|-------|------|-------|
| **Installation** | Straightforward | Works well | Works well | It's the OS |
| **Performance** | Native | Native (Intel/ARM) | Near-native | Native |
| **Caching** | Fast | Fast | Medium | Native |
| **Shell.nix** | ✅ Works | ✅ Works | ✅ Works | ✅ Works |
| **Home Manager** | ✅ Works | ✅ Works | ✅ Works | ✅ Works (native) |
| **Flakes** | ✅ Works | ✅ Works | ✅ Works | ✅ Works |

## Linux

**Best for:** Nix development, most stable

```bash
# Install Nix (single-user install)
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Start using immediately
nix-shell
```

- Fastest execution
- Native package building
- Direct filesystem integration

## macOS (Intel & Apple Silicon)

**Works great:** Both architectures supported

```bash
# Install via Homebrew
brew install nix

# Or direct install
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Apple Silicon (ARM64) Notes

- ✅ Nix fully supports ARM64
- ✅ Most nixpkgs packages are available for ARM64
- ⚠️ Some older packages might need `x86_64-darwin` (runs via Rosetta 2)

```nix
# If you need x86_64 packages
{ pkgs ? import <nixpkgs> { system = "x86_64-darwin"; } }:
pkgs.mkShell { ... }
```

### macOS-Specific Issues

**Issue:** "Operation not permitted" when using nix-shell

```bash
# Solution: Usually requires macOS Monterey+ features enabled
# Restart after installation, or recreate your shell
```

**Issue:** Slow initial runs

```bash
# Nix caches everything, second runs are much faster
# First nix-shell might take a minute
```

## Windows (WSL2)

**Works well:** Better than WSL1, nearly Linux performance

### Setup

1. **Install WSL2** (Windows 11 or Windows 10 with recent updates)
   ```bash
   wsl --set-default-version 2
   ```

2. **Install Nix in your WSL2 distro**
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```

### WSL2 Considerations

- ✅ Full Nix support
- ✅ Good performance
- ⚠️ Some Windows PATH integration quirks
- ⚠️ Slightly slower than Linux (filesystem overhead)

```bash
# Check WSL2 version
wsl --list --verbose
# Should show "2" in version column
```

### Accessing Windows Files from nix-shell

```bash
# Windows files are at /mnt/c/
# Example: access Documents
nix-shell  # inside WSL2
cd /mnt/c/Users/YourName/Documents
```

## NixOS

**What is it?** Linux distribution where Nix is the package manager AND the OS configuration

- Everything is configured in Nix
- Rollback-friendly
- Declarative system management
- Not needed for Nix usage (Nix works on any Linux)
- Good for servers, optional for development machines

## Troubleshooting by Platform

### "nix-shell not found" (All Platforms)

```bash
# Install Nix first
# https://nix.dev/install-nix

# Verify installation
nix --version
```

### "Hash mismatch" (Especially macOS/WSL)

```bash
# Clear cache and retry
rm -rf ~/.cache/nix
nix-shell
```

### "Permission denied" (Linux)

```bash
# Run with sudo if needed during installation
# But not for using nix-shell afterwards
```

---

**Next:** Start with a practical tutorial: [Python](02-python-dev-env.md) or [Node.js](03-nodejs-dev-env.md)
