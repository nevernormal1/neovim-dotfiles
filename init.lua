-- Install Packer plugins
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- NERDTree for file browsing
  use 'preservim/nerdtree'

  -- CtrlP for fuzzy file finding
  use 'kien/ctrlp.vim'

  -- Treesitter for better syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    run = ':TSUpdate',
  }

  -- LSP and Autocompletion
  use 'neovim/nvim-lspconfig' -- Configurations for built-in LSP
  use 'hrsh7th/nvim-cmp'      -- Completion framework
  use 'hrsh7th/cmp-nvim-lsp'  -- LSP source for nvim-cmp
  use 'onsails/lspkind.nvim'  -- Adds vscode-like pictograms
  use 'tpope/vim-rails'       -- Ruby on Rails support
  use 'pangloss/vim-javascript' -- JavaScript support
  use 'leafgarland/typescript-vim' -- TypeScript support
  use 'maxmellon/vim-jsx-pretty' -- React JSX support

  -- Other utilities
  use 'tpope/vim-commentary'  -- Easy commenting
  use 'tpope/vim-surround'    -- Surround text manipulation
  use 'nvim-lua/plenary.nvim' -- Dependency for other plugins
  use 'jlanzarotta/bufexplorer'
end)

-- LSP configuration
vim.lsp.config('solargraph', {})
vim.lsp.enable('solargraph')

vim.lsp.config('ts_ls', {
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
  end,
})
vim.lsp.enable('ts_ls')

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Number of spaces inserted for each indentation level
vim.opt.shiftwidth = 2

-- Number of spaces a <Tab> counts for
vim.opt.tabstop = 2

-- (Optional) Insert 4 spaces when pressing Tab in Insert mode
vim.opt.softtabstop = 2

-- (Optional) Turn on automatic indentation for new lines
vim.opt.autoindent = true

-- Enable line numbers
vim.opt.number = true
vim.api.nvim_set_keymap("n", "<leader>nh", ":noh<CR>", { noremap = true, silent = true })

-- Treesitter configuration
local treesitter_languages = {
  "ruby",
  "javascript",
  "typescript",
  "tsx",
  "markdown",
  "markdown_inline",
}

require('nvim-treesitter').install(treesitter_languages)

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    "ruby",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "markdown",
  },
  callback = function()
    vim.treesitter.start()
  end,
})

-- Keybindings
vim.api.nvim_set_keymap('n', '<leader>nt', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':CtrlP<CR>', { noremap = true, silent = true })

-- CtrlP configuration
vim.g.ctrlp_custom_ignore = {
  dir = '\\v[/]\\.(git|node_modules)$',
  file = '\\v\\.(exe|so|dll)$'
}
vim.g.ctrlp_user_command = {
  '.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'
}
