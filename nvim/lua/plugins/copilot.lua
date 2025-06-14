return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    vim.g.copilot_no_tab_map = true

    -- Aktifkan saran otomatis saat mengetik
    vim.g.copilot_accept_suggestion_on_enter = true  -- Terima saran otomatis saat menekan Enter

    -- Saran muncul lebih cepat setelah mengetik satu karakter
    vim.g.copilot_auto_trigger = true  -- Mengaktifkan trigger otomatis Copilot

    -- Accept suggestion pakai Ctrl + L hanya di mode insert
    vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', {
      expr = true, silent = true, noremap = true
    })

    -- Navigasi saran (Next / Prev / Dismiss) hanya di mode insert
    vim.cmd([[
      imap <silent><script><expr> <C-j> copilot#Next()
      imap <silent><script><expr> <C-k> copilot#Previous()
      imap <silent><script><expr> <C-]> copilot#Dismiss()
    ]])

    -- Aktifkan Copilot untuk semua filetype
    vim.g.copilot_filetypes = {
      ["*"] = true,  -- Aktifkan Copilot untuk semua filetype
    }
  end,
}

