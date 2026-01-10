# Testing Nixpkgs Programs

**Time:** 25 minutes  
**Prerequisites:** Nix installed ([Installation Guide](00-installation.md)) + Home Manager configured  
**Goal:** Test real-world CLI programs from nixpkgs without permanent installation, then install them system-wide using Home Manager

## Scenario

You want to test a terminal music player and downloader without committing to your system. Download a song, play it, verify it works—then decide to keep it or remove it. All managed through declarative configuration.

## Prerequisites Setup

### 1. Nix Installed

Verify Nix is working:
```bash
nix --version
```

If not installed, follow the [Installation Guide](00-installation.md)

### 2. Home Manager Installed

Check if Home Manager is already set up:
```bash
home-manager --version
```

**If you see a version number:** Great! Skip to [Part 1](#part-1-search-programs-in-nixpkgs)

**If command not found:** Install Home Manager:

home manager documentation and install: https://home-manager.dev/

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

This creates `~/.config/home-manager/home.nix` with basic configuration.

### 3. Verify Home Manager Works

```bash
home-manager switch
```

If successful, you're ready! If there are errors, Home Manager likely detected conflicting config—that's safe, it won't break anything.

## Part 1: Search Programs in nixpkgs

Search for programs directly on **[nixos.org/packages](https://search.nixos.org/packages)** or use the terminal:

```bash
nix search nixpkgs kew
nix search nixpkgs ytmdl
```

**What you see:**
- `version` - Which version is available
- `description` - What it does
- `repo` - Which nixpkgs channel has it

**Tip:** If a program name isn't obvious, search by function: try searching "music" to find `ytmdl`.

## Part 2: Test in a Temporary Shell

Create an isolated environment with both programs without installing them permanently:

```bash
nix-shell -p kew ytmdl
```

**Breakdown:**
- `nix-shell` - Creates temporary, isolated environment
- `-p` - "packages" flag (what you want to install temporarily)
- `kew ytmdl` - Space-separated package names

Now you're inside the ephemeral shell. Try them:

### Download a Test Song

```bash
ytmdl "Scarlet Forest"
```

Follow the prompts:
1. Select music directory (default is `~/Music`)
2. Choose the title you want
3. Pick the album
4. Wait for download to complete

### Play the Song

```bash
kew
```

- Navigate with arrow keys to your song
- Press Enter to play
- You've now tested both programs!

### Exit Test Environment

```bash
exit
```

The programs are gone—they were only in that temporary shell. Your system is unchanged.

## Part 3: What is Home Manager?

**Home Manager** is the configuration manager for your user's home directory.

**Traditional approach:** Install programs one by one, configure each manually, files scattered everywhere  
**Home Manager approach:** Declare everything in one `home.nix` file, apply it all at once, portable across machines

### What Home Manager Does:

1. **Downloads programs** - Your declared packages are installed
2. **Creates config files** - Automatically generates configuration files
3. **Configures system behavior** - Shell themes, aliases, environment variables
4. **Points files to Nix store** - Your config symlinks to immutable Nix store

**Key benefit:** You can export this file to another machine and have identical setup instantly.

## Part 4: Install Permanently with Home Manager

Edit your `home.nix` file (usually `~/.config/home-manager/home.nix`):

Find the `home.packages` section and add our programs:

```nix
home.packages = with pkgs; [
  # ... existing packages ...
  kew
  ytmdl
];
```

Apply the configuration:

```bash
home-manager switch
```

### Finding Your home.nix

Home Manager looks for configuration at:
- **Standard:** `~/.config/home-manager/home.nix`
- **Custom path:** If you use a different location, run:
  ```bash
  home-manager -f /your/custom/path/home.nix switch
  ```

(Advanced users: adapt the path to your setup)

### ⚠️ If You Already Have zsh Configured

If you already have custom zsh settings:

```bash
# Check if you have existing zsh config
cat ~/.zshrc | head -20
```

**If you see custom settings:**
- **Option 1 (Safer):** Only add packages, skip zsh config:
  ```nix
  home.packages = with pkgs; [
    kew
    ytmdl
  ];
  # Don't add the programs.zsh section
  ```
  
- **Option 2 (Advanced):** Merge your settings into Home Manager's zsh config

Home Manager takes over shell configuration, so if you have pre-existing custom zsh settings, skipping the `programs.zsh` section keeps your setup safe.

Home Manager now:
- Downloads `kew` and `ytmdl` permanently
- Creates their config structure in the Nix store
- Points your home directory to them
- They're now always available in your shell

### Verify Installation

```bash
which kew
which ytmdl
ytmdl --help
```

## Part 5: Configure Your Shell (zsh + Theme)

In the same `home.nix`, configure zsh styling:

```nix
programs.zsh = {
  enable = true;
  oh-my-zsh = {
    enable = true;
    theme = "agnoster";  # Beautiful theme
  };
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
};
```

Apply changes:

```bash
home-manager switch
```

Your zsh now has:
- **agnoster theme** - Modern, colorful prompt
- **Auto-suggestions** - Suggestions as you type
- **Syntax highlighting** - Valid commands highlighted

### How It Works Internally

When you apply this config, Home Manager:
1. Generates zsh configuration files
2. Places them in `/nix/store/...` (immutable)
3. Creates symlinks in `~/.config/zsh/` pointing to store
4. Your shell reads from the symlink → gets config from Nix store

This means your configuration is:
- **Version controlled** - It's in your `home.nix`
- **Reproducible** - Same config on any machine
- **Atomic** - Either all changes apply or none do

## Part 6: Remove Programs (If You Change Your Mind)

If you decide `kew` or `ytmdl` doesn't work for you:

### Option 1: Remove from Home Manager

Edit `home.nix` and remove the package lines:

```nix
home.packages = with pkgs; [
  # Removed: kew
  # Removed: ytmdl
];
```

Apply:

```bash
home-manager switch
```

The programs are completely removed.

### Option 2: Clean Up Unused Files

After removing packages, free up disk space:

```bash
nix-collect-garbage -d
```

This removes packages no longer referenced, freeing disk space.

## Summary

**What you've learned:**
1. Search nixpkgs for programs
2. Test programs in temporary shells (no risk)
3. Understand Home Manager's role
4. Permanently install via Home Manager declaration
5. Configure system behavior (zsh theme, aliases)
6. Remove programs if needed

**Next:** Create more examples by adding different tools to your `home.nix`!

