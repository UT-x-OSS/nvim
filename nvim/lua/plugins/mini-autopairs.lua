
return {
  "echasnovski/mini.pairs",
  version = "*",
  event = "InsertEnter",
  config = function()
    require("mini.pairs").setup({
      -- Pasangan karakter yang otomatis dipasangkan
      pairs = {
        ["("] = ")",
        ["["] = "]",
        ["{"] = "}",
        ['"'] = '"',
        ["'"] = "'",
        ["`"] = "`",
      },

      -- Disable autopairs di filetype tertentu
      disable_filetype = { "TelescopePrompt", "vim" },

      -- Jika true, insert pasangan di akhir baris jika kamu menulis karakter pembuka
      endwise = true,

      -- Fitur autopair seperti enter di antara kurung
      check_ts = true,  -- aktifkan integrasi treesitter buat cek konteks
    })
  end,
}

