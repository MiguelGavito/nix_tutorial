#!/usr/bin/env bash
# Cleanup script for Nix tutorial examples

echo "🧹 Cleaning up Nix tutorial examples..."
echo ""

# Kill running processes
echo "Stopping running servers..."
pkill -f "python3 app.py" 2>/dev/null && echo "  ✓ Stopped Python servers"
pkill -f "python3 backend.py" 2>/dev/null && echo "  ✓ Stopped backend servers"
pkill -f "node app.js" 2>/dev/null && echo "  ✓ Stopped Node servers"
pkill -f "node frontend.js" 2>/dev/null && echo "  ✓ Stopped frontend servers"
pkill -f flask 2>/dev/null && echo "  ✓ Stopped Flask servers"

# Kill by port
lsof -ti:3000 2>/dev/null | xargs kill -9 2>/dev/null && echo "  ✓ Freed port 3000"
lsof -ti:5000 2>/dev/null | xargs kill -9 2>/dev/null && echo "  ✓ Freed port 5000"

echo ""
echo "Cleaning Node.js artifacts..."
find examples -name "node_modules" -type d -exec rm -rf {} + 2>/dev/null && echo "  ✓ Removed node_modules/"
find examples -name "package-lock.json" -delete 2>/dev/null && echo "  ✓ Removed package-lock.json"

echo ""
echo "Cleaning Python artifacts..."
find examples -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null && echo "  ✓ Removed __pycache__/"
find examples -name "*.pyc" -delete 2>/dev/null && echo "  ✓ Removed *.pyc files"

echo ""
echo "✅ Cleanup complete!"
echo ""
echo "To start fresh:"
echo "  1. cd examples/python-dev-env"
echo "  2. nix-shell"
echo "  3. python3 app.py"
