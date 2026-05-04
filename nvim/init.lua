-- Neovim init.lua with OS-specific configuration
-- Auto-detects macOS vs WSL2 and loads appropriate OS-specific config

-- Detect OS
local function get_os()
    if jit.os == "OSX" then
        return "mac"
    elseif jit.os == "Linux" then
        -- Check if running on WSL2
        local f = io.open("/proc/version", "rb")
        if f then
            local content = f:read("*a")
            f:close()
            if string.find(content, "microsoft") or string.find(content, "Microsoft") then
                return "wsl"
            end
        end
        return "linux"
    else
        return "unknown"
    end
end

local current_os = get_os()
print("[nvim] Detected OS: " .. current_os)

-- Load OS-specific configuration first
local os_config_path = vim.fn.stdpath('config') .. '/os-profiles/' .. current_os .. '.lua'
if vim.fn.filereadable(os_config_path) == 1 then
    dofile(os_config_path)
    print("[nvim] Loaded OS-specific config: " .. current_os .. ".lua")
else
    print("[nvim] Warning: OS-specific config not found at " .. os_config_path)
end

-- Your shared nvim configuration goes here
-- (existing kickstart config, plugins, etc.)

-- Example shared configuration:
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Load your existing kickstart or custom configs
-- e.g., if you have a kickstart setup, uncomment:
-- require('kickstart')
