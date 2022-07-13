local status_ok, null_ls = pcall(require, "null_ls")
if not status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({
			filetypes = {
				"javascript",
				"typescript",
				"css",
				"scss",
				"html",
				"json",
				"yaml",
				"graphql",
				"md",
				"txt",
			},
		}),
        diagnostics.eslint,
        diagnostics.spell,
		formatting.stylua,
        formatting.rustfmt,
        diagnostics.golangcli_lint.lua,
	},
})

