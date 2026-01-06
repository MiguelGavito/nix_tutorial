# Quick Package Testing

**Time:** 10 minutes  
**Prerequisites:** Nix installed ([Installation Guide](00-installation.md))  
**Goal:** Learn how to instantly test tools without installing them permanently or creating a shell.nix

## The Idea

Instead of `apt-get install`, `brew install`, or creating `shell.nix`, just use one command to test *any* tool instantly. Once you exit, it's gone. Perfect for quick experimentation.

## Scenario

You heard about a cool tool (like `docker`, `terraform`, or a fancy CLI tool) but don't want to install it permanently. With Nix, you can try it instantly.

## The Commands

### 1) `nix run` (run a single command immediately)

Use `nix run` to run a package from nixpkgs directly:

```bash
# Try docker (if not installed)
nix run nixpkgs#docker -- --version

# Try terraform
nix run nixpkgs#terraform -- version

# Try PostgreSQL client
nix run nixpkgs#postgresql -- psql --version

# Try httpie (like curl but prettier)
nix run nixpkgs#httpie -- --help

# Try nodejs without installing it
nix run nixpkgs#nodejs_20 -- --version

### 2) `nix-shell -p <package>` (quick throwaway shell)

```bash
# Open a temporary shell with a single package
nix-shell -p nodejs_20
node --version
exit  # Node disappears when you exit

# Multiple packages
nix-shell -p docker docker-compose sqlite
docker --version
sqlite3 --version
exit
```

Same idea with the new syntax:

```bash
nix shell nixpkgs#nodejs_20 nixpkgs#docker
```
```

## Interactive Examples - See It Work

### Show Off to Your Team: Cool CLI Tools

Try these **without installing anything**:

#### 1. System Info (neofetch)
```bash
# Shows system info in a fancy way
nix run nixpkgs#neofetch
```

See your system info displayed beautifully. Great demo of "no installation needed".

#### 2. ASCII Art Text (figlet)
```bash
# Turn text into ASCII art
nix run nixpkgs#figlet -- "Hello Nix"

# Make it fancy with cowsay
nix run nixpkgs#cowsay -- "Nix is awesome!"

# Combine them
nix run nixpkgs#figlet -- "Team" | nix run nixpkgs#cowsay -- "$(cat)"
```

Visual demo - your team will see something cool happen instantly.

#### 3. Pretty HTTP Requests (httpie)
```bash
# Like curl but prettier, shows colored output
nix run nixpkgs#httpie -- GET https://jsonplaceholder.typicode.com/posts/1

# Test your local API while it's running
nix run nixpkgs#httpie -- POST http://localhost:5000/api/test
```

#### 4. Tree View (tree)
```bash
# Show folder structure in a nice tree format
nix run nixpkgs#tree -- -L 2

# Only show markdown files
nix run nixpkgs#tree -- -I 'node_modules' --
```

#### 5. Quick Data Processing (jq)
```bash
# Parse JSON beautifully
echo '{"name":"Alice","age":30}' | nix run nixpkgs#jq -- '.'

# Extract specific fields
nix run nixpkgs#httpie -- GET https://jsonplaceholder.typicode.com/users/1 | nix run nixpkgs#jq -- '.name'
```

### Real Use Case: Test Database Tools

```bash
# Try SQLite WITHOUT installing it
nix run nixpkgs#sqlite -- << 'EOF'
CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
SELECT * FROM users;
.quit
EOF

# Output:
# 1|Alice
# 2|Bob
```

### Temporary Environment with Multiple Tools

```bash
# Open a shell with multiple tools available
nix shell nixpkgs#postgresql nixpkgs#sqlite nixpkgs#redis

# All are available now
psql --version
sqlite3 --version
redis-cli --version

# Exit and they're gone
exit
```

## Real Examples

### Test a Database Tool

```bash
# Try SQLite without installing
nix run nixpkgs#sqlite -- --version

# Test with a database
nix run nixpkgs#sqlite -- << 'EOF'
CREATE TABLE users (id INTEGER, name TEXT);
INSERT INTO users VALUES (1, 'Alice');
SELECT * FROM users;
EOF
```

### Test Python Tools

```bash
# Try black (code formatter)
nix run nixpkgs#black -- --version

# Try a full Python script in an environment
nix shell nixpkgs#python3Packages.requests -c python3 << 'EOF'
import requests
print(requests.__version__)
EOF
```

### Create a Temporary Environment

```bash
# Create a temporary shell with multiple tools
nix shell nixpkgs#docker nixpkgs#docker-compose nixpkgs#postgresql

# Use them
docker --version
docker-compose --version
psql --version

# Exit and they're gone
exit
```

## Finding Packages

Search for what you want:

```bash
# Search online
# https://search.nixos.org/packages

# Or from terminal
nix search nixpkgs docker
```

## When to Use Each Approach

### Quick Test (One-off command)
```bash
# Use `nix run` when you want to TRY something quickly
nix run nixpkgs#postgresql -- psql --version
# Perfect for: Testing, learning, quick demos
# Cleanup: Automatic when you exit
```

### Proper Setup (For your project)
```bash
# Use `shell.nix` when it's part of your project
# Create shell.nix, commit to git, everyone uses it
# Perfect for: Team development, reproducibility
```

**Example decision tree:**
- "I want to test PostgreSQL" → Use `nix run nixpkgs#postgresql`
- "Our team project needs PostgreSQL" → Add to `shell.nix`
- "I wonder if terraform works" → Use `nix run nixpkgs#terraform`
- "We need terraform in production CI/CD" → Add to `shell.nix` or flake.nix

## Benefits

- ✅ **No installation** - No polluting your system
- ✅ **No conflicts** - Different projects can use different versions
- ✅ **Fast** - Cached, no download if you've used it before
- ✅ **Safe** - Automatically isolated, easy cleanup
- ✅ **Team-friendly** - Document what tools you need

---

**Next:** Understand differences across [Platforms](06-platform-differences.md)
