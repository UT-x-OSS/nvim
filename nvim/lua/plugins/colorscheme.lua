return {
  "Everblush/nvim",
  name = "everblush",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme everblush")
    -- Transparansi & style tambahan (opsional)
    vim.cmd([[
      highlight Normal guibg=NONE ctermbg=NONE
      highlight NormalNC guibg=NONE ctermbg=NONE
      highlight EndOfBuffer guibg=NONE ctermbg=NONE
      highlight SignColumn guibg=NONE ctermbg=NONE
    ]])
  end,
}

