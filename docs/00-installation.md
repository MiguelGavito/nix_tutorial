# Installation Guide

**Time:** 5-15 minutes depending on platform  
**Goal:** Get Nix installed and working on your system

Before you can use any tutorials in this guide, you need Nix installed. Follow the instructions for your platform below.

> **Note:** This guide uses the official NixOS installer from nixos.org - the canonical, battle-tested source maintained by the NixOS Foundation. This ensures compatibility with all documentation, CI/CD systems, and long-term stability for team projects.

## Linux

### Choose Your Installation Mode

**Multi-user (Recommended for team projects):**
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```
- ✅ Better for teams and shared systems
- ✅ Works with CI/CD
- ✅ More robust for production
- Requires sudo during installation

**Single-user (Simpler for personal machines):**
```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```
- ✅ Simpler, no background service
- ✅ Easier to debug
- ✅ Good for learning
- No sudo required

**Not sure?** Use multi-user (--daemon) - it's what most teams need.

### Installation Steps

```bash
# Run the command for your chosen mode
# Follow the prompts in your terminal
# The installer will guide you through the process
```

### Verify Installation

```bash
# Check that Nix is installed
nix --version
# You should see: nix (Nix) 2.18.x (or newer)

# Check which mode you installed
ps aux | grep nix-daemon | grep -v grep
# If you see nix-daemon: Multi-user mode
# If nothing appears: Single-user mode
```

### Troubleshooting

**"curl: command not found"**
```bash
# Install curl first
sudo apt-get install curl  # Ubuntu/Debian
sudo dnf install curl      # Fedora
sudo pacman -S curl        # Arch
```

**"Permission denied" during installation**
```bash
# Some systems need sudo
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --yes
```

---

## macOS (Intel & Apple Silicon)

### Choose Your Installation Mode

**Multi-user (Recommended for team projects):**
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```
- ✅ Better for teams
- ✅ More robust
- ✅ Standard for macOS
- Requires admin password during installation

**Single-user (Alternative):**
```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```
- ✅ Simpler setup
- ✅ No background service
- Less common on macOS

**Not sure?** Use multi-user (--daemon) - it's the standard for macOS.

### Alternative: Homebrew

```bash
# If you prefer using Homebrew
brew install nix
# Note: This installs in single-user mode
```

### Verify Installation

```bash
# Close and reopen your terminal, then:
nix --version
# You should see: nix (Nix) 2.18.x (or newer)

# Check installation mode
ps aux | grep nix-daemon | grep -v grep
# If you see nix-daemon: Multi-user mode (recommended)
# If nothing: Single-user mode
```

### Apple Silicon (ARM64) Specific Notes

- ✅ Nix fully supports Apple Silicon
- ✅ Works natively (no Rosetta translation needed)
- Most packages work directly for ARM64

If you're on Apple Silicon and an older Intel Mac exists in your team:
```bash
# Both Macs can share the same shell.nix
# Nix handles the differences automatically
```

### macOS Troubleshooting

**"Operation not permitted" error**
```bash
# This is normal on some macOS versions
# Solution 1: Restart your Mac after installation
# Solution 2: Open a new Terminal window
# Solution 3: If still failing, try:
/nix/nix-installer uninstall
# Then reinstall using Homebrew
brew install nix
```

**"nix: command not found" after installation**
```bash
# Restart your terminal or run:
source ~/.nix-profile/etc/profile.d/nix.sh
```

**Slow first-time runs**
```bash
# First nix-shell can be slow (30 seconds to 2 minutes)
# This is normal - Nix is downloading and caching packages
# Subsequent runs are much faster (< 1 second)
```

---

## Windows (WSL2)

### Prerequisites

You need Windows Subsystem for Linux 2 (WSL2):

```powershell
# Run in PowerShell as Administrator
wsl --set-default-version 2

# Verify you have WSL2
wsl --list --verbose
# Output should show "2" in the version column
```

If you don't have WSL2 yet:
```powershell
# Install WSL2 (Windows 11)
wsl --install

# For Windows 10, follow: https://docs.microsoft.com/en-us/windows/wsl/install-manual
```

### Installation in WSL2

Once WSL2 is set up, open a WSL2 terminal:

**Multi-user (Recommended for team projects):**
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

**Single-user (Alternative):**
```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

**Not sure?** Use multi-user (--daemon) for consistency with your team.

### Verify Installation

```bash
# Close WSL2 and reopen it, then:
nix --version
# You should see: nix (Nix) 2.18.x (or newer)

# Check installation mode
ps aux | grep nix-daemon | grep -v grep
# If you see nix-daemon: Multi-user mode
# If nothing: Single-user mode
```

### WSL2 Notes

- Performance is near-native (good for development)
- WSL2 files are in: `/mnt/c/Users/YourName/` (Windows files)
- Linux files are separate: `/home/` (fast access)

### WSL2 Troubleshooting

**"nix-shell hangs or is very slow"**
```bash
# This usually means insufficient WSL2 resources
# Check available memory:
free -h

# If low, increase WSL2 memory in Windows
# Create/edit C:\Users\YourName\.wslconfig:
[wsl2]
memory=4GB
processors=4
```

**"Cannot access Windows files from nix-shell"**
```bash
# Windows files are mounted at /mnt/c/
# Example:
cd /mnt/c/Users/YourName/Documents
nix-shell

# Now you can work with Windows files
```

**"Permission errors on Windows files"**
```bash
# This is normal - WSL2 permission differences
# Solution: Move your project to WSL2 Linux files
cd ~
mkdir my-projects
cd my-projects

# Work here instead of /mnt/c/
```

---

## NixOS Users

If you're already on NixOS, Nix is built-in:

```bash
# Just verify it's available
nix --version
```

You're ready to start the tutorials immediately!

---

## Verify Everything Works

After installation, test that Nix can run a simple command:

```bash
# This should work without errors
nix run nixpkgs#figlet -- "Nix Works!"

# You should see your text in big ASCII letters
```

If that works, Nix is properly installed! You're ready for the tutorials.

---

## Still Having Issues?

**Common problems:**

1. **"nix: command not found"**
   - Restart your terminal
   - Check: `which nix`
   - If still missing, reinstall Nix

2. **"Hash mismatch" errors**
   - Clear Nix cache: `rm -rf ~/.cache/nix`
   - Try again: `nix-shell`

3. **"Uninstall Nix" (if you need to start over)**
   ```bash
   # For official installer
   sudo rm -rf /nix /etc/nix ~/.nix-profile ~/.nix-defexpr ~/.nix-channels
   
   # Then remove from shell profile
   # Edit ~/.bashrc or ~/.zshrc and remove Nix lines
   
   # Then reinstall cleanly
   ```

**Official help:** https://nix.dev/install-nix

---

## Alternative Installers

### Determinate Systems Installer

There's an alternative installer by Determinate Systems that offers better UX:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

**Benefits:**
- Better error messages
- Easier uninstall process
- More user-friendly installation flow

**Considerations:**
- Third-party company (not the NixOS Foundation)
- May differ from official documentation
- Less standard for CI/CD and team environments

**For team projects,** we recommend the official installer above for maximum compatibility and long-term stability.

---

## Next Steps

Once Nix is installed and verified:
1. Read [nix-shell Basics](01-nix-shell-basics.md)
2. Try the [Python](02-python-dev-env.md) or [Node.js](03-nodejs-dev-env.md) tutorials
3. Clone the repo and run examples: `nix-shell`

