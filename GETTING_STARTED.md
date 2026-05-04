# 🚀 Getting Started with Your Dotfiles

Your unified dotfiles sync system is ready! Here's what to do next.

## 1️⃣ Understand the Structure

```
~/dotfiles/
├── setup.sh                  ← Runs on every machine (detects OS)
├── .git/hooks/post-merge     ← Auto-runs setup.sh after git pull
├── README.md                 ← Full documentation
│
├── alacritty/
│   ├── alacritty.toml        ← Shared config (fonts, theme)
│   └── os/
│       ├── mac.toml          ← macOS keybindings only
│       └── wsl.toml          ← WSL2 keybindings only
│
├── nvim/
│   ├── init.lua              ← Auto-detects OS at startup
│   └── os/
│       ├── mac.lua           ← macOS keybindings only
│       └── wsl.lua           ← WSL2 keybindings only
│
└── tmux/
    ├── tmux.conf             ← Auto-detects OS via if-shell
    └── os/
        ├── mac.conf          ← macOS keybindings only
        └── wsl.conf          ← WSL2 keybindings only
```

## 2️⃣ Your Config Files Are Now Symlinked

Each tool's config is now a symlink pointing back to the dotfiles repo:

```bash
# Verify symlinks
ls -la ~/.config/alacritty/alacritty.toml  # → ~/dotfiles/alacritty/alacritty.toml
ls -la ~/.config/nvim/init.lua             # → ~/dotfiles/nvim/init.lua
ls -la ~/.config/tmux/tmux.conf            # → ~/dotfiles/tmux/tmux.conf
```

This means:
- ✅ **One source of truth** - Edit in `~/dotfiles/`, changes apply everywhere
- ✅ **Easy sync** - `git pull` updates all machines
- ✅ **Version controlled** - Full history of changes

## 3️⃣ How to Edit Configs

### For Shared Settings (All Machines)
These apply to macOS AND WSL2:

```bash
# Edit fonts, theme, window settings
vim ~/dotfiles/alacritty/alacritty.toml

# Edit vim settings (tabs, colors, plugins)
vim ~/dotfiles/nvim/init.lua

# Edit tmux shared settings
vim ~/dotfiles/tmux/tmux.conf
```

### For OS-Specific Settings (One OS Only)
These apply ONLY on that OS:

```bash
# macOS only
vim ~/dotfiles/alacritty/os/mac.toml
vim ~/dotfiles/nvim/os/mac.lua
vim ~/dotfiles/tmux/os/mac.conf

# WSL2 only
vim ~/dotfiles/alacritty/os/wsl.toml
vim ~/dotfiles/nvim/os/wsl.lua
vim ~/dotfiles/tmux/os/wsl.conf
```

## 4️⃣ Workflow: Edit → Commit → Sync

### On macOS (or any machine)

```bash
# 1. Edit a shared config
vim ~/dotfiles/alacritty/alacritty.toml
# (e.g., change font size from 13 to 14)

# 2. Commit & push
cd ~/dotfiles
git add .
git commit -m "Increase alacritty font size to 14"
git push

# 3. Reload alacritty (Cmd+, for preferences or restart)
```

### On WSL2 (another machine)

```bash
# 1. Pull changes
cd ~/dotfiles
git pull
# ↓ Post-merge hook automatically runs!
# ↓ setup.sh detects WSL2
# ↓ Updates alacritty to use wsl.toml keybindings
# ✨ Changes applied!

# 2. Alacritty reloads
# - Font size is now 14 (from shared config)
# - Keybindings are Ctrl+Shift (from wsl.toml)
```

## 5️⃣ Common Tasks

### Add a New Keybinding (macOS)

```bash
# Edit macOS profile
vim ~/dotfiles/alacritty/os/mac.toml

# Add:
[[keyboard.bindings]]
chars = "my_action"
key = "A"
mods = "Command"

# Commit
git add . && git commit -m "Add Cmd+A keybinding" && git push
```

### Change Font Across All Machines

