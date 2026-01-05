# Nix Tutorial - Learn by Doing

A practical guide to Nix for development teams. Learn through hands-on examples across Python, Node.js, and full-stack development.

## Getting Started

### Step 1: Install Nix (5-15 min)
**[Installation Guide](docs/00-installation.md)** - Get Nix working on your system
- Linux, macOS (Intel & Apple Silicon), WSL2, or NixOS
- Includes troubleshooting for common issues

### Step 2: Learn the Basics (10 min each)
Once Nix is installed, follow these tutorials in order:

1. **[nix-shell Basics](docs/01-nix-shell-basics.md)** - Create isolated dev environments
2. **[Python Development](docs/02-python-dev-env.md)** - Python + dependencies
3. **[Node.js Development](docs/03-nodejs-dev-env.md)** - Node + npm packages
4. **[Full-Stack Example](docs/04-fullstack-dev-env.md)** - Python + Node together
5. **[Quick Package Testing](docs/05-quick-package-testing.md)** - Try tools without installing
6. **[Platform Differences](docs/06-platform-differences.md)** - Linux, macOS, WSL

### Step 3: Try Working Examples

All examples are ready to use - just clone the repo and run:

```bash
git clone https://github.com/MiguelGavito/nix_tutorial
cd nix_tutorial/examples/python-dev-env

# Enter the environment
nix-shell

# You now have Python + Flask ready to use!
```

**Available examples:**
- `examples/python-dev-env/` - Flask development
- `examples/nodejs-dev-env/` - Node.js development  
- `examples/fullstack-stack/` - Python backend + Node frontend

### Reference Projects

- Full project example: https://github.com/MiguelGavito/toIPA (React + Flask + Nix)

## Resources

**Official Documentation**
- https://nix.dev/ - Best starting point
- https://nixos.org/ - Nix ecosystem overview
- https://search.nixos.org/packages - Search packages

**Community**
- https://nix-community.github.io/home-manager/ - System configuration
- https://nixos-and-flakes.thiscute.world/ - Advanced topics (flakes, etc)

> **Note:** A detailed [ROADMAP.md](ROADMAP.md) exists for future development phases including flakes, home-manager, NixOS, and advanced topics.