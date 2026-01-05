# Full-Stack System Monitor (Ready-to-Run)

**What this shows:** One Nix shell gives you both Python (backend API) and Node (frontend dashboard) with exact versions across Linux/macOS/WSL.

Backend: Python + Flask + psutil (system stats API) → port 5000  
Frontend: Node + Express (dashboard UI) → port 3000

Files are already created—no copy/paste needed.

```
fullstack-stack/
├── shell.nix        # Nix environment (Python + Node + deps)
├── backend.py       # Flask API: /api/system
├── frontend.js      # Express server serving dashboard
└── public/
    └── index.html   # Simple dashboard UI
```

---

## Run It

```bash
cd examples/fullstack-stack
nix-shell

# Terminal 1 (backend)
python3 backend.py

# Terminal 2 (frontend, inside nix-shell)
npm install   # first time only
node frontend.js
```

Open: http://localhost:3000  
Backend API: http://localhost:5000/api/system

Press `Ctrl+C` in each terminal to stop. Type `exit` to leave nix-shell.

---

## What You See
- Live CPU, memory, disk usage
- Hostname, platform, boot time
- Auto-refreshing dashboard (every 5s)

---

## Why This Demonstrates Nix
- One command (`nix-shell`) gives the exact Python + Node toolchain on any OS
- No global installs of Python, Node, Flask, psutil, Express
- Teammates get the identical environment and versions

---

## Tweak & Extend
- Change the refresh interval in `public/index.html` (`setInterval`)
- Add more stats in `backend.py` (network IO, per-CPU, processes)
- Style the dashboard (edit `public/index.html` CSS)
- Change Node/Python versions by editing `shell.nix`

---

## Troubleshooting

**Port already in use (3000 or 5000)**
```bash
lsof -ti:3000 | xargs kill -9
lsof -ti:5000 | xargs kill -9
```

**`ModuleNotFoundError` or `node: command not found`**
```bash
# You’re not in nix-shell
nix-shell
```

**Dashboard says backend unavailable**
- Make sure `python3 backend.py` is running in another terminal
- Ensure backend on port 5000 (default)

---

## Next Steps
- Add auth or API keys (e.g., protect the dashboard)
- Push metrics to a file or endpoint
- Containerize the frontend using the same shell.nix
