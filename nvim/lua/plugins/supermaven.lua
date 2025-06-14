
return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  config = function()
    require("supermaven-nvim").setup({
      -- 🎯 Keymaps untuk mengontrol saran AI
      keymaps = {
        accept_suggestion = "<Tab>",      -- Terima saran
        clear_suggestion = "<C-]>",       -- Hapus saran yang sedang muncul
        next_suggestion = "<C-n>",        -- Lihat saran berikutnya
        prev_suggestion = "<C-p>",        -- Lihat saran sebelumnya
        dismiss_suggestion = "<C-c>",     -- Menolak saran (opsional)
      },

      -- 🔁 Saran otomatis ditampilkan
      auto_trigger = true,

      -- 📦 Dependency awareness (auto lengkapi import/library sesuai project)
      enable_dependency_autocomplete = true,

      -- ⚙️ Task runner (bisa build, test, run, dll langsung dari suggestion)
      enable_task_runner = true,

      -- 📂 Spesifik untuk jenis file (hapus jika ingin global)
      filetypes = {
        "lua", "python", "javascript", "typescript", "go", "rust", "java", "sh", "html", "css", "json"
      },

      -- 🎨 UI Options (jika tersedia versi update)
      display_options = {
        suggestion_color = "Comment", -- warna suggestion
        suggestion_icon = "",       -- icon suggestion (misalnya dari nerd font)
      },

      -- 🧪 Untuk debugging / logging
      enable_debug = false,

      -- ⏱️ Delay sebelum menampilkan saran (dalam ms)
      debounce_time = 80,
    })
  end,
}

