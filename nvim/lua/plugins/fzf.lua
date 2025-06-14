
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- icon support
  config = function()
    require("fzf-lua").setup({
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        preview = {
          layout = "vertical",       -- vertical or horizontal
          scrollbar = "float",       -- 'float' or false
          delay = 50,
          border = "noborder",
          default = "bat",           -- bat or builtin
        },
        border = "rounded",          -- none | single | double | rounded
        fullscreen = false,
      },
      fzf_opts = {
        ['--ansi'] = '',
        ['--info'] = 'inline',
        ['--layout'] = 'reverse',
        ['--preview-window'] = 'up:60%:wrap',
      },
      previewers = {
        builtin = {
          syntax = true,     -- syntax highlighting in builtin previewer
          scrollbar = true,
        },
      },
      files = {
        prompt = "Files ❯ ",
        cmd = "fd --type f --hidden --follow --exclude .git", -- better file search
      },
      grep = {
        prompt = "Grep ❯ ",
        input_prompt = 'Grep For❯ ',
        cmd = "rg --vimgrep --hidden --smart-case --follow",
      },
      git = {
        commits = {
          prompt = "Git Commits ❯ ",
          preview = "git show --pretty=medium --stat --color=always {1}",
        },
        status = {
          prompt = "Git Status ❯ ",
        },
      },
    })
  end,
}

