
return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""

    -- Aktifkan saran otomatis tanpa delay
    vim.g.copilot_auto_trigger = true

    -- Aktifkan suggestion begitu kamu mulai ngetik
    vim.g.copilot_filetypes = {
      ["*"] = true, -- aktifkan di semua filetype
      markdown = false, -- disable di markdown kalau ganggu
      text = false,
    }

    -- Terima suggestion dengan <C-l>
    vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', {
      expr = true, silent = true, noremap = true
    })

    -- Navigasi suggestion
    vim.cmd([[
      imap <silent><script><expr> <C-j> copilot#Next()
      imap <silent><script><expr> <C-k> copilot#Previous()
      imap <silent><script><expr> <C-]> copilot#Dismiss()
    ]])
  end,
}

