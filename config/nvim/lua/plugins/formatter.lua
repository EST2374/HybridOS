-- ~/.config/nvim/lua/plugins/formatter.lua

return {
  -- Konfiguration für 'stevearc/conform.nvim'
  {
    "stevearc/conform.nvim",
    opts = {
      -- Definiert, welche Formatierer für welchen Dateityp verwendet werden
      formatters_by_ft = {
        -- Web-Entwicklung
        html = { "prettier" }, -- Für HTML
        css = { "prettier" }, -- Für CSS
        javascript = { "prettier" }, -- Für JavaScript

        -- Python
        python = { "isort", "black" }, -- Führt zuerst isort, dann black aus

        java = { "google-java-format" },

        -- Zusätzliche nützliche Formatierer
        lua = { "stylua" },
        markdown = { "prettier" },
      },

      -- Optional: Definiere Standardeinstellungen für Formatierer (hier für Black)
      -- Du kannst dies entfernen, wenn du keine spezifischen Argumente brauchst
      formatters = {
        black = {
          -- Beispiel: Erzwinge eine bestimmte Zeilenlänge
          -- prepend_args = { "--line-length", "88" },
        },
      },

      -- LazyVim kümmert sich um format_on_save. Du musst es hier nicht konfigurieren!
    },
  },
}
