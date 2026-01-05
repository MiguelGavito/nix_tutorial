# Python Development Environment

**Time:** 15 minutes  
**Prerequisites:** Nix installed ([Installation Guide](00-installation.md)) + [nix-shell Basics](01-nix-shell-basics.md)  
**Goal:** Create a Python dev environment with specific packages using nix-shell

## Scenario

You need to develop a Flask API with specific package versions. Instead of `pip install`, use Nix.

## The shell.nix

Create `shell.nix` in your project:

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "python-dev";
  
  buildInputs = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.flask
    python3Packages.requests
    python3Packages.python-dotenv
  ];
  
  shellHook = ''
    echo "Python dev environment loaded"
    python3 --version
  '';
}
```

## Using It

```bash
# From your project directory
nix-shell

# You now have Python and packages available
python3 -c "import flask; print(flask.__version__)"

# Create your Flask app
cat > app.py << 'EOF'
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello from Nix!'

if __name__ == '__main__':
    app.run(debug=True)
EOF

# Run it
python3 app.py

# Exit when done
exit
```

## Find More Packages

Want a different Python package? Search it:

```bash
# Search for packages
nix search nixpkgs python3Packages.requests

# Or online: https://search.nixos.org/packages
```

## Real Example

See a complete working example in `examples/python-dev-env/`

---

**Next:** Try [Node.js Development](03-nodejs-dev-env.md) or [Full-Stack Example](04-fullstack-dev-env.md)
