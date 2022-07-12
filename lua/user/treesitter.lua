local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup {
    ensure_installed = "maintained",
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
    }
}

