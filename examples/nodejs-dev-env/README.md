# Node.js Express Example - Simple & Clear

**What this shows:** How Nix provides Node.js + npm without installing globally.

---

## The Files

```
nodejs-dev-env/
├── shell.nix     ← Nix configuration (what tools you need)
├── package.json  ← npm dependencies
├── app.js        ← Your Express app (the actual code)
└── README.md     ← This file
```

**Key point:**
- `shell.nix` = "I need Node.js 20 and npm"
- `package.json` = "My app needs Express"
- `app.js` = Your actual application code

---

## How to Run

### Step 1: Enter Nix Environment

```bash
cd examples/nodejs-dev-env
nix-shell
```

**What just happened?**
- Nix provided Node.js 20 and npm
- These are NOW available in your shell
- BUT they're not installed globally
- When you `exit`, they disappear

### Step 2: Install npm Dependencies (First Time Only)

```bash
npm install
```

This installs Express locally in `node_modules/`. 

**Note:** You need to do this inside `nix-shell` because npm needs Node.

### Step 3: Run the App

```bash
node app.js
```

You should see:
```
⚡ Server running on http://localhost:3000
```

### Step 4: Test It

Open your browser or use curl:

```bash
# In another terminal (also inside nix-shell if you want to use curl):
curl http://localhost:3000
curl http://localhost:3000/api/hello
curl http://localhost:3000/api/health
```

Or open http://localhost:3000 in your browser.

---

## What's the Benefit of Nix?

### WITHOUT Nix:
```bash
# Install Node globally
sudo apt install nodejs npm
# OR
brew install node

# Now it's on your system forever
# Different projects might need different Node versions = conflict
```

### WITH Nix:
```bash
# Just enter the environment
nix-shell

# Use Node 20
node --version  # v20.x

# Exit and it's gone
exit

# Your system is clean
```

**The Magic:** Every team member gets the EXACT same Node version. No version conflicts.

---

## Cleanup & Exit

### Stop the Server

Press `Ctrl+C` in the terminal running the app.

### Exit Nix Environment

```bash
exit
```

**What happens when you exit:**
- The nix-shell closes
- Node/npm are no longer in your PATH (unless you have them globally)
- Your system is back to normal

**Note:** `node_modules/` stays (it's your local dependencies). That's normal. Add it to `.gitignore`.

### Clean Everything (Optional)

```bash
# Remove installed dependencies
rm -rf node_modules/

# Remove lock file
rm package-lock.json

# Next time you run nix-shell + npm install, it starts fresh
```

---

## Understanding shell.nix

Open `shell.nix` and look:

```nix
buildInputs = with pkgs; [
  nodejs_20         # Node.js version 20
  nodePackages.npm  # npm package manager
];
```

**This tells Nix:** "When someone runs `nix-shell`, give them Node 20 and npm."

Different projects can use different Node versions by changing `nodejs_20` to `nodejs_18`, etc.

---

## Common Issues

**"Cannot find module 'express'"**
```bash
# You forgot to run npm install. Inside nix-shell:
npm install
```

**"node: command not found"**
```bash
# You're not in nix-shell. Run:
nix-shell
```

**"Address already in use" (port 3000 busy)**
```bash
# Kill whatever's using port 3000:
lsof -ti:3000 | xargs kill -9

# Then try again:
node app.js
```

**"nix-shell: command not found"**
```bash
# Nix isn't installed. See:
# ../../docs/00-installation.md
```

---

## Next Steps

1. **Modify app.js** - Add your own routes, restart to see changes
2. **Change Node version** - Edit `shell.nix`, use `nodejs_18` instead
3. **Share with team** - Commit `shell.nix` and `package.json`, everyone uses same versions
4. **Try Python example** - See `../python-dev-env/`
