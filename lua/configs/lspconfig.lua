local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers =
{
  "bashls",
  "jdtls",
  "kotlin_language_server",
  "marksman",
  "pylsp",
  "lua_ls",
  "superhtml",
  "cssls",
  "ts_ls"
}


----- lsps for all -----
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

----- Bash -----
lspconfig.bashls.setup {
  on_attach = function(client, bufnr)
    -- Keymaps
    local map = function(mode, lhs, rhs)
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
    end
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

    -- Autoformat on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ timeout_ms = 500, async = false })
      end,
    })
  end,

  on_init = function(client)
    client.config.settings = client.config.settings or {}
    client.config.settings.bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
      shellcheckArguments = "--severity=style --exclude=SC1090,SC1091",
    }
  end,

  capabilities = capabilities,

  cmd_env = {
    SHELLCHECK_PATH = "/usr/bin/shellcheck",
    SHFMT_PATH = "/usr/bin/shfmt",
  },

  filetypes = { "sh", "bash", "zsh" },

  settings = {
    bashIde = {
      shellcheckArguments = "--severity=style --exclude=SC1090,SC1091",
      globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
    },
  },
}


----- Java (JDTLS) -----
local lspconfig = require("lspconfig")
local root_pattern = require("lspconfig.util").root_pattern
local home = os.getenv("HOME")

-- Workspace directory otomatis berdasarkan project
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

-- Path ke jdtls
local jdtls_path = home .. "/.local/share/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- Capabilities untuk nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Fungsi on_attach global
local on_attach = function(client, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  map("n", "K", vim.lsp.buf.hover)
  map("n", "gd", vim.lsp.buf.definition)
  map("n", "<leader>rn", vim.lsp.buf.rename)
  map("n", "<leader>ca", vim.lsp.buf.code_action)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "<leader>f", function() vim.lsp.buf.format({ async = false }) end)

  -- Format saat save
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })
end

-- Setup JDTLS
lspconfig.jdtls.setup({
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", launcher_jar,
    "-configuration", jdtls_path .. "/config_linux",
    "-data", workspace_dir,
  },

  filetypes = { "java" },
  root_dir = root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "settings.gradle"),

  on_attach = on_attach,
  capabilities = capabilities,

  init_options = {
    workspace = workspace_dir,
  },

  settings = {
    java = {
      configuration = {
        runtimes = {
          { name = "JavaSE-24", path = "/usr/lib/jvm/java-24-openjdk" },
        },
      },

      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },

      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath("config") .. "/java-google-style.xml",
        },
      },

      referencesCodeLens = { enabled = true },
      implementationsCodeLens = { enabled = true },

      eclipse = { downloadSources = true },
      maven = { downloadSources = true },

      autobuild = { enabled = true },

      completion = {
        favoriteStaticMembers = {
          "java.util.Objects.requireNonNull",
          "java.util.Optional.of",
          "org.junit.jupiter.api.Assertions.*",
          "org.mockito.Mockito.*",
          "java.util.stream.Collectors.*",
        },
        importOrder = { "java", "javax", "org", "com" },
      },

      saveActions = { organizeImports = true },

      inlayHints = {
        parameterNames = { enabled = "all" },
        variableTypes = { enabled = true },
        chainingHints = { enabled = true },
      },

      debugging = {
        enabled = true,
        configuration = {
          hotCodeReplace = "auto",
        },
      },

      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },

      workspace = {
        symbol = {
          maxSymbols = 5000,
        },
      },

      semanticHighlighting = {
        enabled = true,
      },
    },
  },

  flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
  },
})

-- Setup Kotlin LSP

local nvim_lsp = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

local on_attach = function(client, bufnr)
  local buf_map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  buf_map('n', 'gd', vim.lsp.buf.definition)
  buf_map('n', 'gD', vim.lsp.buf.declaration)
  buf_map('n', 'gr', vim.lsp.buf.references)
  buf_map('n', 'gi', vim.lsp.buf.implementation)
  buf_map('n', 'K', vim.lsp.buf.hover)
  buf_map('n', '<leader>ds', vim.lsp.buf.document_symbol)
  buf_map('n', '<leader>ws', vim.lsp.buf.workspace_symbol)
  buf_map('n', '<leader>rn', vim.lsp.buf.rename)
  buf_map('n', '<leader>ca', vim.lsp.buf.code_action)
  buf_map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end)
  buf_map('n', '<leader>e', vim.diagnostic.open_float)
  buf_map('n', '[d', vim.diagnostic.goto_prev)
  buf_map('n', ']d', vim.diagnostic.goto_next)
  buf_map('n', '<leader>q', vim.diagnostic.setloclist)
  buf_map('i', '<C-k>', vim.lsp.buf.signature_help)
