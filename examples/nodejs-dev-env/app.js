const express = require('express');
const app = express();

// Middleware to parse JSON
app.use(express.json());

// Home route
app.get('/', (req, res) => {
  res.json({
    message: 'Hello from Nix!',
    framework: 'Express.js',
    timestamp: new Date().toISOString()
  });
});

// API route
app.get('/api/hello', (req, res) => {
  res.json({
    greeting: 'Welcome to Nix tutorial',
    status: 'running',
    nodeVersion: process.version
  });
});

// Health check
app.get('/api/health', (req, res) => {
  res.json({
    status: 'healthy',
    uptime: process.uptime()
  });
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  console.log(`⚡ Server running on http://localhost:${PORT}`);
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  console.log('Try these endpoints:');
  console.log(`  http://localhost:${PORT}/`);
  console.log(`  http://localhost:${PORT}/api/hello`);
  console.log(`  http://localhost:${PORT}/api/health`);
  console.log('\nPress Ctrl+C to stop');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
});
