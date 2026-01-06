# Full-Stack Development Environment

**Time:** 20 minutes  
**Prerequisites:** Nix installed ([Installation Guide](00-installation.md)) + [nix-shell Basics](01-nix-shell-basics.md)  
**Goal:** Create a development environment with both Python backend and Node.js frontend

## How Does This Work?

**Important:** `shell.nix` provides the *tools* (Python, Node, Flask, psutil). The app files are already in the example; you just run them. Any teammate runs `nix-shell` and gets the exact same versions.

## Scenario

System monitor dashboard: Python backend serves system stats (CPU/mem/disk) and Node frontend shows a live dashboard. Both run from one Nix environment.

## The shell.nix

Create `shell.nix` in your project root:

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "fullstack-dev";
  
  buildInputs = with pkgs; [
    # Frontend
    nodejs_20
    nodePackages.npm
    
    # Backend
    python3
    python3Packages.flask
    python3Packages.flask-cors
    python3Packages.psutil
    
    # Utilities
    git
    curl
  ];
  
  shellHook = ''
    echo "🚀 Full-Stack Dev Environment"
    echo "Frontend: Node $(node --version)"
    echo "Backend:  Python $(python3 --version)"
    echo "Backend: system stats API on port 5000"
    echo "Frontend: dashboard on port 3000"
  '';
}
```

## Using It

```bash
cd examples/fullstack-stack
nix-shell

# Terminal 1 (backend)
python3 backend.py

# Terminal 2 (frontend, inside the same nix-shell)
npm install   # first time only
node frontend.js
```

Open: http://localhost:3000 (dashboard)  
Backend API: http://localhost:5000/api/system

## Project Structure

```
fullstack-stack/
├── shell.nix        # Shared environment (Python + Node + psutil)
├── backend.py       # Flask system stats API (port 5000)
├── frontend.js      # Express server (port 3000) serving dashboard
└── public/
  └── index.html   # Dashboard UI
```

## Real Example

See the working example in `examples/fullstack-stack/` (all files ready—no copy/paste needed)

---

**Next:** Learn about [Quick Package Testing](05-quick-package-testing.md) or [Platform Differences](06-platform-differences.md)
