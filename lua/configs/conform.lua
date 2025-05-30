
local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format", "isort" },
    rust = { "rustfmt" },
    php = { "php_cs_fixer" },
    html = { "prettier" },
    css = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    kotlin = { "ktlint" },
    java = { "google-java-format" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options