```bash
# Edit shared config
vim ~/dotfiles/alacritty/alacritty.toml

# Change line:
# family = "FiraCode Nerd Font"
# to:
# family = "JetBrains Mono Nerd Font"

# Commit
git add . && git commit -m "Switch to JetBrains Mono" && git push

# Result: All machines (after git pull) use the new font ✨
```

### Fix a Tmux Binding (WSL2)

```bash
# Edit WSL2 tmux profile
vim ~/dotfiles/tmux/os/wsl.conf

# Make your changes

# Commit & push
git add . && git commit -m "Fix tmux pane navigation on WSL2" && git push
```

## 6️⃣ How OS Detection Works

### Alacritty
- **When**: After you run `setup.sh`
- **How**: `uname` command + check `/proc/version`
- **Action**: Updates the `import =` line in `alacritty.toml`
- **Result**: Alacritty imports `mac.toml` or `wsl.toml` ✨

### Nvim
- **When**: When nvim starts
- **How**: `get_os()` function detects at runtime
- **Action**: Automatically loads `mac.lua` or `wsl.lua`
- **Result**: Correct keybindings available immediately ✨

### Tmux
- **When**: When tmux starts
- **How**: Built-in `if-shell` command with `uname`
- **Action**: Sources `mac.conf` or `wsl.conf`
- **Result**: Correct keybindings available immediately ✨

## 7️⃣ Next: Push to GitHub

### Create a GitHub Repo

```bash
# Create a repo on GitHub (can be private)
# Then add it:

cd ~/dotfiles
git remote add origin https://github.com/YOUR_USERNAME/dotfiles.git
git branch -M main
git push -u origin main
```

### Clone on a New Machine

```bash
# On WSL2 or another macOS machine:
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh

# ✨ Everything is set up! ✨
```

### Keep Syncing

```bash
# On any machine:
cd ~/dotfiles
git pull  # ← Post-merge hook auto-runs setup.sh!
# Done! All configs updated with correct OS keybindings
```

## 8️⃣ Customization Ideas

### Add Fish Shell
```
~/dotfiles/
└── fish/
    ├── config.fish        (shared settings)
    └── os/
        ├── mac.fish       (macOS specific)
        └── wsl.fish       (WSL2 specific)
```

### Add Zsh
```
~/dotfiles/
└── zsh/
    ├── .zshrc             (shared)
    └── os/
        ├── mac.zshrc      (macOS specific)
        └── wsl.zshrc      (WSL2 specific)
```

### Follow the Same Pattern
1. Create directory with main config file
2. Create `os/mac.*` and `os/wsl.*` for OS-specific stuff
3. Update `setup.sh` to handle symlinks
4. Update `tmux.conf` / `init.lua` for auto-detection

## 9️⃣ Troubleshooting

### Symlinks Not Working
```bash
# Verify symlinks exist
ls -la ~/.config/alacritty/alacritty.toml

# If broken, re-run setup
~/dotfiles/setup.sh
```

### Git Hook Not Running
```bash
# Check if installed
cat ~/dotfiles/.git/hooks/post-merge

# If missing, re-run setup
~/dotfiles/setup.sh

# Or reinstall manually:
mkdir -p ~/dotfiles/.git/hooks
chmod +x ~/dotfiles/setup.sh
~/dotfiles/setup.sh
```

### Wrong Keybindings Loaded
```bash
# Check which profile is active
grep -A 3 "general" ~/.config/alacritty/alacritty.toml | grep -E "mac|wsl"

# Should show: mac.toml on macOS, wsl.toml on WSL2
# If wrong, run: ~/dotfiles/setup.sh
```

## 🎯 Summary

You now have:
- ✅ One dotfiles repo synced across machines
- ✅ Automatic OS detection (macOS vs WSL2)
- ✅ Auto-syncing via git hooks
- ✅ OS-specific keybindings that never conflict
- ✅ Easy to extend to more tools

**Start by:**
1. Make a small edit (e.g., change font size)
2. Commit & push
3. Pull on another machine
4. Watch the magic happen! ✨

---

For more details, see `README.md` in this directory.
