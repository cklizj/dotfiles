-- macOS Specific Nvim Configuration
-- OS-specific keybindings, fonts, and settings

-- macOS specific keybindings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Command key for macOS (mapped to <D-...>)
-- Example: Cmd+S to save
keymap('n', '<D-s>', ':w<CR>', opts)

-- Example: Cmd+D for diagnostic
keymap('n', '<D-d>', vim.diagnostic.open_float, opts)

-- macOS specific GUI font (if using Neovide or similar)
-- vim.opt.guifont = "FiraCode Nerd Font:h13"

-- macOS uses Cmd for window management
-- (can't override globally, but document it)
-- Cmd+N = New window
-- Cmd+W = Close window
-- Cmd+Q = Quit

print("[nvim] macOS configuration loaded")
