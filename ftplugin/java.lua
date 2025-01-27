local home = os.getenv 'HOME'
local jdtls = require 'jdtls'
local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
local mason_packages_path = home .. '/.local/share/nvim/mason/packages/'
local jdtls_path = mason_packages_path .. 'jdtls/'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.onCompletionItemSelectedCommand = 'editor.action.triggerParameterHints'

local on_attach = function()
    vim.api.nvim_set_keymap('n', '<A-o>', "<Cmd>lua require'jdtls'.organize_imports()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'crv', "<Cmd>lua require('jdtls').extract_variable()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', 'crv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'crc', "<Cmd>lua require('jdtls').extract_constant()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', 'crc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', 'crm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { noremap = true, silent = true })

    vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
        callback = function()
            vim.lsp.inlay_hint.enable(true, nil)
        end,
    })
    vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
        callback = function()
            vim.lsp.inlay_hint.enable(false, nil)
        end,
    })
end

-- This bundles definition is the same as in the previous section (java-debug installation)
local bundles = {
    vim.fn.glob(mason_packages_path .. 'java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', true),
}

-- This is the new part
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_packages_path .. 'java-test/extension/server/*.jar', true), '\n'))

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    on_attach = on_attach,
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        -- 💀
        'java', -- or '/path/to/java17_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',

        -- 💀
        '-jar',
        jdtls_path .. 'plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version

        -- 💀
        '-configuration',
        jdtls_path .. 'config_linux/',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.

        -- 💀
        -- See `data directory configuration` section in the README
        '-data',
        workspace_dir,
    },

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    --
    -- vim.fs.root requires Neovim 0.10.
    -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
    root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew' }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            edit = { smartSemiColon = { enabled = true } },
            quickfix = { showAt = true },
            implementationCodeLens = { enabled = true },
            referencesCodeLens = { enabled = true },
            format = { enabled = true },
            references = { includeDecompiledSources = true },
            saveActions = { organizeImports = false },
            signatureHelp = { enabled = true, description = { enabled = true } },
            inlayHints = {
                parameterNames = {
                    enabled = 'all', -- literals, all, none
                },
            },
        },
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        extendedClientCapabilities = extendedClientCapabilities,
        bundles = bundles,
    },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.

jdtls.start_or_attach(config)
