# Full-Stack Web Development Example

This is a ready-to-use development environment with Python backend and Node.js frontend.

## Two Ways to Use This

### Option 1: Copy-Paste & Run (Fastest)

1. Copy `shell.nix` to your project folder
2. Run `nix-shell`
3. Copy-paste the code below
4. Run your apps

### Option 2: Manual Setup (Understanding Everything)

Do the same steps but create files yourself. See main tutorial: [Full-Stack Dev](../../docs/04-fullstack-dev-env.md)

---

## Quick Start (Copy & Paste)

```bash
# Enter Nix environment (provides Python, Node, Flask)
nix-shell

# ========== BACKEND SETUP ==========

cat > backend.py << 'EOF'
from flask import Flask, jsonify
from flask_cors import CORS
import json
from datetime import datetime

app = Flask(__name__)
CORS(app)

@app.route('/api/hello')
def hello():
    return jsonify({
        'message': 'Hello from Python Backend!',
        'framework': 'Flask',
        'timestamp': datetime.now().isoformat()
    })

@app.route('/api/users')
def users():
    return jsonify({
        'users': [
            {'id': 1, 'name': 'Alice', 'role': 'Backend Dev'},
            {'id': 2, 'name': 'Bob', 'role': 'Frontend Dev'}
        ]
    })

if __name__ == '__main__':
    print("🐍 Backend running on http://localhost:5000")
    app.run(debug=True, port=5000, use_reloader=False)
EOF

# Install dependencies (Flask and CORS)
pip install flask flask-cors 2>/dev/null

# Start backend in background
python3 backend.py > /tmp/backend.log 2>&1 &
BACKEND_PID=$!
echo "✓ Backend started (PID: $BACKEND_PID)"
sleep 2

# ========== FRONTEND SETUP ==========

cat > package.json << 'EOF'
{
  "name": "fullstack-frontend",
  "version": "1.0.0",
  "scripts": {
    "start": "node frontend.js"
  },
  "dependencies": {
    "express": "^4.18.0"
  }
}
EOF

# Install npm dependencies
npm install 2>/dev/null

cat > frontend.js << 'EOF'
const express = require('express');
const http = require('http');
const app = express();

app.use(express.static('public'));

app.get('/api/frontend', (req, res) => {
  res.json({ 
    message: 'Hello from Node.js Frontend!',
    framework: 'Express'
  });
});

// Call backend and return data
app.get('/api/proxy', (req, res) => {
  const options = {
    hostname: 'localhost',
    port: 5000,
    path: '/api/users',
    method: 'GET'
  };

  const request = http.request(options, (response) => {
    let data = '';
    response.on('data', (chunk) => { data += chunk; });
    response.on('end', () => {
      try {
        res.json(JSON.parse(data));
      } catch (e) {
        res.json({ error: 'Backend unavailable' });
      }
    });
  });

  request.on('error', (e) => {
    res.json({ error: 'Cannot reach backend: ' + e.message });
  });
  request.end();
});

app.listen(3000, () => {
  console.log('\n⚡ Frontend running on http://localhost:3000');
  console.log('   Try: http://localhost:3000/api/frontend');
  console.log('   Try: http://localhost:3000/api/proxy');
  console.log('\nBoth servers running in same Nix environment\n');
});
EOF

echo "✓ Frontend ready"

# ========== TEST IT ==========

echo ""
echo "🚀 Full-Stack Application Running"
echo "=================================="
echo "Frontend:  http://localhost:3000"
echo "Backend:   http://localhost:5000"
echo ""
echo "Test with curl:"
echo "  curl http://localhost:3000/api/frontend"
echo "  curl http://localhost:3000/api/proxy"
echo ""

# Start frontend (blocking)
npm start

# Cleanup on exit
kill $BACKEND_PID 2>/dev/null
```

## Test It Works

```bash
# In another terminal (still in nix-shell):
curl http://localhost:3000/api/frontend
curl http://localhost:3000/api/proxy
```

Or open http://localhost:3000 in your browser.

---

## What's Happening

1. **shell.nix** provides: Python, Flask, Node, npm
2. **backend.py** is your Python API (5000)
3. **frontend.js** is your Express server (3000)
4. Frontend can call backend API at localhost:5000

This is a real, working full-stack application. Your team gets the exact same environment when they run `nix-shell`.

## Next

- Modify the APIs to return different data
- Add database connection
- Use this as a template for your actual project
- Move to [Advanced Topics](../../ROADMAP.md) when ready
