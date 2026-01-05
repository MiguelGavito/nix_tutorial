# Node.js Development Example

This is a ready-to-use Node.js development environment.

## Setup

```bash
# Enter the environment
nix-shell

# Create a simple Express app
cat > app.js << 'EOF'
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.json({ message: 'Hello from Nix!' });
});

app.get('/api/test', (req, res) => {
  res.json({ status: 'working', timestamp: new Date() });
});

app.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});
EOF

# Create package.json
npm init -y

# Install Express
npm install express

# Run the app
node app.js

# Visit: http://localhost:3000
```

## What's Included

- Node.js 20
- npm (Node package manager)
- pnpm (alternative faster package manager, optional)

## Exit

```bash
# Press Ctrl+C to stop the server
# Then exit the environment
exit
```

All installed packages are cleaned up automatically.
