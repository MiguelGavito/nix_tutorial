# Testing GitHub Projects: kew + ytmdl

Quick test setup for downloading and playing music from terminal.

## What's Here

- `shell.nix` - Temporary testing environment (test without installing)
- `home.nix` - Example Home Manager config to install permanently

## Quick Start

### Option 1: Test Without Installing (Safe)

```bash
cd testing-github-projects
nix-shell
```

Now you have `kew` and `ytmdl`:

```bash
# Download a song
ytmdl "Scarlet Forest"

# Play it
kew

# Exit when done
exit
```

Your system is unchanged—everything was temporary.

### Option 2: Install Permanently (Recommended)

**⚠️ Important:** Don't replace your whole `home.nix`! Merge our changes into it.

#### Step 1: Backup Your Current Config

```bash
cp ~/.config/home-manager/home.nix ~/.config/home-manager/home.nix.backup
```

#### Step 2: Add Our Packages

Edit `~/.config/home-manager/home.nix` and find the `home.packages` section:

```nix
home.packages = with pkgs; [
  # ... your existing packages ...
  
  # Add these two:
  kew
  ytmdl
];
```

#### Step 3: (Optional) Add zsh Config

If you don't already have zsh configured, add this section:

```nix
programs.zsh = {
  enable = true;
  oh-my-zsh = {
    enable = true;
    theme = "agnoster";
    plugins = [ "git" "sudo" "history" ];
  };
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
};
```

#### Step 4: Apply Changes

```bash
home-manager switch
```

If something goes wrong:
```bash
cp ~/.config/home-manager/home.nix.backup ~/.config/home-manager/home.nix
home-manager switch
```

Now `kew` and `ytmdl` are part of your system, plus optional zsh theme and aliases.

### If You Change Your Mind

To remove them:

```bash
# Edit your home.nix and remove these lines:
# - kew
# - ytmdl

home-manager switch
```

See the main tutorial: [Testing Nixpkgs Programs](../../docs/07-testing-nixpkgs-programs.md) for full explanations.
