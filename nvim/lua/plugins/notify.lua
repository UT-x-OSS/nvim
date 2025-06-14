return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      -- Animasi notifikasi
      stages = "fade_in_slide_out",  

      -- Durasi notifikasi
      timeout = 3000,  

      -- Lebar maksimal dan tinggi maksimal dari notifikasi
      max_width = 50,  -- Lebar maksimal
      max_height = 10, -- Tinggi maksimal

      -- Custom icons untuk jenis pesan
      icons = {
        ERROR = "",
        WARN  = "",
        INFO  = "",
        DEBUG = "",
        TRACE = "✎",
      },

      -- Gaya rendering: icon di depan, kemudian teks
      render = "default",  -- Bisa juga menggunakan 'compact', 'minimal'

      -- Background warna yang berbeda tergantung tipe pesan
      background_colour = "#282828",  -- Warna background default
      minimum_width = 50,  -- Lebar minimum notifikasi
    })

    -- Mendaftarkan beberapa shortcut untuk memunculkan notifikasi custom
    vim.api.nvim_set_keymap("n", "<Leader>nt", ":lua require('notify')('This is a test notification!', 'info')<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>ne", ":lua require('notify')('This is an error notification!', 'error')<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>nw", ":lua require('notify')('This is a warning notification!', 'warn')<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>nd", ":lua require('notify')('This is a debug notification!', 'debug')<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>ntc", ":lua require('notify')('This is a trace notification!', 'trace')<CR>", { noremap = true, silent = true })
  end
}

