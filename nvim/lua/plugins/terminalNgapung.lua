return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = false,
      direction    = "float",
      float_opts   = {
        border   = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- custom border chars, bisa juga "curved"
        width    = math.floor(vim.o.columns * 0.8),
        height   = math.floor(vim.o.lines * 0.8),
        winblend = 10,  -- sedikit transparan biar enak
        -- ini warna border everblush:
        border_hl = "EverblushBorder",
        winhighlight = "Normal:EverblushNormal,FloatBorder:EverblushBorder",
      },
      start_in_insert = true,
      persist_size    = true,
    })

    -- Buat highlight group warna everblush
    vim.api.nvim_set_hl(0, "EverblushBorder", { fg = "#ff4c61", bg = "NONE" })
    vim.api.nvim_set_hl(0, "EverblushNormal", { bg = "#2a1a21" }) -- latar belakang floating terminal

    local Terminal  = require("toggleterm.terminal").Terminal
    local float_term = Terminal:new({
      direction = "float",
      count     = 99,
    })

    -- Keymap toggle terminal pakai F7
    vim.keymap.set("n", "<F7>", function()
      float_term:toggle()
    end, { desc = "Toggle floating terminal", noremap = true, silent = true })
  end,
}

