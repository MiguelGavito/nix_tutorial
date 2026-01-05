# Python Flask Example

This is a ready-to-use Flask development environment.

## Setup

```bash
# Enter the environment
nix-shell

# Create a simple Flask app
cat > app.py << 'EOF'
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def hello():
    return jsonify({'message': 'Hello from Nix!'})

@app.route('/api/test')
def test():
    return jsonify({'status': 'working'})

if __name__ == '__main__':
    app.run(debug=True, port=5000)
EOF

# Run it
python3 app.py

# Visit: http://localhost:5000
```

## What's Included

- Python 3
- Flask
- Flask-CORS (for API development)
- Requests (for HTTP calls)
- Python-dotenv (for environment variables)

## Exit

```bash
# Press Ctrl+C to stop the server
# Then exit the environment
exit
```

All installed packages are cleaned up automatically.
