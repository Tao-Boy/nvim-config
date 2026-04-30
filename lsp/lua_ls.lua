return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim", "Snacks" },
        disable = { "missing-fields", "incomplete-signature-doc" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
        },
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = "Replace",
      },
      hint = {
        enable = false,
        setType = true,
      },
    },
  },
}
