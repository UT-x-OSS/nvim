return {
  -- Plugin untuk format kode, bisa dipakai format on save
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment untuk format otomatis saat save
    config = function()
      require "configs.conform"
    end,
  },

  -- Plugin konfigurasi LSP bawaan Neovim, untuk autocompletion, linting, dan fitur LSP lainnya
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- Plugin manajemen installer LSP dan tooling lainnya (formatter, linter)
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "intelephense",
        "jdtls",
        "ltex-ls",
        "ruff-lsp",
        "rust-analyzer",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "typescript-language-server",
        "lua-language-server",
        "stylua",
        "prettier",
        "kotlin_language_server",
      },
    },
  },

  -- Plugin untuk menampilkan chunk folding yang lebih informatif dan visual
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.chunk"
    end,
  },

  -- Plugin untuk integrasi statistik coding dengan Wakatime
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  -- Plugin untuk menampilkan indentasi dengan garis vertikal (indent guides)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",

    enabled = false,
  },

  -- Plugin untuk menampilkan diagnostic inline yang kecil dan rapi
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.inline-diagnostics"
    end,
  },

  -- Plugin tema warna Volt, lazy loaded
  {
    "nvchad/volt",
    lazy = true,
  },

  -- Plugin tema warna Minty, lazy loaded dengan konfigurasi khusus
  {
    "nvchad/minty",
    lazy = true,
    config = function()
      require "configs.minty"
    end,
  },

  -- Plugin autocompletion utama (completion engine)

  {
    "hrsh7th/nvim-cmp",

    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",

      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",

      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "ray-x/cmp-treesitter",
      "petertriho/cmp-git",
      "f3fora/cmp-spell",
      "dcampos/cmp-snippy",
      "hrsh7th/cmp-copilot",

      {
        "supermaven-inc/supermaven-nvim",
        opts = {},
      },

      {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
          require("lsp_signature").setup({
            bind = true,
            floating_window = true,
            floating_window_above_cur_line = true,
            hint_enable = true,
            hint_prefix = "💡 ",
            hint_scheme = "Remember",
            handler_opts = { border = "rounded" },
            max_height = 8,
            max_width = 80,
            toggle_key = "<C-s>",
            fix_pos = true,
            transparency = 20,
            shadow_blend = 36,
            shadow_guibg = "Black",
            timer_interval = 100,
            use_lspsaga = false,
          })
        end,
      },
    },

    opts = function(_, opts)
      if opts.sources and opts.sources[1] then
        opts.sources[1].trigger_chars = { "-" }
      end

      -- Pasang supermaven di depan dan minta max 5 saran
      table.insert(opts.sources, 1, {
        name = "supermaven",
        option = {
          max_item_count = 10, -- minta 5 saran dari supermaven
        },
      })
    end,
  },



  -- Plugin menu NVChad, lazy loaded
  {
    "nvchad/menu",
    lazy = true,
  },

  -- Plugin untuk menampilkan shortcut keys secara popup, toggle dengan perintah ShowkeysToggle
  {
    "nvchad/showkeys",
    cmd = "ShowkeysToggle",
    opts = { position = "top-center" },
  },

  -- Plugin timer NVChad, toggle dengan perintah TimerlyToggle
  {
    "nvchad/timerly",
    cmd = "TimerlyToggle",
  },

  -- Plugin treesitter untuk syntax highlighting dan parsing yang canggih
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "css",
        "html",
        "java",
        "javascript",
        "json",
        "kotlin",
        "lua",
        "php",
        "rust",
        "typescript",
        "vim",
        "vimdoc",
      },
    },
  },

  -- Plugin untuk menampilkan status Discord Presence
  {
    "andweeb/presence.nvim",
    config = function()
      require "configs.presence"
    end,
  },

  -- Plugin integrasi GitHub dalam Neovim

  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo", -- Ini supaya plugin aktif pas kamu panggil :Octo
    config = function()
      require("configs.octo-github")
    end,
  },


  -- Plugin untuk preview markdown dalam browser
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Plugin UI untuk database management
  {
    "kristijanhusak/vim-dadbod-ui",
    config = function()
      require "configs.vim-dad-bob"
    end,
  },



  -- Plugin GitHub Copilot khusus untuk file markdown
  {
    "github/copilot.vim",
    ft = "markdown",
    config = function()
      require "configs.copilot"
    end,
  },

}
