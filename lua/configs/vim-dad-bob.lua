return  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = false },
      { 'mfussenegger/nvim-jdtls',              lazy = false }, -- Java language server wrapper
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = false },
      { 'hrsh7th/nvim-cmp',                     lazy = false }, -- Autocompletion for nvim-cmp
      { 'hrsh7th/cmp-buffer',                   lazy = false }, -- Buffer completion for autocomplete
      { 'saadparwaiz1/cmp_luasnip',             lazy = false },
      { 'L3MON4D3/LuaSnip',                     lazy = false }, -- LuaSnip for snippets
      { 'hrsh7th/cmp-nvim-lsp-signature-help',  lazy = false }, -- LSP signature help
      { 'hrsh7th/cmp-path',                     lazy = false },
      { 'hrsh7th/cmp-nvim-lsp',                 lazy = false },
      { 'hrsh7th/cmp-cmdline',                  lazy = false },
      { 'hrsh7th/cmp-calc',                     lazy = false },
      { 'hrsh7th/cmp-vsnip',                    lazy = false },
      { 'hrsh7th/cmp-nvim-lua',                 lazy = false },
      { 'hrsh7th/cmp-emoji',                    lazy = false },
      { 'ibhagwan/fzf-lua',                     lazy = false }, -- File selector using fzf
      { 'nvim-telescope/telescope.nvim',        lazy = false }, -- File selector using telescope
      { 'nvim-lua/plenary.nvim',                lazy = false }, -- Utility functions
      { 'MunifTanjim/nui.nvim',                 lazy = false }, -- UI components
      { 'stevearc/dressing.nvim',               lazy = false }, -- Improved UI for input
      { 'echasnovski/mini.pick',                lazy = false }, -- File selector with mini.pick
      { 'nvim-tree/nvim-web-devicons',          lazy = false }, -- Icons for filetypes
    },

    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
      "DBUILastQueryInfo",
      "DBUIHideNotifications",
      "DBUISaveQuery",
    },

    init = function()
      -- Konfigurasi DBUI
      vim.g.db_ui_use_nerd_fonts = 1
    end,

    config = function()
      local cmp = require("cmp")

      -- Setup autocomplete untuk filetype SQL
      cmp.setup.filetype("sql", {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })

      -- Setup autocomplete saat membuka file SQL, MySQL, atau PL/SQL
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          cmp.setup.buffer({
            sources = {
              { name = "vim-dadbod-completion" },
              { name = "buffer" },
            },
          })
        end,
      })
    end,
  }

