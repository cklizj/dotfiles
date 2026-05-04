#!/bin/bash
# Unified setup script for dotfiles
# Detects OS, creates symlinks, and configures tools

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Detect OS
detect_os() {
    if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "mac"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
echo -e "${GREEN}🔍 Detected OS: $OS${NC}"

# Validate OS
if [[ "$OS" == "unknown" ]]; then
    echo -e "${RED}❌ Unknown OS detected. Supported: mac, linux, wsl${NC}"
    exit 1
fi

# Function to create symlink
create_symlink() {
    local src="$1"
    local dst="$2"
    
    if [[ ! -e "$src" ]]; then
        echo -e "${RED}❌ Source not found: $src${NC}"
        return 1
    fi
    
    # Remove existing symlink or file
    if [[ -L "$dst" ]] || [[ -e "$dst" ]]; then
        rm -f "$dst"
    fi
    
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo -e "${GREEN}✅ Symlinked: $src → $dst${NC}"
}

# Function to update alacritty import (with proper TOML handling)
update_alacritty_import() {
    local config_file="$SCRIPT_DIR/alacritty/alacritty.toml"
    
    # Check if file exists
    if [[ ! -f "$config_file" ]]; then
        echo -e "${RED}❌ Alacritty config not found: $config_file${NC}"
        return 1
    fi
    
    # Create backup
    cp "$config_file" "$config_file.bak"
    
    # Use Python for reliable TOML editing (avoids duplicate keys)
    python3 << 'PYTHON_SCRIPT'
import sys
import os

os_name = os.environ.get('OS', 'mac')
config_path = os.environ.get('CONFIG_PATH', '')

if not config_path or not os.path.exists(config_path):
    sys.exit(1)

# Read file
with open(config_path, 'r') as f:
    lines = f.readlines()

# Process lines to fix [general] section
output = []
i = 0
general_written = False

while i < len(lines):
    line = lines[i]
    
    # If we find [general] section
    if line.strip() == '[general]':
        if not general_written:
            output.append(line)  # Keep [general]
            i += 1
            
            # Skip any existing import lines in this section
            while i < len(lines):
                if lines[i].strip().startswith('['):  # Next section
                    break
                if lines[i].strip().startswith('import') or lines[i].strip().startswith('"'):
                    i += 1  # Skip old import
                else:
                    break
            
            # Add new import
            output.append('import = [\n')
            output.append(f'  "~/.config/alacritty/os/{os_name}.toml"\n')
            output.append(']\n')
            general_written = True
        else:
            i += 1  # Skip duplicate [general]
    else:
        output.append(line)
        i += 1

# Write back
with open(config_path, 'w') as f:
    f.writelines(output)
PYTHON_SCRIPT
    
    echo -e "${GREEN}✅ Updated alacritty import for OS: ${OS}${NC}"
}

# Main setup
echo ""
echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}  Setting up dotfiles for ${OS}${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}"
echo ""

# 1. Setup Alacritty
echo -e "${YELLOW}📦 Setting up Alacritty...${NC}"
create_symlink "$SCRIPT_DIR/alacritty/alacritty.toml" "$CONFIG_DIR/alacritty/alacritty.toml"
OS="$OS" CONFIG_PATH="$SCRIPT_DIR/alacritty/alacritty.toml" update_alacritty_import
create_symlink "$SCRIPT_DIR/alacritty/os" "$CONFIG_DIR/alacritty/os-profiles"

# 2. Setup Nvim
echo ""
echo -e "${YELLOW}📦 Setting up Nvim...${NC}"
create_symlink "$SCRIPT_DIR/nvim/init.lua" "$CONFIG_DIR/nvim/init.lua"
create_symlink "$SCRIPT_DIR/nvim/os" "$CONFIG_DIR/nvim/os-profiles"

# 3. Setup Tmux
echo ""
echo -e "${YELLOW}📦 Setting up Tmux...${NC}"
create_symlink "$SCRIPT_DIR/tmux/tmux.conf" "$CONFIG_DIR/tmux/tmux.conf"
create_symlink "$SCRIPT_DIR/tmux/os" "$CONFIG_DIR/tmux/os-profiles"

# 4. Setup git hook
echo ""
echo -e "${YELLOW}🔗 Setting up git post-merge hook...${NC}"

HOOK_DIR="$SCRIPT_DIR/.git/hooks"
mkdir -p "$HOOK_DIR"

cat > "$HOOK_DIR/post-merge" << 'HOOK_EOF'
#!/bin/bash
# Auto-run setup.sh after git pull/merge
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
"$SCRIPT_DIR/setup.sh"
HOOK_EOF

chmod +x "$HOOK_DIR/post-merge"
echo -e "${GREEN}✅ Git hook installed${NC}"

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  ✨ Setup complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo ""
echo "📝 Changes made:"
echo "   • Symlinked alacritty config"
echo "   • Symlinked nvim config"
echo "   • Symlinked tmux config"
echo "   • Updated alacritty import for OS: ${OS}"
echo "   • Installed git post-merge hook"
echo ""
echo "🔄 After git pull, setup.sh will run automatically!"
echo ""
