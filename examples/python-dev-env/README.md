# Python Example - GitHub Repository Analyzer

**What this shows:** A practical CLI tool that fetches and displays GitHub repository statistics.

**Real use case:** Quickly analyze any GitHub repo - stars, forks, issues, size, etc.

---

## The Files

```
python-dev-env/
├── shell.nix    ← Nix configuration (Python + requests + rich)
├── app.py       ← GitHub analyzer CLI tool
└── README.md    ← This file
```

**What Nix provides:**
- Python 3
- `requests` library (for HTTP calls to GitHub API)
- `rich` library (for beautiful terminal output)

---

## How to Run

### Step 1: Enter Nix Environment

```bash
cd examples/python-dev-env
nix-shell
```

**What just happened?**
- Nix provided Python 3, requests, and rich libraries
- They're NOW available in this shell
- NOT installed globally on your system

### Step 2: Analyze Any GitHub Repository

```bash
# Analyze a famous repository
python3 app.py torvalds/linux

# Analyze GitHub's Hello World
python3 app.py octocat/Hello-World

# Analyze your own repo
python3 app.py <your-username>/<your-repo>
```

You should see a beautiful formatted output with:
- Repository information
- Statistics (stars, forks, issues)
- Creation date and last update
- Language and license

---

## Example Output

```
Fetching stats for torvalds/linux...

╭─────────────── 📊 Repository Information ───────────────╮
│                                                          │
│ Repository:   torvalds/linux                            │
│ Description:  Linux kernel source tree                  │
│ Created:      2011-09-04                                │
│ Language:     C                                         │
│ License:      GPL-2.0                                   │
│                                                          │
╰──────────────────────────────────────────────────────────╯

                    Statistics
┏━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━┓
┃ Metric             ┃    Count ┃
┡━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━┩
│ ⭐ Stars           │   150000 │
│ 👀 Watchers        │   150000 │
│ 🍴 Forks           │    50000 │
│ 🐛 Open Issues     │      400 │
│ 📦 Size (KB)       │  4500000 │
└────────────────────┴──────────┘

✓ Repository is public
✓ Default branch: master
```

---

## What's the Benefit of Nix?

### WITHOUT Nix:
```bash
# Install Python and libraries globally
pip3 install requests rich

# Now they're on your system forever
# What if another project needs different versions?
# What if you want to clean up?
```

### WITH Nix:
```bash
nix-shell          # Get Python + libraries
python3 app.py ... # Use them
exit               # They're gone

# Clean system, no conflicts
```

**Team benefit:** Everyone gets EXACT same Python version and library versions. The tool works identically for everyone.

---

## Try Modifying It

### Add more statistics:

Edit `app.py` and add to the table:

```python
table.add_row("📝 Commits", "Coming soon")  # Add GitHub API call for commits
table.add_row("👥 Contributors", "Coming soon")  # Add contributors count
```

### Change the output style:

```python
# Try different table styles
table = Table(title="Statistics", box=box.DOUBLE)
table = Table(title="Statistics", box=box.MINIMAL)
```

---

## Cleanup & Exit

### Stop Using the Tool

Just finish running it (it exits automatically after displaying stats).

### Exit Nix Environment

```bash
exit
```

**What happens:**
- nix-shell closes
- Python + requests + rich are no longer in PATH
- Your system is clean

---

## Understanding shell.nix

Look at `shell.nix`:

```nix
buildInputs = with pkgs; [
  python3                    # Python interpreter
  python3Packages.requests   # HTTP library for API calls
  python3Packages.rich       # Beautiful terminal formatting
];
```

**This tells Nix:** "Give me these exact tools."

If you need more libraries, add them here:
```nix
python3Packages.pandas   # Data analysis
python3Packages.numpy    # Math operations
```

---

## Common Issues

**"ModuleNotFoundError: No module named 'requests'"**
```bash
# You're not in nix-shell
nix-shell
```

**"API rate limit exceeded"**
```bash
# GitHub API limits unauthenticated requests
# For more requests, use a GitHub token:
export GITHUB_TOKEN=your_token
# (modify app.py to use it in headers)
```

**"Repository not found"**
```bash
# Check the format: owner/repo (case-sensitive)
python3 app.py microsoft/vscode  # ✓ Correct
python3 app.py vscode            # ✗ Wrong
```

---

## Real-World Use

This tool demonstrates a pattern you'll use often:
1. **HTTP API calls** - Fetch data from external services
2. **Data processing** - Parse and format JSON
3. **Pretty output** - Display results nicely
4. **CLI arguments** - Make it usable from terminal

**Similar real tools your team might build:**
- Service health checker
- Database query tool
- Log analyzer
- Deployment status checker

---

## Next Steps

1. **Modify it** - Add more GitHub stats (pull requests, releases)
2. **Add features** - Save output to JSON file
3. **Try Node.js** - See `../nodejs-dev-env/` for API monitoring
4. **Share with team** - Commit shell.nix, everyone gets same environment
