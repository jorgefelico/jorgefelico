return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      qmlls = {
        -- Force Neovim to pass environment lookups if needed,
        -- or override the command to match your system-wide Qt binary (e.g., "qmlls6")
        cmd = { "qmlls6" },
        filetypes = { "qml", "qmljs" },
        settings = {
          -- Some versions of qmlls require explicit build path hints
          qml = {
            buildDir = "build",
          },
        },
      },
    },
  },
}
