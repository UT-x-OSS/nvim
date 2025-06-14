
return {
  "Everblush/everblush.nvim",
  lazy = true,
  priority = 1000,
  config = function()
    require("everblush").setup({
      -- kamu bisa tambahkan opsi kustom di sini, contohnya:
      transparent_background = false,
      italic_comments = true,
      dim_inactive = false,
    })
    vim.cmd.colorscheme("everblush")
  end,
}

