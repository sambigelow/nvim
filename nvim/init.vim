" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath=&runtimepath
" source ~/.vimrc

call plug#begin()

	" Some basics that should be included in vim
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-vinegar'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-fugitive'

	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	" a theme
	Plug 'ayu-theme/ayu-vim'

	" Set up language server stuff
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}

call plug#end()


"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" General Config +++++++++++++++++++++++++++++++++++++++++++++
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

set encoding=utf-8

" auto indent and make new line when hitting enter in parentheses
set autoindent
set smartindent

" Default tab setting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab


" open splits below and to the right
set splitbelow
set splitright

" Remove need for ctrl-w then h,j,k,l
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" turn on syntax highlighting
syntax enable

set nocompatible
set ignorecase            " Search ingnoring case
set smartcase             " Do not ignore case if the search pattern
                          "   has uppercase
set noerrorbells          " The computer makes enough noise as it is
set belloff=esc
set nowrap                " Wrapping sucks (except on markdown)

set inccommand=split	  " show replacements in a split screen, before applying to the file.

set title

autocmd BufRead,BufNewFile *.md,*.txt setlocal wrap " DO wrap on markdown files

set mouse=a               " Enable mouse on all modes
set showmatch
set wildmenu			  " shows a more advanced menu for auto-completion suggestions.

" hybrid linenumber mode
set number relativenumber

" toggle linenumber mode when buffer is inactive
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave  * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter    * set norelativenumber
augroup END

" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Key Mappings +++++++++++++++++++++++++++++++++++++++++++++++
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

let mapleader=" "         " use comma as leader key
nnoremap rh :nohl<CR>     " use rh to turn off all highlighting

" duplicate line with <leader>-d
nmap <leader>d :t.<CR>

" copy to system clipboard
vnoremap <C-c> "*y

let mapleader=","         " use comma as leader key
nnoremap rh :nohl<CR>     " use rh to turn off all highlighting

nmap <leader>v :vsp ~/.config/nvim/init.vim

" Some FZF shortcuts
nmap <leader><Space> :Files<CR>
nmap <leader>f :GFiles<CR>
nmap <leader>b :Buffers<CR>

" Some shortcuts for opening a file from vim's working directory
nnoremap <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Keep VisualMode after indent with > or <
vmap < <gv
vmap > >gv

" Move Visual blocks with J an K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Always show the netrw help
let g:netrw_menu=1
let g:netrw_banner=1
let g:netrw_liststyle=4

set colorcolumn=80

set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Language Servers +++++++++++++++++++++++++++++++++++++++++++
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set cmdheight=2

set updatetime=300

" Don't pass messages to |ins-completion-menu|. (I don't know what this means
" - it is suggested by COC readme)
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" ?? I don't know what this does?? Maybe delete
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" filetypes
" au BufRead,BufNewFile rettierrc set filetype=json
