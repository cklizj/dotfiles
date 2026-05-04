# 📚 Dotfiles Documentation Index

Welcome to your unified dotfiles sync system!

## 📖 Documentation Files

### 🚀 Start Here
- **[GETTING_STARTED.md](./GETTING_STARTED.md)** - Step-by-step tutorial for new users
  - How to edit configs
  - Workflow: edit → commit → sync
  - Common tasks & troubleshooting

### 📋 Reference
- **[README.md](./README.md)** - Complete technical documentation
  - Overview & structure
  - How it works (Alacritty, Nvim, Tmux)
  - Customization & extension guide
  - Security notes

### 🎯 Quick Reference
- **[QUICKSTART.sh](./QUICKSTART.sh)** - Visual summary (run with `bash QUICKSTART.sh`)
  - Quick visual guide
  - Keybindings reference
  - Next steps

### 📍 This File
- **[INDEX.md](./INDEX.md)** - You are here! Navigation guide

---

## 🎯 Quick Decisions Matrix

| Need | File | Action |
|------|------|--------|
| **Get started** | GETTING_STARTED.md | Read it first |
| **Understand the system** | README.md | Full technical deep dive |
| **Visual overview** | bash QUICKSTART.sh | See colored output |
| **View all keybindings** | GETTING_STARTED.md § 5 | Search "KEYBINDINGS" |
| **See code** | setup.sh | Read the shell script |
| **Troubleshoot** | GETTING_STARTED.md § 9 | Common problems & solutions |
| **Extend to more tools** | README.md § Customization | Instructions for adding new tools |

---

## 📂 Directory Structure Quick Ref

```
~/dotfiles/
├── setup.sh                   ← Run this to set up
├── .git/hooks/post-merge     ← Runs automatically after git pull
│
├── Documentation:
│   ├── INDEX.md              ← Navigation (this file)
│   ├── README.md             ← Full guide
│   ├── GETTING_STARTED.md    ← Tutorial
│   └── QUICKSTART.sh         ← Visual summary
│
└── Configs (by tool):
    ├── alacritty/
    │   ├── alacritty.toml    ← Shared (imports OS profile)
    │   └── os/
    │       ├── mac.toml      ← macOS keybindings
    │       └── wsl.toml      ← WSL2 keybindings
    ├── nvim/
    │   ├── init.lua          ← Auto-detects OS at startup
    │   └── os/
    │       ├── mac.lua       ← macOS overrides
    │       └── wsl.lua       ← WSL2 overrides
    └── tmux/
        ├── tmux.conf         ← Auto-detects OS
        └── os/
            ├── mac.conf      ← macOS keybindings
            └── wsl.conf      ← WSL2 keybindings
```

---

## 🔄 Typical Workflows

### Workflow 1: Edit & Sync

```bash
# 1. Edit config
vim ~/dotfiles/alacritty/alacritty.toml

# 2. Test it
# (reload Alacritty)

# 3. Commit & push
cd ~/dotfiles
git add . && git commit -m "Update alacritty font" && git push

# 4. On other machine: git pull (hook runs automatically!)
```

**See:** GETTING_STARTED.md § 4

### Workflow 2: OS-Specific Change

```bash
# 1. Edit macOS profile only
vim ~/dotfiles/alacritty/os/mac.toml

# 2. Add/change Command key binding

# 3. Commit & sync
git add . && git commit -m "Add Cmd+E binding" && git push

# Result: macOS gets new binding, WSL2 unaffected
```

**See:** GETTING_STARTED.md § 5 "Add a New Keybinding"

### Workflow 3: Setup New Machine

```bash
# On new machine:
git clone https://github.com/you/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh  # Creates symlinks, detects OS
git pull    # Post-merge hook auto-runs!
```

**See:** GETTING_STARTED.md § 7 "Push to GitHub"

---

## 🎯 Common Questions

### Q: Where do I edit Alacritty config?
**A:** `~/dotfiles/alacritty/alacritty.toml` (shared) or `~/dotfiles/alacritty/os/*.toml` (OS-specific)
See: GETTING_STARTED.md § 3

### Q: How does OS detection work?
**A:** Different mechanisms per tool:
- **Alacritty**: setup.sh detects & updates import path
- **Nvim**: init.lua detects at startup
- **Tmux**: tmux.conf uses if-shell

See: GETTING_STARTED.md § 6 "How OS Detection Works"

### Q: Will macOS keybindings break on WSL2?
**A:** No! Each OS gets its own keybindings automatically.
- macOS → loads mac.toml/mac.lua/mac.conf
- WSL2 → loads wsl.toml/wsl.lua/wsl.conf

See: GETTING_STARTED.md § 4 "Workflow"

### Q: How do I add a new tool (e.g., Fish)?
**A:** Follow the same pattern:
1. Create `fish/config.fish` (shared)
2. Create `fish/os/mac.fish` and `fish/os/wsl.fish`
3. Update setup.sh to symlink
4. Update config.fish with OS detection

See: README.md § "Customization" or GETTING_STARTED.md § 8 "Customization Ideas"

### Q: Is my config backed up?
**A:** Yes! Git is your backup.
```bash
cd ~/dotfiles
git log --oneline  # See all changes
git diff HEAD~1    # See last change
git checkout <hash>  # Revert if needed
```

### Q: How do I troubleshoot symlinks?
**A:** Run these checks:
```bash
ls -la ~/.config/alacritty/alacritty.toml  # Should show →
ls -la ~/.config/nvim/init.lua
ls -la ~/.config/tmux/tmux.conf

# If broken, re-run:
~/dotfiles/setup.sh
```

See: GETTING_STARTED.md § 9 "Troubleshooting"

---

## 🚀 Getting Started (3 Steps)

1. **Read** GETTING_STARTED.md (10 min)
2. **Make a test change** (edit a font size)
3. **Sync to another machine** (git pull to see it work)

Then you're ready to customize!

---

## 📞 Support

- **Technical questions**: See README.md
- **How-to questions**: See GETTING_STARTED.md
- **Visual overview**: Run `bash ~/dotfiles/QUICKSTART.sh`
- **See the code**: `cat ~/dotfiles/setup.sh`

---

## 📈 Next Steps

- [ ] Read GETTING_STARTED.md
- [ ] Make a small test change
- [ ] Test on another machine
- [ ] Push to GitHub
- [ ] Add more tools (Fish, Zsh, etc.)
- [ ] Customize keybindings
- [ ] Share with team/friends

---

## 🎓 Understanding the System

**High Level:**
- One dotfiles repo syncs across machines
- Each tool has shared + OS-specific configs
- OS automatically detected (macOS vs WSL2)
- Post-merge hook runs setup.sh after git pull
- Keybindings never break on OS switch

**Low Level:**
- Symlinks in ~/.config/ point to ~/dotfiles/
- Edits in ~/dotfiles/ are version controlled
- OS detection happens at setup-time (Alacritty) or runtime (Nvim/Tmux)
- Git hooks automate the sync

**More Details:** See README.md or GETTING_STARTED.md

---

Last Updated: 2026-05-04
