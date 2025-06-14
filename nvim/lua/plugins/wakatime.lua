-- Add to your plugin manager setup
return{
  "wakatime/vim-wakatime",
  lazy = false,
  config = function()
    -- Optional: you can add custom commands to track time or get statistics
    vim.g.wakatime_api_key = ""  -- visit wakatime and login via github
    -- Optional: set your default project
    vim.g.wakatime_project = "default-project"

    -- You can set the update interval in seconds
    vim.g.wakatime_update_interval = 60  -- Update time tracking every 60 seconds

    -- You can enable or disable specific features like showing the status bar info
    vim.g.wakatime_status_bar = 1  -- Show WakaTime status bar in your editor

    -- Enable or disable tracking for certain file types
    vim.g.wakatime_ignore_filetypes = { 'nerdtree', 'fugitive' }  -- Ignore specific file types

    -- Enable or disable tracking on startup
    vim.g.wakatime_auto_start = 1  -- Automatically start tracking on Vim startup
  end,
}

