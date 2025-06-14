
return {
  'adelarsq/image_preview.nvim',
  event = 'VeryLazy',
  config = function()
    require("image_preview").setup({
      -- Backend preview image, sesuaikan dengan terminalmu
      backend = "kitty",          -- opsi lain: "ueberzug", "w3mimgdisplay", "chafa"
      
      -- Filetypes yang akan di-preview secara otomatis
      filetypes = { "png", "jpg", "jpeg", "gif", "bmp", "webp" },

      -- Ukuran floating window preview (default)
      width = 40,                 -- lebar preview (karakter)
      height = 20,                -- tinggi preview (baris)
      
      -- Posisi floating window
      position = "right",         -- opsi: "right", "left", "top", "bottom"
      
      -- Border floating window, bisa di-custom juga
      border = "rounded",         -- opsi: "none", "single", "double", "rounded", "solid", "shadow"

      -- Auto close preview ketika pindah buffer atau tutup file
      auto_close = true,
    })
  end,
}

