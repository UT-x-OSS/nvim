return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local devicons = require("nvim-web-devicons")

    -- Highlight transparan + warna per mode
    vim.api.nvim_set_hl(0, "StatusLine",        { bg = "none", fg = "#FFFFFF" })
    vim.api.nvim_set_hl(0, "StatusLineNC",      { bg = "none", fg = "#5c6370" })

    vim.api.nvim_set_hl(0, "LualineNormal",     { fg = "#00FFFF", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "LualineInsert",     { fg = "#7CFC00", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "LualineVisual",     { fg = "#FF0000", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "LualineCommand",    { fg = "#FFA500", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "LualineTerminal",   { fg = "#FFD700", bg = "none", bold = true })

    vim.api.nvim_set_hl(0, "LualineSoftwareEngineer",      { fg = "#FF7F50", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "LualineLSP",         { fg = "#00FF7F", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "LualineFile",        { fg = "#FFD700", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "LualineBranch",      { fg = "#7B68EE", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "LualineDiff",        { fg = "#FFA500", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "LualineDiagnostics", { fg = "#FF4500", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "LualineTime",        { fg = "#00CED1", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "LualineDate",        { fg = "#ADFF2F", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "LualineAIDev",       { fg = "#FF00FF", bg = "none", bold = true })

    -- Icon + nama file
    local function file_icon()
      local name = vim.fn.expand("%:t")
      local ext = vim.fn.expand("%:e")
      local icon = devicons.get_icon(name, ext, { default = true }) or ""
      return icon .. " " .. name
    end

local function lsp_status()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({bufnr = bufnr}) -- ini sebenarnya sudah ada di docs terbaru

  if #clients == 0 then
    return "🚀 No LSP"
  end

  return "🚀 " .. clients[1].name
end




    -- Waktu
    local function current_time()
      return "󱑂 " .. os.date("%H:%M:%S")
    end

    -- Tanggal
    local function current_date()
      return "󰃰 " .. os.date("%A, %d %B %Y")
    end

    -- Judul lagu dari Spotify (via playerctl)
    local function spotify_status()
      local handle = io.popen('playerctl metadata title 2>/dev/null')
      local result = handle:read("*a")
      handle:close()
      return result ~= "" and "🎵 " .. result:gsub("\n", "") or "🎵 No music"
    end

    -- Mode label & warna dinamis
    local function vim_mode()
      local mode_map = {
        n = { "NORMAL", "#00FFFF" },
        i = { "INSERT", "#7CFC00" },
        v = { "VISUAL", "#FF0000" },
        V = { "V-LINE", "#FF69B4" },
        ["\22"] = { "V-BLOCK", "#FF69B4" },
        c = { "COMMAND", "#FFA500" },
        t = { "TERMINAL", "#FFD700" },
        R = { "REPLACE", "#FFA500" },
        s = { "SELECT", "#FF69B4" },
        S = { "S-LINE", "#FF69B4" },
        ["\19"] = { "S-BLOCK", "#FF69B4" },
      }

      return {
        function()
          local mode = vim.fn.mode()
          local label = (mode_map[mode] and mode_map[mode][1]) or mode
          return " " .. label
        end,
        color = function()
          local mode = vim.fn.mode()
          local fg = (mode_map[mode] and mode_map[mode][2]) or "#00FFFF"
          return { fg = fg, bg = "none", bold = true }
        end,
      }
    end

    -- Auto refresh statusline tiap 5 detik (untuk update waktu & spotify)
    vim.fn.timer_start(5000, function()
      vim.cmd("redrawstatus")
    end, { ["repeat"] = -1 })

    -- Setup Lualine
    require('lualine').setup({
      options = {
        theme = 'auto',
        icons_enabled = true,
        component_separators = '',
        section_separators = '',
        globalstatus = true,
        always_divide_middle = false,
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          vim_mode(),
          {
            function() return ' K I R A' end,
            color = "LualineSoftwareEngineer",
          },
          {
            lsp_status,
            color = "LualineLSP",
          },
          {
            file_icon,
            color = "LualineFile",
          },
          {
            'branch',
            icon = '',
            color = "LualineBranch",
          },
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' },
            color = "LualineDiff",
          },
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
            color = "LualineDiagnostics",
          },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            current_time,
            color = "LualineTime",
          },
          {
            current_date,
            color = "LualineDate",
          },
          {
            spotify_status,
            color = "LualineAIDev",
          },
        },
      },
      inactive_sections = {
        lualine_a = {}, lualine_b = {}, lualine_c = {},
        lualine_x = {}, lualine_y = {}, lualine_z = {},
      },
      extensions = {},
    })
  end,
}