end

nvim_lsp.kotlin_language_server.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "kotlin", "kotlin.kts", "kts" },
  settings = {
    kotlin = {
      experimental = { coroutines = true },
      compiler = { jvmTarget = "1.8" },
      scripting = { enabled = true },
      android = { enabled = true },
    },
  },
  flags = { debounce_text_changes = 150 },
})

----- pylsp (Python Linting) -----
local nvim_lsp = require('lspconfig')

-- Enhanced capabilities for nvim-cmp completion & snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.pylsp.setup {
  capabilities = capabilities,

  settings = {
    pylsp = {
      plugins = {
        -- Linting dan gaya
        pyflakes = { enabled = true },
        pycodestyle = {
          enabled = true,
          maxLineLength = 88,
          ignore = { "W391", "W392" }, -- hilangkan warning trailing newline
        },
        mccabe = { enabled = false },
        flake8 = { enabled = false },
        autopep8 = { enabled = false },

        -- Formatter
        yapf = { enabled = true, style = "pep8" },
        black = { enabled = false },

        -- Sortir impor
        pyls_isort = { enabled = true, profile = "black" },

        -- Type checker
        pylsp_mypy = {
          enabled = true,
          live_mode = false,
          report_progress = true,
        },

        -- Fitur jedi
        jedi_completion = { enabled = true },
        jedi_hover = { enabled = true },
        jedi_references = { enabled = true },
        jedi_signature_help = { enabled = true },
        jedi_definitions = { enabled = true },

        -- Rope
        rope_completion = { enabled = true },
        rope_autoimport = { enabled = true },
        -- Tambahan sourcery plugin
        sourcery = {
          enabled = true,
          key = "user_nnbFOAikoQv80tIxdq3ZqvCU2HRSb7wxIP8WsjkBCSnD5_60PzBIKqzlZyg",
        },
      }
    }


  },

  on_attach = function(client, bufnr)
    local function buf_map(mode, lhs, rhs)
      local opts = { noremap = true, silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Basic LSP keymaps
    buf_map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    buf_map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    buf_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    buf_map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    buf_map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    buf_map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    buf_map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    buf_map('n', '<leader>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>')

    -- Workspace management
    buf_map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    buf_map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    buf_map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

    -- Diagnostics navigation
    buf_map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    buf_map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    buf_map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
    buf_map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')

    -- Highlight symbol under cursor
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_set_hl(0, "LspReferenceRead", { bold = true, ctermbg = 1, bg = "#FFFFAA" }) -- LightYellow
      vim.api.nvim_set_hl(0, "LspReferenceText", { bold = true, ctermbg = 1, bg = "#FFFFAA" })
      vim.api.nvim_set_hl(0, "LspReferenceWrite", { bold = true, ctermbg = 1, bg = "#FFFFAA" })

      local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })

      vim.api.nvim_create_autocmd("CursorHold", {
        group = group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.document_highlight()
        end,
      })

      vim.api.nvim_create_autocmd("CursorMoved", {
        group = group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.clear_references()
        end,
      })
    end

    -- Auto format on save
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function() vim.lsp.buf.format { async = false } end
      })
    end
  end,

  flags = {
    debounce_text_changes = 150,
  },

  handlers = {
    ["$/progress"] = vim.lsp.handlers["$/progress"],
    ["window/showMessage"] = function(_, result, ctx)
      vim.notify(result.message, {
        title = "LSP Message",
        timeout = 3000,
        level = vim.log.levels.INFO,
      })
    end,
  },
}


----- lua_ls -----

require("lspconfig").lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,

  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT", -- yang digunakan Neovim
        path = vim.split(package.path, ";"),
      },
      completion = {
        callSnippet = "Replace",
        keywordSnippet = "Both",
        displayContext = true,
        workspaceWord = true,
        showWord = "Enable",
      },
      hint = {
        enable = true,
        setType = true,
        paramType = true,
        paramName = "All",
        arrayIndex = "Disable",
      },
      diagnostics = {
        enable = true,
        globals = { "vim", "use", "require" },
        disable = { "lowercase-global" }, -- opsional
      },
      workspace = {
        maxPreload = 2000,
        preloadFileSize = 50000,
        checkThirdParty = false,
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
          vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
          vim.env.HOME .. "/.config/nvim/lua", -- custom config kamu
          "${3rd}/luv/library",
        },
      },
      telemetry = {
        enable = false,
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
    },
  },
})

----- SuperHTML -----


