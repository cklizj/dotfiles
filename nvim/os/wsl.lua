-- WSL2 Specific Nvim Configuration
-- OS-specific keybindings, fonts, and settings

-- WSL2 specific keybindings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- WSL2 uses Ctrl for most keybindings
-- Example: Ctrl+S to save
keymap('n', '<C-s>', ':w<CR>', opts)

-- Example: Ctrl+D for diagnostic
keymap('n', '<C-d>', vim.diagnostic.open_float, opts)

-- WSL2 might have clipboard sync issues
-- Uncomment if needed:
-- vim.g.clipboard = {
--   name = 'wsl',
--   copy = { '+', 'clip.exe' },
--   paste = { '+', 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw))' },
-- }

-- WSL2 specific font (for compatible terminals)
-- vim.opt.guifont = "FiraCode Nerd Font:h13"

print("[nvim] WSL2 configuration loaded")
