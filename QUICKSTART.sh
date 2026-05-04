#!/bin/bash
# 🎯 Dotfiles Sync System - Quick Start Guide

cat << 'EOF'

╔════════════════════════════════════════════════════════════════════════════╗
║                  ✨ DOTFILES SYNC SYSTEM READY! ✨                        ║
╚════════════════════════════════════════════════════════════════════════════╝

🎉 Your unified dotfiles repo is now set up and ready to use!

📁 STRUCTURE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

~/dotfiles/
├── setup.sh                    ← Main setup script
├── .git/hooks/post-merge      ← Auto-runs after git pull ✨
├── README.md                   ← Full documentation
│
├── alacritty/
│   ├── alacritty.toml         ← Main config (imports OS profile)
│   └── os/
│       ├── mac.toml           ← macOS keybindings (Cmd+...)
│       └── wsl.toml           ← WSL2 keybindings (Ctrl+Shift+...)
│
├── nvim/
│   ├── init.lua               ← Auto-detects OS at runtime
│   └── os/
│       ├── mac.lua            ← macOS overrides
│       └── wsl.lua            ← WSL2 overrides
│
└── tmux/
    ├── tmux.conf              ← Auto-detects OS at runtime
    └── os/
        ├── mac.conf           ← macOS keybindings
        └── wsl.conf           ← WSL2 keybindings

🔗 SYMLINKS CREATED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

~/.config/alacritty/alacritty.toml  → ~/dotfiles/alacritty/alacritty.toml
~/.config/alacritty/os-profiles/    → ~/dotfiles/alacritty/os/
~/.config/nvim/init.lua             → ~/dotfiles/nvim/init.lua
~/.config/nvim/os-profiles/         → ~/dotfiles/nvim/os/
~/.config/tmux/tmux.conf            → ~/dotfiles/tmux/tmux.conf
~/.config/tmux/os-profiles/         → ~/dotfiles/tmux/os/

✨ ALL POINTING TO YOUR DOTFILES REPO ✨

🚀 WORKFLOW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. EDIT SHARED CONFIGS
   └─ These apply to all OS:
   
   • alacritty/alacritty.toml     (fonts, theme, window size)
   • nvim/init.lua                (vim settings, plugins)
   • tmux/tmux.conf               (status bar, shared bindings)

2. EDIT OS-SPECIFIC CONFIGS
   └─ These load automatically based on OS:
   
   • alacritty/os/mac.toml        (macOS keybindings only)
   • alacritty/os/wsl.toml        (WSL2 keybindings only)
   • nvim/os/mac.lua              (macOS keybindings only)
   • nvim/os/wsl.lua              (WSL2 keybindings only)
   • tmux/os/mac.conf             (macOS keybindings only)
   • tmux/os/wsl.conf             (WSL2 keybindings only)

3. COMMIT & PUSH
   └─ Version control everything:
   
   $ cd ~/dotfiles
   $ git add .
   $ git commit -m "Update nvim keybindings"
   $ git push

4. SYNC TO OTHER MACHINE
   └─ Auto-detection & setup happens automatically:
   
   $ cd ~/dotfiles
   $ git pull              # ← Post-merge hook runs setup.sh!
   
   ✨ Everything updates with correct OS keybindings ✨

📋 HOW OS DETECTION WORKS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔷 Alacritty
   ├─ setup.sh detects OS → updates import path
   └─ alacritty.toml imports mac.toml OR wsl.toml

🔷 Nvim
   ├─ init.lua detects OS at startup (no setup needed)
   └─ Auto-loads mac.lua OR wsl.lua

🔷 Tmux
   ├─ tmux.conf uses if-shell (built-in OS check)
   └─ Auto-sources mac.conf OR wsl.conf

⌨️  KEYBINDINGS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

macOS Profile:
  Cmd+1 through Cmd+5        → Switch tmux windows
  Cmd+Shift+← →              → Switch windows left/right
  Cmd+Shift+T                → New window
  Cmd+Shift+W                → Close window
  Cmd+Shift+hjkl             → Navigate panes
  Cmd+Shift+M                → Toggle zoom

WSL2 Profile:
  Ctrl+Shift+1 through 5     → Switch tmux windows
  Ctrl+Shift+← →             → Switch windows left/right
  Ctrl+Shift+T               → New window
  Ctrl+Shift+W               → Close window
  Ctrl+Shift+hjkl            → Navigate panes
  Ctrl+Shift+M               → Toggle zoom

🔄 SYNC BETWEEN MACHINES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Machine A (macOS):
  1. Edit ~/dotfiles/alacritty/alacritty.toml
  2. git add . && git commit && git push
  
Machine B (WSL2):
  1. git pull
     ↓
     (post-merge hook automatically runs)
     ↓
     setup.sh detects "wsl"
     ↓
     Updates alacritty import → wsl.toml
     ↓
  2. Alacritty reloads → now uses Ctrl+Shift keybindings ✨

🎯 NEXT STEPS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Customize keybindings:
   • Edit alacritty/os/mac.toml for macOS
   • Edit alacritty/os/wsl.toml for WSL2

2. Add more configs to track:
   • Fish shell
   • Zsh
   • Other tools

3. Push to GitHub:
   $ cd ~/dotfiles && git remote add origin <your-repo-url>
   $ git push -u origin main

4. Clone on new machine:
   $ git clone <your-repo-url> ~/dotfiles
   $ cd ~/dotfiles && ./setup.sh

✅ VERIFICATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Check symlinks:
  $ ls -la ~/.config/alacritty/alacritty.toml
  $ ls -la ~/.config/nvim/init.lua
  $ ls -la ~/.config/tmux/tmux.conf

Check OS detection (should show correct keybindings):
  $ cat ~/.config/alacritty/alacritty.toml | grep "import ="

Check git hook:
  $ cat ~/dotfiles/.git/hooks/post-merge

📚 DOCUMENTATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Full guide:  cat ~/dotfiles/README.md
Setup log:   Look at output above ☝️
Next PR:     Push changes to your dotfiles repo

═════════════════════════════════════════════════════════════════════════════

🎉 You're all set! Your dotfiles are now:
   ✅ Synced across machines
   ✅ OS-aware (macOS/WSL2)
   ✅ Auto-updating via git hooks
   ✅ Version controlled

Happy coding! 🚀

EOF
