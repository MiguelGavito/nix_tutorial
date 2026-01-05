#!/usr/bin/env node
const express = require('express');
const path = require('path');
const fetch = require('node-fetch');

const app = express();
const PORT = 3000;
const BACKEND_URL = process.env.BACKEND_URL || 'http://localhost:5000';

// Serve static assets
app.use(express.static(path.join(__dirname, 'public')));

// Proxy endpoint for status (frontend could also call backend directly)
app.get('/api/system', async (_req, res) => {
  try {
    const response = await fetch(`${BACKEND_URL}/api/system`, { timeout: 5000 });
    const data = await response.json();
    res.json(data);
  } catch (err) {
    res.status(500).json({ error: 'Cannot reach backend', details: err.message });
  }
});

app.listen(PORT, () => {
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  console.log(`⚡ Frontend running on http://localhost:${PORT}`);
  console.log(`Backend expected at ${BACKEND_URL}`);
  console.log('Open the dashboard in your browser.');
  console.log('Press Ctrl+C to stop');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
});
