# Full-Stack Development Environment

**Time:** 20 minutes  
**Goal:** Create a development environment with both Python backend and Node.js frontend

## How Does This Work?

**Important:** `shell.nix` provides the *tools* (Python, Node, Flask). You still create the *app files* yourself.

- `shell.nix` = "I need these tools and versions"
- Your code files = "Here's my actual application"
- `nix-shell` = Makes both available together

This is how replication works: Any team member runs `nix-shell` and gets the exact same Python, Node, Flask versions you had.

## Scenario

Your next project is a web app: React frontend + Flask API. Both developers need the same stack.

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
    nodePackages.pnpm
    
    # Backend
    python3
    python3Packages.pip
    python3Packages.flask
    python3Packages.flask-cors
    python3Packages.python-dotenv
    
    # Utilities
    git
    curl
  ];
  
  shellHook = ''
    echo "🚀 Full-Stack Dev Environment"
    echo "Frontend: Node $(node --version)"
    echo "Backend:  Python $(python3 --version)"
  '';
}
```

## Using It

```bash
nix-shell

# Create directory structure
mkdir -p frontend backend

# ============ Backend Setup ============
cd backend

# Create Flask app
cat > app.py << 'EOF'
from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/api/hello')
def hello():
    return jsonify({'message': 'Hello from Flask!'})

if __name__ == '__main__':
    app.run(debug=True, port=5000)
EOF

# Install dependencies
pip install flask flask-cors

# Run backend in background
python3 app.py &
BACKEND_PID=$!

# ============ Frontend Setup ============
cd ../frontend

# Create minimal React app
cat > package.json << 'EOF'
{
  "name": "frontend",
  "version": "1.0.0",
  "scripts": {
    "dev": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.0"
  }
}
EOF

# Install dependencies
npm install

# Create Express server that calls backend
cat > server.js << 'EOF'
const express = require('express');
const app = express();

app.get('/api/frontend', (req, res) => {
  res.json({ message: 'Hello from Node!' });
});

app.listen(3000, () => {
  console.log('Frontend server on http://localhost:3000');
});
EOF

# Run frontend
npm run dev

# Now you have:
# - Frontend on http://localhost:3000
# - Backend on http://localhost:5000

# Clean up
kill $BACKEND_PID
exit
```

## Project Structure

```
project/
├── shell.nix          # Shared environment
├── frontend/
│   ├── package.json
│   └── app.js
└── backend/
    ├── app.py
    └── requirements.txt (optional)
```

## Real Example

See a complete working example in `examples/fullstack-stack/`

---

**Next:** Learn about [Quick Package Testing](05-quick-package-testing.md) or [Platform Differences](06-platform-differences.md)
