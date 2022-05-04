local config = {}
require('nvim-lsp-installer').on_server_ready(function (server)
  local opts = {
    capabilities = capabilities,
    on_attach = default_on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }

  if config[server.name] then
    opts = vim.tbl_deep_extend('force', opts, config[server.name])
  end

  server:setup(opts)

  vim.cmd [[ do User LspAttachBuffers ]]
end)

local nvim_lsp = require('lspconfig')
require'lspconfig'.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})
require'lspconfig'.tsserver.setup{}
local servers = { "rust_analyzer", "tsserver"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