lspconfig.superhtml.setup {
  on_attach = function(client, bufnr)
    -- Keymaps buat web dev cepat
    local buf_map = function(mode, lhs, rhs)
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
    end

    buf_map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")                    -- goto definition
    buf_map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")                    -- references
    buf_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")                          -- hover info
    buf_map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")                -- rename simbol
    buf_map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")           -- code actions
    buf_map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>") -- format

    if on_attach then on_attach(client, bufnr) end
  end,

  on_init = function(client)
    if on_init then on_init(client) end
  end,

  capabilities = capabilities,

  settings = {
    html = {
      format = {
        enable = true,
        wrapLineLength = 120,
        unformatted = "code,pre,em,strong,span", -- tag yang gak perlu diformat
        contentUnformatted = "pre,code,textarea",
        indentInnerHtml = true,
        extraLiners = "head,body,/html",
      },
      suggest = {
        html5 = true,
        angular1 = true,
        ionic = true,
      },
    },

    css = {
      validate = true,
      lint = {
        compatibleVendorPrefixes = "warning",
        duplicateProperties = "error",
        emptyRules = "warning",
        importStatement = "error",
        propertyIgnoredDueToDisplay = "warning",
        unknownProperties = "error",
      },
      format = {
        enable = true,
      },
    },

    javascript = {
      validate = true,
      format = {
        enable = true,
        indentSize = 2,
        tabSize = 2,
      },
      suggest = {
        completeFunctionCalls = true,
      },
    },

    typescript = {
      validate = true,
      format = {
        enable = true,
        indentSize = 2,
        tabSize = 2,
      },
      suggest = {
        completeFunctionCalls = true,
      },
    },
  },

  flags = {
    debounce_text_changes = 150,
  },
}


----- css -----
local lspconfig = require("lspconfig")

-- Setup capabilities with snippet support and cmp integration
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

lspconfig.cssls.setup {
  cmd = { "vscode-css-language-server", "--stdio" },

  filetypes = { "css", "scss", "less" },

  root_dir = lspconfig.util.root_pattern("package.json", ".git", ".gitignore"),

  capabilities = capabilities,

  init_options = {
    provideFormatter = true,
  },

  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "warning",      -- @rules yang gak dikenal jadi warning
        duplicateProperties = "warning", -- property ganda jadi warning
        emptyRules = "info",             -- rule kosong jadi info
        importStatement = "error",       -- import statement salah jadi error
      },
      format = {
        enable = true,
        indentSize = 2,
        tabSize = 2,
        insertSpaces = true,
      },
    },
    scss = {
      validate = true,
      lint = {
        unknownAtRules = "warning",
        duplicateProperties = "error", -- SCSS property duplikat dierror
        emptyRules = "info",
        extendBeforeMixin = "warning", -- aturan extend sebelum mixin
      },
      format = {
        enable = true,
        indentSize = 2,
        tabSize = 2,
        insertSpaces = true,
      },
      experimental = {
        useCustomData = true, -- SCSS custom data support experimental
      },
    },
    less = {
      validate = true,
      lint = {
        unknownAtRules = "warning",
        duplicateProperties = "warning",
      },
      format = {
        enable = true,
        indentSize = 2,
        tabSize = 2,
        insertSpaces = true,
      },
    },
  },

  on_attach = function(client, bufnr)
    -- Auto-format saat save file
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormatCSS", { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 2000 })
        end,
      })
    end

    -- Tambahkan keymaps LSP kalau mau (optional)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,

  flags = {
    debounce_text_changes = 150,
  },
}


----- TypeScript / JavaScript -----

lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    -- Format otomatis saat simpan
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = false })
        end,
      })
    end

    -- Organize import otomatis saat simpan
    if client.server_capabilities.codeActionProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { "source.organizeImports" } }
          local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
          for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
              end
            end
          end
        end,
      })
    end

    -- Optional: Highlight symbol under cursor
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- Panggil fungsi on_attach global jika ada
    if on_attach then on_attach(client, bufnr) end
  end,

  on_init = on_init,
  capabilities = capabilities,

  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "typescript", "typescriptreact",
    "javascript", "javascriptreact",
    "vue", "astro"
  },

  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      suggest = {
        completeFunctionCalls = true,
        includeCompletionsForImportStatements = true,
        includeCompletionsWithSnippetText = true,
        includeAutomaticOptionalChainCompletions = true,
      },
      format = {
        insertSpaceAfterCommaDelimiter = true,
        insertSpaceAfterSemicolonInForStatements = true,
        placeOpenBraceOnNewLineForFunctions = false,
      },
    },

    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      suggest = {
        completeFunctionCalls = true,
      },
      format = {
        insertSpaceAfterCommaDelimiter = true,
        insertSpaceAfterSemicolonInForStatements = true,
      },
    },
  },

  flags = {
    debounce_text_changes = 150,
  },
}
