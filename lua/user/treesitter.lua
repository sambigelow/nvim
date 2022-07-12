local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup({
    ensure_installed = {
        "astro",
        "bash",
        "c",
        "cmake",
        "css",
        "cpp",
        "go",
        "haskell",
        "html",
        "javascript",
        "json",
        "json5",
        "lua",
        "make",
        "ocaml",
        "python",
        "ruby",
        "rust",
        "scss",
        "sql",
        "svelte",
        "swift",
        "tsx",
        "typescript",
        "vue"
    },
    sync_install = false,
    ignore_install = { "" },
    highlight = {
        enable = true,
        disable = { "" },
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = "yaml" },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" } (list of langages you want this disabled for)
        extended_mode = true,
        max_file_lines = nil, -- Do not enable for files more than n lines
        -- colors = {},
        -- termcolors = {},
    },
    autopairs = {
        enable = true
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    }
})

-- vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
--   group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--   callback = function()
--     vim.opt.foldmethod     = 'expr'
--     vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
--   end
-- })

