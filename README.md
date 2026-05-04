# 🎯 Unified Dotfiles with OS-Specific Profiles

Sync your dotfiles across **macOS** and **WSL2** with automatic OS detection and environment-specific configurations.

## 📋 Overview

This dotfiles repo manages:
- **Alacritty** (terminal emulator)
- **Nvim** (neovim editor)
- **Tmux** (terminal multiplexer)

Each tool has **OS-specific profile files** that auto-load based on your system:
- **macOS**: Uses Command key bindings (Cmd+1, Cmd+H, etc.)
- **WSL2**: Uses Ctrl+Shift bindings (Ctrl+Shift+1, Ctrl+Shift+H, etc.)

## 🗂️ Directory Structure

```
~/dotfiles/
├── setup.sh                    # Main setup script (run after git pull)
├── .git/hooks/post-merge      # Auto-runs setup.sh after pull
│
├── alacritty/
│   ├── alacritty.toml         # Main config (imports OS-specific)
│   └── os/
│       ├── mac.toml           # macOS keybindings (Cmd+...)
│       └── wsl.toml           # WSL2 keybindings (Ctrl+Shift+...)
│
├── nvim/
│   ├── init.lua               # Main config (detects OS & loads profile)
│   └── os/
│       ├── mac.lua            # macOS keybindings (Cmd+...)
│       └── wsl.lua            # WSL2 keybindings (Ctrl+...)
│
└── tmux/
    ├── tmux.conf              # Main config (if-shell for OS detection)
    └── os/
        ├── mac.conf           # macOS keybindings (Alt+...)
        └── wsl.conf           # WSL2 keybindings (Ctrl+Shift+...)
```

## 🚀 Quick Start

### Initial Setup (First Time)

```bash
# Clone or navigate to dotfiles repo
cd ~/dotfiles

# Run setup script
./setup.sh
```

This will:
1. ✅ Detect your OS (macOS or WSL2)
2. ✅ Create symlinks in `~/.config/` → dotfiles repo
3. ✅ Update Alacritty to import correct OS profile
4. ✅ Install git post-merge hook
5. ✅ Load correct keybindings

### After Git Pull

```bash
cd ~/dotfiles
git pull
```

The git post-merge hook will **automatically run setup.sh**, so everything updates instantly.

## 🔄 How It Works

### For Alacritty
```toml
# alacritty.toml
[general]
import = [
  "~/.config/alacritty/os-profiles/mac.toml"  # Auto-updated by setup.sh
]
```
- **Setup script** detects OS and updates the import path
- Import points to either `mac.toml` or `wsl.toml`

### For Nvim
```lua
-- init.lua
local current_os = get_os()  -- Detects macOS or WSL2
dofile(vim.fn.stdpath('config') .. '/os-profiles/' .. current_os .. '.lua')
```
- **Runtime detection** (no setup needed)
- Auto-loads `mac.lua` or `wsl.lua`

### For Tmux
```bash
# tmux.conf
if-shell "uname | grep -q Darwin" {
    source-file ~/.config/tmux/os-profiles/mac.conf
} {
    source-file ~/.config/tmux/os-profiles/wsl.conf
}
```
- **Built-in conditionals** (no setup needed)
- Auto-loads `mac.conf` or `wsl.conf`

## 🎛️ OS-Specific Features

### macOS Profile
- **Alacritty**: Command key bindings (Cmd+1, Cmd+Shift+H, etc.)
- **Nvim**: Command key support (Cmd+S for save, etc.)
- **Tmux**: Alt key bindings for quick navigation

### WSL2 Profile
- **Alacritty**: Ctrl+Shift key bindings (Ctrl+Shift+1, Ctrl+Shift+H, etc.)
- **Nvim**: Ctrl key bindings (Ctrl+S for save, etc.)
- **Tmux**: Ctrl+Shift key bindings (Ctrl+Shift+1, Ctrl+Shift+H, etc.)

## 🔧 Customization

### Edit Shared Settings
Edit these files to customize **all platforms**:
- `alacritty/alacritty.toml` (theme, fonts, window settings)
- `nvim/init.lua` (shared vim settings, plugins)
- `tmux/tmux.conf` (shared tmux settings)

### Edit OS-Specific Settings
Edit these files to customize **per platform**:
- `alacritty/os/mac.toml` and `alacritty/os/wsl.toml`
- `nvim/os/mac.lua` and `nvim/os/wsl.lua`
- `tmux/os/mac.conf` and `tmux/os/wsl.conf`

### Example: Adding a New Alacritty Keybinding

**For macOS only** (in `alacritty/os/mac.toml`):
```toml
[[keyboard.bindings]]
chars = "hello"
key = "H"
mods = "Command"
```

**For WSL2 only** (in `alacritty/os/wsl.toml`):
```toml
[[keyboard.bindings]]
chars = "hello"
key = "H"
mods = "Control|Shift"
```

## 📝 Common Tasks

### After Changing Configs

**Option 1**: Manual sync
```bash
cd ~/dotfiles
./setup.sh
```

**Option 2**: Automatic (via git)
```bash
cd ~/dotfiles
git add .
git commit -m "Update configs"
git push
```

Then on other machine:
```bash
git pull  # Post-merge hook runs setup.sh automatically!
```

### Switch Between Machines

1. **On machine A** (e.g., macOS):
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "Update macOS configs"
   git push
   ```

2. **On machine B** (e.g., WSL2):
   ```bash
   cd ~/dotfiles
   git pull  # Auto-runs setup.sh, loads WSL2 configs
   ```

### Add Font/Color Changes

Edit the main config files:
- `alacritty/alacritty.toml` - Font sizes, padding, opacity
- `nvim/init.lua` - Shared vim settings
- `tmux/tmux.conf` - Shared tmux settings

Changes automatically apply to all platforms (no OS-specific logic needed).

## 🐛 Troubleshooting

### Setup script not running after git pull

Check if hook was installed:
```bash
ls -la ~/dotfiles/.git/hooks/post-merge
cat ~/dotfiles/.git/hooks/post-merge  # Should show setup.sh call
```

Reinstall hook:
```bash
cd ~/dotfiles
./setup.sh
```

### Symlinks not working

Verify symlinks were created:
```bash
ls -la ~/.config/alacritty/alacritty.toml
ls -la ~/.config/nvim/init.lua
ls -la ~/.config/tmux/tmux.conf
```

Should show `→ /Users/kit/dotfiles/...`

If not, run setup.sh again:
```bash
~/dotfiles/setup.sh
```

### Wrong keybindings loaded

Verify OS detection:
```bash
# On macOS
uname  # Should output: Darwin

# On WSL2
uname  # Should output: Linux
grep microsoft /proc/version  # Should return result
```

Check which config is active:
```bash
# Alacritty
cat ~/.config/alacritty/alacritty.toml | grep "import ="

# Nvim
nvim +":echo get_os()" +quit

# Tmux
cat ~/.config/tmux/tmux.conf | grep "if-shell"
```

## 🔐 Security Notes

- `.git/hooks/post-merge` is executable (don't commit `.git` to repo)
- Symlinks resolve to dotfiles repo - ensure repo permissions are correct
- Review OS-specific configs before pulling from public sources

## 📚 Next Steps

1. **Customize keybindings** in `os/mac.conf` and `os/wsl.conf`
2. **Add more tools** (Fish, Zsh, etc.) following the same pattern
3. **Update fonts** in `alacritty/alacritty.toml`
4. **Sync to GitHub** and pull on other machines

---

**Last Updated**: 2026-05-04
**Tested On**: macOS (Darwin), Git 2.50+
**Platforms**: macOS, WSL2
