local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }

    print "Installing packer - close and reopen Neovim..."
    vim.cmd [[ packadd packer.nvim ]]
end

-- Autocmmand that reloads neovim whenever saving this file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a "protected call" so we don't error on the furst use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Actually do plugin installation here
packer.startup(function(use)
    use "wbthomason/packer.nvim" -- have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used by other plugins

    use "tpope/vim-surround"
    use "tpope/vim-commentary"

    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- The main completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" --snippet completions
    use "hrsh7th/cmp-nvim-lsp" -- use lsp for completion
    use "hrsh7th/cmp-nvim-lua" -- use lsp for completion

    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of other snippets

    -- LSP packages
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"

    -- Telescope
    use "nvim-telescope/telescope.nvim"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use "p00f/nvim-ts-rainbow"
    use "nvim-treesitter/playground"

    -- theme packages
    use "lunarvim/colorschemes"
    use "projekt0n/github-nvim-theme"
    use "folke/tokyonight.nvim"
    use "mhartington/oceanic-next"


    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

