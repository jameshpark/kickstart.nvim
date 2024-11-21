--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Keybinds to make INSERT mode text navigation and manipulation like native macOS
vim.keymap.set('i', '', '<C-o>d^x', { desc = 'Clear the text from the cursor to the beginning of the line' })
vim.keymap.set('i', '', '<C-o>d$', { desc = 'Clear the text from the cursor to the end of the line' })
vim.keymap.set('i', '<M-C-H>', '<C-o>db', { desc = 'Clear the text from the cursor to the word' })
vim.keymap.set('i', '<M-d>', '<C-o>de', { desc = 'Clear the text from the cursor to the next word' })
vim.keymap.set('i', '', '<C-o>^', { desc = 'Move the cursor to the beginning of the line' })
vim.keymap.set('i', '', '<C-o>$', { desc = 'Move the cursor to the end of the line' })
vim.keymap.set('i', '<M-b>', '<C-o>b', { desc = 'Move the cursor to the previous word' })
vim.keymap.set('i', '<M-f>', '<C-o>w', { desc = 'Move the cursor to the next word' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          mappings = {
            i = { ['<c-k>'] = require('telescope.actions').delete_buffer },
            n = { ['dd'] = require('telescope.actions').delete_buffer },
          },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', function()
        builtin.find_files { hidden = true }
      end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
      require('mini.pairs').setup()
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          -- Initialize selection with regular visual selection
          -- init_selection = 'gnn', -- Initialize selection
          node_incremental = '<c-n>', -- Increment to the upper named parent
          -- scope_incremental = 'grc', -- Increment to the upper scope (e.g., function)
          node_decremental = '<c-p>', -- Decrement to the previous node
        },
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed.
      -- 'nvim-telescope/telescope.nvim', -- optional
      'ibhagwan/fzf-lua', -- optional
      -- 'echasnovski/mini.pick', -- optional
    },
    config = true,
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
    },
    keys = {
      {
        '<leader>un',
        function()
          Snacks.notifier.hide()
        end,
        desc = 'Dismiss All Notifications',
      },
      {
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>gb',
        function()
          Snacks.git.blame_line()
        end,
        desc = 'Git Blame Line',
      },
      {
        '<leader>gB',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Git Browse',
      },
      {
        '<leader>gf',
        function()
          Snacks.lazygit.log_file()
        end,
        desc = 'Lazygit Current File History',
      },
      {
        '<leader>gl',
        function()
          Snacks.lazygit.log()
        end,
        desc = 'Lazygit Log (cwd)',
      },
      {
        '<leader>cR',
        function()
          Snacks.rename.rename_file()
        end,
        desc = 'Rename File',
      },
      {
        '<c-/>',
        function()
          Snacks.terminal()
        end,
        desc = 'Toggle Terminal',
      },
      {
        '<c-_>',
        function()
          Snacks.terminal()
        end,
        desc = 'which_key_ignore',
      },
      {
        ']]',
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = 'Next Reference',
        mode = { 'n', 't' },
      },
      {
        '[[',
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = 'Prev Reference',
        mode = { 'n', 't' },
      },
      {
        '<leader>N',
        desc = 'Neovim News',
        function()
          Snacks.win {
            file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = 'yes',
              statuscolumn = ' ',
              conceallevel = 3,
            },
          }
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
          Snacks.toggle.diagnostics():map '<leader>ud'
          Snacks.toggle.line_number():map '<leader>ul'
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
          Snacks.toggle.treesitter():map '<leader>uT'
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
          Snacks.toggle.inlay_hints():map '<leader>uh'
        end,
      })
    end,
  },
  {
    'robitx/gp.nvim',
    config = function()
      local conf = {
        -- Please start with minimal config possible.
        -- Just openai_api_key if you don't have OPENAI_API_KEY env set up.
        -- Defaults change over time to improve things, options might get deprecated.
        -- It's better to change only things where the default doesn't fit your needs.

        -- required openai api key (string or table with command and arguments)
        -- openai_api_key = { "cat", "path_to/openai_api_key" },
        -- openai_api_key = { "bw", "get", "password", "OPENAI_API_KEY" },
        -- openai_api_key: "sk-...",
        -- openai_api_key = os.getenv("env_name.."),

        -- read api key from 1password
        -- op read op://Personal/OpenAI/Default\ project\ API\ Keys/Neovim
        openai_api_key = { 'op', 'read', 'op://Personal/OpenAI/Default project API Keys/Neovim' },

        -- at least one working provider is required
        -- to disable a provider set it to empty table like openai = {}
        providers = {
          -- secrets can be strings or tables with command and arguments
          -- secret = { "cat", "path_to/openai_api_key" },
          -- secret = { "bw", "get", "password", "OPENAI_API_KEY" },
          -- secret : "sk-...",
          -- secret = os.getenv("env_name.."),
          openai = {
            disable = false,
            endpoint = 'https://api.openai.com/v1/chat/completions',
            -- secret = os.getenv("OPENAI_API_KEY"),
          },
          azure = {
            disable = true,
            endpoint = 'https://$URL.openai.azure.com/openai/deployments/{{model}}/chat/completions',
            secret = os.getenv 'AZURE_API_KEY',
          },
          copilot = {
            disable = true,
            endpoint = 'https://api.githubcopilot.com/chat/completions',
            secret = {
              'bash',
              '-c',
              "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
            },
          },
          ollama = {
            disable = true,
            endpoint = 'http://localhost:11434/v1/chat/completions',
            secret = 'dummy_secret',
          },
          lmstudio = {
            disable = true,
            endpoint = 'http://localhost:1234/v1/chat/completions',
            secret = 'dummy_secret',
          },
          googleai = {
            disable = true,
            endpoint = 'https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}',
            secret = os.getenv 'GOOGLEAI_API_KEY',
          },
          pplx = {
            disable = true,
            endpoint = 'https://api.perplexity.ai/chat/completions',
            secret = os.getenv 'PPLX_API_KEY',
          },
          anthropic = {
            disable = true,
            endpoint = 'https://api.anthropic.com/v1/messages',
            secret = os.getenv 'ANTHROPIC_API_KEY',
          },
        },

        -- prefix for all commands
        cmd_prefix = 'Gp',
        -- optional curl parameters (for proxy, etc.)
        -- curl_params = { "--proxy", "http://X.X.X.X:XXXX" }
        curl_params = {},

        -- log file location
        log_file = vim.fn.stdpath('log'):gsub('/$', '') .. '/gp.nvim.log',
        -- write sensitive data to log file for	debugging purposes (like api keys)
        log_sensitive = false,

        -- directory for persisting state dynamically changed by user (like model or persona)
        state_dir = vim.fn.stdpath('data'):gsub('/$', '') .. '/gp/persisted',

        -- default agent names set during startup, if nil last used agent is used
        default_command_agent = nil,
        default_chat_agent = nil,

        -- default command agents (model + persona)
        -- name, model and system_prompt are mandatory fields
        -- to use agent for chat set chat = true, for command set command = true
        -- to remove some default agent completely set it like:
        -- agents = {  { name = "ChatGPT3-5", disable = true, }, ... },
        agents = {
          {
            name = 'ExampleDisabledAgent',
            disable = true,
          },
          {
            name = 'ChatGPT4o',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = 'gpt-4o', temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require('gp.defaults').chat_system_prompt,
          },
          {
            provider = 'openai',
            name = 'ChatGPT4o-mini',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = 'gpt-4o-mini', temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require('gp.defaults').chat_system_prompt,
          },
          {
            provider = 'copilot',
            name = 'ChatCopilot',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = 'gpt-4o', temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require('gp.defaults').chat_system_prompt,
          },
          {
            provider = 'googleai',
            name = 'ChatGemini',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = 'gemini-pro', temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require('gp.defaults').chat_system_prompt,
          },
          {
            provider = 'pplx',
            name = 'ChatPerplexityLlama3.1-8B',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = 'llama-3.1-sonar-small-128k-chat', temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require('gp.defaults').chat_system_prompt,
          },
          {
            provider = 'anthropic',
            name = 'ChatClaude-3-5-Sonnet',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = 'claude-3-5-sonnet-20240620', temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require('gp.defaults').chat_system_prompt,
          },
          {
            provider = 'anthropic',
            name = 'ChatClaude-3-Haiku',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = 'claude-3-haiku-20240307', temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require('gp.defaults').chat_system_prompt,
          },
          {
            provider = 'ollama',
            name = 'ChatOllamaLlama3.1-8B',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = {
              model = 'llama3.1',
              temperature = 0.6,
              top_p = 1,
              min_p = 0.05,
            },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = 'You are a general AI assistant.',
          },
          {
            provider = 'lmstudio',
            name = 'ChatLMStudio',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = {
              model = 'dummy',
              temperature = 0.97,
              top_p = 1,
              num_ctx = 8192,
            },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = 'You are a general AI assistant.',
          },
          {
            provider = 'openai',
            name = 'CodeGPT4o',
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = 'gpt-4o', temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require('gp.defaults').code_system_prompt,
          },
          {
            provider = 'openai',
            name = 'CodeGPT4o-mini',
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = 'gpt-4o-mini', temperature = 0.7, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = 'Please return ONLY code snippets.\nSTART AND END YOUR ANSWER WITH:\n\n```',
          },
          {
            provider = 'copilot',
            name = 'CodeCopilot',
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = 'gpt-4o', temperature = 0.8, top_p = 1, n = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require('gp.defaults').code_system_prompt,
          },
          {
            provider = 'googleai',
            name = 'CodeGemini',
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = 'gemini-pro', temperature = 0.8, top_p = 1 },
            system_prompt = require('gp.defaults').code_system_prompt,
          },
          {
            provider = 'pplx',
            name = 'CodePerplexityLlama3.1-8B',
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = 'llama-3.1-sonar-small-128k-chat', temperature = 0.8, top_p = 1 },
            system_prompt = require('gp.defaults').code_system_prompt,
          },
          {
            provider = 'anthropic',
            name = 'CodeClaude-3-5-Sonnet',
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = 'claude-3-5-sonnet-20240620', temperature = 0.8, top_p = 1 },
            system_prompt = require('gp.defaults').code_system_prompt,
          },
          {
            provider = 'anthropic',
            name = 'CodeClaude-3-Haiku',
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = 'claude-3-haiku-20240307', temperature = 0.8, top_p = 1 },
            system_prompt = require('gp.defaults').code_system_prompt,
          },
          {
            provider = 'ollama',
            name = 'CodeOllamaLlama3.1-8B',
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = {
              model = 'llama3.1',
              temperature = 0.4,
              top_p = 1,
              min_p = 0.05,
            },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require('gp.defaults').code_system_prompt,
          },
        },

        -- directory for storing chat files
        chat_dir = vim.fn.stdpath('data'):gsub('/$', '') .. '/gp/chats',
        -- chat user prompt prefix
        chat_user_prefix = '💬:',
        -- chat assistant prompt prefix (static string or a table {static, template})
        -- first string has to be static, second string can contain template {{agent}}
        -- just a static string is legacy and the [{{agent}}] element is added automatically
        -- if you really want just a static string, make it a table with one element { "🤖:" }
        chat_assistant_prefix = { '🤖:', '[{{agent}}]' },
        -- The banner shown at the top of each chat file.
        chat_template = require('gp.defaults').chat_template,
        -- if you want more real estate in your chat files and don't need the helper text
        -- chat_template = require("gp.defaults").short_chat_template,
        -- chat topic generation prompt
        chat_topic_gen_prompt = 'Summarize the topic of our conversation above' .. ' in two or three words. Respond only with those words.',
        -- chat topic model (string with model name or table with model name and parameters)
        -- explicitly confirm deletion of a chat file
        chat_confirm_delete = true,
        -- conceal model parameters in chat
        chat_conceal_model_params = true,
        -- local shortcuts bound to the chat buffer
        -- (be careful to choose something which will work across specified modes)
        chat_shortcut_respond = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g><C-g>' },
        chat_shortcut_delete = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>d' },
        chat_shortcut_stop = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>s' },
        chat_shortcut_new = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>c' },
        -- default search term when using :GpChatFinder
        chat_finder_pattern = 'topic ',
        chat_finder_mappings = {
          delete = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-d>' },
        },
        -- if true, finished ChatResponder won't move the cursor to the end of the buffer
        chat_free_cursor = false,
        -- use prompt buftype for chats (:h prompt-buffer)
        chat_prompt_buf_type = false,

        -- how to display GpChatToggle or GpContext
        ---@type "popup" | "split" | "vsplit" | "tabnew"
        toggle_target = 'vsplit',

        -- styling for chatfinder
        ---@type "single" | "double" | "rounded" | "solid" | "shadow" | "none"
        style_chat_finder_border = 'single',
        -- margins are number of characters or lines
        style_chat_finder_margin_bottom = 8,
        style_chat_finder_margin_left = 1,
        style_chat_finder_margin_right = 2,
        style_chat_finder_margin_top = 2,
        -- how wide should the preview be, number between 0.0 and 1.0
        style_chat_finder_preview_ratio = 0.5,

        -- styling for popup
        ---@type "single" | "double" | "rounded" | "solid" | "shadow" | "none"
        style_popup_border = 'single',
        -- margins are number of characters or lines
        style_popup_margin_bottom = 8,
        style_popup_margin_left = 1,
        style_popup_margin_right = 2,
        style_popup_margin_top = 2,
        style_popup_max_width = 160,

        -- in case of visibility colisions with other plugins, you can increase/decrease zindex
        zindex = 49,

        -- command config and templates below are used by commands like GpRewrite, GpEnew, etc.
        -- command prompt prefix for asking user for input (supports {{agent}} template variable)
        command_prompt_prefix_template = '🤖 {{agent}} ~ ',
        -- auto select command response (easier chaining of commands)
        -- if false it also frees up the buffer cursor for further editing elsewhere
        command_auto_select_response = true,

        -- templates
        template_selection = 'I have the following from {{filename}}:' .. '\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}',
        template_rewrite = 'I have the following from {{filename}}:'
          .. '\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}'
          .. '\n\nRespond exclusively with the snippet that should replace the selection above.',
        template_append = 'I have the following from {{filename}}:'
          .. '\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}'
          .. '\n\nRespond exclusively with the snippet that should be appended after the selection above.',
        template_prepend = 'I have the following from {{filename}}:'
          .. '\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}'
          .. '\n\nRespond exclusively with the snippet that should be prepended before the selection above.',
        template_command = '{{command}}',

        -- https://platform.openai.com/docs/guides/speech-to-text/quickstart
        -- Whisper costs $0.006 / minute (rounded to the nearest second)
        -- by eliminating silence and speeding up the tempo of the recording
        -- we can reduce the cost by 50% or more and get the results faster

        whisper = {
          -- you can disable whisper completely by whisper = {disable = true}
          disable = true,

          -- OpenAI audio/transcriptions api endpoint to transcribe audio to text
          endpoint = 'https://api.openai.com/v1/audio/transcriptions',
          -- directory for storing whisper files
          store_dir = (os.getenv 'TMPDIR' or os.getenv 'TEMP' or '/tmp') .. '/gp_whisper',
          -- multiplier of RMS level dB for threshold used by sox to detect silence vs speech
          -- decibels are negative, the recording is normalized to -3dB =>
          -- increase this number to pick up more (weaker) sounds as possible speech
          -- decrease this number to pick up only louder sounds as possible speech
          -- you can disable silence trimming by setting this a very high number (like 1000.0)
          silence = '1.75',
          -- whisper tempo (1.0 is normal speed)
          tempo = '1.75',
          -- The language of the input audio, in ISO-639-1 format.
          language = 'en',
          -- command to use for recording can be nil (unset) for automatic selection
          -- string ("sox", "arecord", "ffmpeg") or table with command and arguments:
          -- sox is the most universal, but can have start/end cropping issues caused by latency
          -- arecord is linux only, but has no cropping issues and is faster
          -- ffmpeg in the default configuration is macos only, but can be used on any platform
          -- (see https://trac.ffmpeg.org/wiki/Capture/Desktop for more info)
          -- below is the default configuration for all three commands:
          -- whisper_rec_cmd = {"sox", "-c", "1", "--buffer", "32", "-d", "rec.wav", "trim", "0", "60:00"},
          -- whisper_rec_cmd = {"arecord", "-c", "1", "-f", "S16_LE", "-r", "48000", "-d", "3600", "rec.wav"},
          -- whisper_rec_cmd = {"ffmpeg", "-y", "-f", "avfoundation", "-i", ":0", "-t", "3600", "rec.wav"},
          rec_cmd = nil,
        },

        -- image generation settings
        image = {
          -- you can disable image generation logic completely by image = {disable = true}
          disable = true,

          -- openai api key (string or table with command and arguments)
          -- secret = { "cat", "path_to/openai_api_key" },
          -- secret = { "bw", "get", "password", "OPENAI_API_KEY" },
          -- secret =  "sk-...",
          -- secret = os.getenv("env_name.."),
          -- if missing openai_api_key is used
          secret = os.getenv 'OPENAI_API_KEY',

          -- image prompt prefix for asking user for input (supports {{agent}} template variable)
          prompt_prefix_template = '🖌️ {{agent}} ~ ',
          -- image prompt prefix for asking location to save the image
          prompt_save = '🖌️💾 ~ ',
          -- default folder for saving images
          store_dir = (os.getenv 'TMPDIR' or os.getenv 'TEMP' or '/tmp') .. '/gp_images',
          -- default image agents (model + settings)
          -- to remove some default agent completely set it like:
          -- image.agents = {  { name = "DALL-E-3-1024x1792-vivid", disable = true, }, ... },
          agents = {
            {
              name = 'ExampleDisabledAgent',
              disable = true,
            },
            {
              name = 'DALL-E-3-1024x1024-vivid',
              model = 'dall-e-3',
              quality = 'standard',
              style = 'vivid',
              size = '1024x1024',
            },
            {
              name = 'DALL-E-3-1792x1024-vivid',
              model = 'dall-e-3',
              quality = 'standard',
              style = 'vivid',
              size = '1792x1024',
            },
            {
              name = 'DALL-E-3-1024x1792-vivid',
              model = 'dall-e-3',
              quality = 'standard',
              style = 'vivid',
              size = '1024x1792',
            },
            {
              name = 'DALL-E-3-1024x1024-natural',
              model = 'dall-e-3',
              quality = 'standard',
              style = 'natural',
              size = '1024x1024',
            },
            {
              name = 'DALL-E-3-1792x1024-natural',
              model = 'dall-e-3',
              quality = 'standard',
              style = 'natural',
              size = '1792x1024',
            },
            {
              name = 'DALL-E-3-1024x1792-natural',
              model = 'dall-e-3',
              quality = 'standard',
              style = 'natural',
              size = '1024x1792',
            },
            {
              name = 'DALL-E-3-1024x1024-vivid-hd',
              model = 'dall-e-3',
              quality = 'hd',
              style = 'vivid',
              size = '1024x1024',
            },
            {
              name = 'DALL-E-3-1792x1024-vivid-hd',
              model = 'dall-e-3',
              quality = 'hd',
              style = 'vivid',
              size = '1792x1024',
            },
            {
              name = 'DALL-E-3-1024x1792-vivid-hd',
              model = 'dall-e-3',
              quality = 'hd',
              style = 'vivid',
              size = '1024x1792',
            },
            {
              name = 'DALL-E-3-1024x1024-natural-hd',
              model = 'dall-e-3',
              quality = 'hd',
              style = 'natural',
              size = '1024x1024',
            },
            {
              name = 'DALL-E-3-1792x1024-natural-hd',
              model = 'dall-e-3',
              quality = 'hd',
              style = 'natural',
              size = '1792x1024',
            },
            {
              name = 'DALL-E-3-1024x1792-natural-hd',
              model = 'dall-e-3',
              quality = 'hd',
              style = 'natural',
              size = '1024x1792',
            },
          },
        },

        -- example hook functions (see Extend functionality section in the README)
        hooks = {
          -- GpInspectPlugin provides a detailed inspection of the plugin state
          InspectPlugin = function(plugin, params)
            local bufnr = vim.api.nvim_create_buf(false, true)
            local copy = vim.deepcopy(plugin)
            local key = copy.config.openai_api_key or ''
            copy.config.openai_api_key = key:sub(1, 3) .. string.rep('*', #key - 6) .. key:sub(-3)
            local plugin_info = string.format('Plugin structure:\n%s', vim.inspect(copy))
            local params_info = string.format('Command params:\n%s', vim.inspect(params))
            local lines = vim.split(plugin_info .. '\n' .. params_info, '\n')
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
            vim.api.nvim_win_set_buf(0, bufnr)
          end,

          -- GpInspectLog for checking the log file
          InspectLog = function(plugin, params)
            local log_file = plugin.config.log_file
            local buffer = plugin.helpers.get_buffer(log_file)
            if not buffer then
              vim.cmd('e ' .. log_file)
            else
              vim.cmd('buffer ' .. buffer)
            end
          end,

          -- GpImplement rewrites the provided selection/range based on comments in it
          Implement = function(gp, params)
            local template = 'Having following from {{filename}}:\n\n'
              .. '```{{filetype}}\n{{selection}}\n```\n\n'
              .. 'Please rewrite this according to the contained instructions.'
              .. '\n\nRespond exclusively with the snippet that should replace the selection above.'

            local agent = gp.get_command_agent()
            gp.logger.info('Implementing selection with agent: ' .. agent.name)

            gp.Prompt(
              params,
              gp.Target.rewrite,
              agent,
              template,
              nil, -- command will run directly without any prompting for user input
              nil -- no predefined instructions (e.g. speech-to-text from Whisper)
            )
          end,

          -- your own functions can go here, see README for more examples like
          -- :GpExplain, :GpUnitTests.., :GpTranslator etc.

          -- -- example of making :%GpChatNew a dedicated command which
          -- -- opens new chat with the entire current buffer as a context
          -- BufferChatNew = function(gp, _)
          -- 	-- call GpChatNew command in range mode on whole buffer
          -- 	vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
          -- end,

          -- -- example of adding command which opens new chat dedicated for translation
          -- Translator = function(gp, params)
          -- 	local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
          -- 	gp.cmd.ChatNew(params, chat_system_prompt)
          --
          -- 	-- -- you can also create a chat with a specific fixed agent like this:
          -- 	-- local agent = gp.get_chat_agent("ChatGPT4o")
          -- 	-- gp.cmd.ChatNew(params, chat_system_prompt, agent)
          -- end,

          -- -- example of adding command which writes unit tests for the selected code
          -- UnitTests = function(gp, params)
          -- 	local template = "I have the following code from {{filename}}:\n\n"
          -- 		.. "```{{filetype}}\n{{selection}}\n```\n\n"
          -- 		.. "Please respond by writing table driven unit tests for the code above."
          -- 	local agent = gp.get_command_agent()
          -- 	gp.Prompt(params, gp.Target.enew, agent, template)
          -- end,

          -- -- example of adding command which explains the selected code
          -- Explain = function(gp, params)
          -- 	local template = "I have the following code from {{filename}}:\n\n"
          -- 		.. "```{{filetype}}\n{{selection}}\n```\n\n"
          -- 		.. "Please respond by explaining the code above."
          -- 	local agent = gp.get_chat_agent()
          -- 	gp.Prompt(params, gp.Target.popup, agent, template)
          -- end,
        },
      }
      require('gp').setup(conf)

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
      require('which-key').add {
        -- VISUAL mode mappings
        -- s, x, v modes are handled the same way by which_key
        {
          mode = { 'v' },
          nowait = true,
          remap = false,
          { '<C-g><C-t>', ":<C-u>'<,'>GpChatNew tabnew<cr>", desc = 'ChatNew tabnew' },
          { '<C-g><C-v>', ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = 'ChatNew vsplit' },
          { '<C-g><C-x>', ":<C-u>'<,'>GpChatNew split<cr>", desc = 'ChatNew split' },
          { '<C-g>a', ":<C-u>'<,'>GpAppend<cr>", desc = 'Visual Append (after)' },
          { '<C-g>b', ":<C-u>'<,'>GpPrepend<cr>", desc = 'Visual Prepend (before)' },
          { '<C-g>c', ":<C-u>'<,'>GpChatNew<cr>", desc = 'Visual Chat New' },
          { '<C-g>g', group = 'generate into new ..' },
          { '<C-g>ge', ":<C-u>'<,'>GpEnew<cr>", desc = 'Visual GpEnew' },
          { '<C-g>gn', ":<C-u>'<,'>GpNew<cr>", desc = 'Visual GpNew' },
          { '<C-g>gp', ":<C-u>'<,'>GpPopup<cr>", desc = 'Visual Popup' },
          { '<C-g>gt', ":<C-u>'<,'>GpTabnew<cr>", desc = 'Visual GpTabnew' },
          { '<C-g>gv', ":<C-u>'<,'>GpVnew<cr>", desc = 'Visual GpVnew' },
          { '<C-g>i', ":<C-u>'<,'>GpImplement<cr>", desc = 'Implement selection' },
          { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
          { '<C-g>p', ":<C-u>'<,'>GpChatPaste<cr>", desc = 'Visual Chat Paste' },
          { '<C-g>r', ":<C-u>'<,'>GpRewrite<cr>", desc = 'Visual Rewrite' },
          { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
          { '<C-g>t', ":<C-u>'<,'>GpChatToggle<cr>", desc = 'Visual Toggle Chat' },
          { '<C-g>w', group = 'Whisper' },
          { '<C-g>wa', ":<C-u>'<,'>GpWhisperAppend<cr>", desc = 'Whisper Append' },
          { '<C-g>wb', ":<C-u>'<,'>GpWhisperPrepend<cr>", desc = 'Whisper Prepend' },
          { '<C-g>we', ":<C-u>'<,'>GpWhisperEnew<cr>", desc = 'Whisper Enew' },
          { '<C-g>wn', ":<C-u>'<,'>GpWhisperNew<cr>", desc = 'Whisper New' },
          { '<C-g>wp', ":<C-u>'<,'>GpWhisperPopup<cr>", desc = 'Whisper Popup' },
          { '<C-g>wr', ":<C-u>'<,'>GpWhisperRewrite<cr>", desc = 'Whisper Rewrite' },
          { '<C-g>wt', ":<C-u>'<,'>GpWhisperTabnew<cr>", desc = 'Whisper Tabnew' },
          { '<C-g>wv', ":<C-u>'<,'>GpWhisperVnew<cr>", desc = 'Whisper Vnew' },
          { '<C-g>ww', ":<C-u>'<,'>GpWhisper<cr>", desc = 'Whisper' },
          { '<C-g>x', ":<C-u>'<,'>GpContext<cr>", desc = 'Visual GpContext' },
        },

        -- NORMAL mode mappings
        {
          mode = { 'n' },
          nowait = true,
          remap = false,
          { '<C-g><C-t>', '<cmd>GpChatNew tabnew<cr>', desc = 'New Chat tabnew' },
          { '<C-g><C-v>', '<cmd>GpChatNew vsplit<cr>', desc = 'New Chat vsplit' },
          { '<C-g><C-x>', '<cmd>GpChatNew split<cr>', desc = 'New Chat split' },
          { '<C-g>a', '<cmd>GpAppend<cr>', desc = 'Append (after)' },
          { '<C-g>b', '<cmd>GpPrepend<cr>', desc = 'Prepend (before)' },
          { '<C-g>c', '<cmd>GpChatNew<cr>', desc = 'New Chat' },
          { '<C-g>f', '<cmd>GpChatFinder<cr>', desc = 'Chat Finder' },
          { '<C-g>g', group = 'generate into new ..' },
          { '<C-g>ge', '<cmd>GpEnew<cr>', desc = 'GpEnew' },
          { '<C-g>gn', '<cmd>GpNew<cr>', desc = 'GpNew' },
          { '<C-g>gp', '<cmd>GpPopup<cr>', desc = 'Popup' },
          { '<C-g>gt', '<cmd>GpTabnew<cr>', desc = 'GpTabnew' },
          { '<C-g>gv', '<cmd>GpVnew<cr>', desc = 'GpVnew' },
          { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
          { '<C-g>r', '<cmd>GpRewrite<cr>', desc = 'Inline Rewrite' },
          { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
          { '<C-g>t', '<cmd>GpChatToggle<cr>', desc = 'Toggle Chat' },
          { '<C-g>w', group = 'Whisper' },
          { '<C-g>wa', '<cmd>GpWhisperAppend<cr>', desc = 'Whisper Append (after)' },
          { '<C-g>wb', '<cmd>GpWhisperPrepend<cr>', desc = 'Whisper Prepend (before)' },
          { '<C-g>we', '<cmd>GpWhisperEnew<cr>', desc = 'Whisper Enew' },
          { '<C-g>wn', '<cmd>GpWhisperNew<cr>', desc = 'Whisper New' },
          { '<C-g>wp', '<cmd>GpWhisperPopup<cr>', desc = 'Whisper Popup' },
          { '<C-g>wr', '<cmd>GpWhisperRewrite<cr>', desc = 'Whisper Inline Rewrite' },
          { '<C-g>wt', '<cmd>GpWhisperTabnew<cr>', desc = 'Whisper Tabnew' },
          { '<C-g>wv', '<cmd>GpWhisperVnew<cr>', desc = 'Whisper Vnew' },
          { '<C-g>ww', '<cmd>GpWhisper<cr>', desc = 'Whisper' },
          { '<C-g>x', '<cmd>GpContext<cr>', desc = 'Toggle GpContext' },
        },

        -- INSERT mode mappings
        {
          mode = { 'i' },
          nowait = true,
          remap = false,
          { '<C-g><C-t>', '<cmd>GpChatNew tabnew<cr>', desc = 'New Chat tabnew' },
          { '<C-g><C-v>', '<cmd>GpChatNew vsplit<cr>', desc = 'New Chat vsplit' },
          { '<C-g><C-x>', '<cmd>GpChatNew split<cr>', desc = 'New Chat split' },
          { '<C-g>a', '<cmd>GpAppend<cr>', desc = 'Append (after)' },
          { '<C-g>b', '<cmd>GpPrepend<cr>', desc = 'Prepend (before)' },
          { '<C-g>c', '<cmd>GpChatNew<cr>', desc = 'New Chat' },
          { '<C-g>f', '<cmd>GpChatFinder<cr>', desc = 'Chat Finder' },
          { '<C-g>g', group = 'generate into new ..' },
          { '<C-g>ge', '<cmd>GpEnew<cr>', desc = 'GpEnew' },
          { '<C-g>gn', '<cmd>GpNew<cr>', desc = 'GpNew' },
          { '<C-g>gp', '<cmd>GpPopup<cr>', desc = 'Popup' },
          { '<C-g>gt', '<cmd>GpTabnew<cr>', desc = 'GpTabnew' },
          { '<C-g>gv', '<cmd>GpVnew<cr>', desc = 'GpVnew' },
          { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
          { '<C-g>r', '<cmd>GpRewrite<cr>', desc = 'Inline Rewrite' },
          { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
          { '<C-g>t', '<cmd>GpChatToggle<cr>', desc = 'Toggle Chat' },
          { '<C-g>w', group = 'Whisper' },
          { '<C-g>wa', '<cmd>GpWhisperAppend<cr>', desc = 'Whisper Append (after)' },
          { '<C-g>wb', '<cmd>GpWhisperPrepend<cr>', desc = 'Whisper Prepend (before)' },
          { '<C-g>we', '<cmd>GpWhisperEnew<cr>', desc = 'Whisper Enew' },
          { '<C-g>wn', '<cmd>GpWhisperNew<cr>', desc = 'Whisper New' },
          { '<C-g>wp', '<cmd>GpWhisperPopup<cr>', desc = 'Whisper Popup' },
          { '<C-g>wr', '<cmd>GpWhisperRewrite<cr>', desc = 'Whisper Inline Rewrite' },
          { '<C-g>wt', '<cmd>GpWhisperTabnew<cr>', desc = 'Whisper Tabnew' },
          { '<C-g>wv', '<cmd>GpWhisperVnew<cr>', desc = 'Whisper Vnew' },
          { '<C-g>ww', '<cmd>GpWhisper<cr>', desc = 'Whisper' },
          { '<C-g>x', '<cmd>GpContext<cr>', desc = 'Toggle GpContext' },
        },
      }
    end,
  },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Configs that depend on the presence of certain plugins above
-- Enable Treesitter-based folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 99 -- Ensures all folds are open when initially opening a file

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
