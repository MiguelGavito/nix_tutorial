# Node.js Development Environment

**Time:** 15 minutes  
**Prerequisites:** Nix installed ([Installation Guide](00-installation.md)) + [nix-shell Basics](01-nix-shell-basics.md)  
**Goal:** Create a Node.js dev environment with specific versions using nix-shell

## Scenario

You're building a React frontend or Express API. Use Nix to guarantee Node version across your team.

## The shell.nix

Create `shell.nix` in your project:

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "nodejs-dev";
  
  buildInputs = with pkgs; [
    nodejs_20  # Specify Node version
    nodePackages.npm
    nodePackages.pnpm  # Optional: faster package manager
  ];
  
  shellHook = ''
    echo "Node.js dev environment loaded"
    node --version
    npm --version
  '';
}
```

## Using It

```bash
# From your project directory
nix-shell

# Check versions
node --version
npm --version

# Create a simple Express app
mkdir -p my-api && cd my-api

# Initialize project
npm init -y

# Install Express
npm install express

# Create app.js
cat > app.js << 'EOF'
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.json({ message: 'Hello from Nix!' });
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
EOF

# Run it
node app.js

# Open http://localhost:3000 in browser
# Exit when done
exit
```

## Node Versions Available

- `nodejs` - Latest LTS
- `nodejs_20` - Node 20.x
- `nodejs_18` - Node 18.x
- `nodejs_16` - Node 16.x (legacy)

Check which versions are available:

```bash
nix search nixpkgs nodejs
```

## Real Example

See a complete working example in `examples/nodejs-dev-env/`

---

**Next:** Try [Full-Stack Example](04-fullstack-dev-env.md) combining Python and Node
