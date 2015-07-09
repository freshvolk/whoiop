""""""""""""""""""""""
" Author: Brian Volk
" Based On: vimrc by Shawn Tice, http://dougblack.io/words/a-good-vimrc.html
""""""""""""""""""""""


""""""""""""""""""""""
" Vundle settings {{{
""""""""""""""""""""""

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" " Keep Plugin commands between vundle#begin/end.

""""""""""""""""""""""
" General Options
Plugin 'bling/vim-airline'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'tpope/vim-fugitive'

""""""""""""""""""""""
" General Syntax Plugins
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'luochen1990/rainbow'

""""""""""""""""""""""
" Rust Plugins
Plugin 'wting/rust.vim'

""""""""""""""""""""""
" Go Plugins
Plugin 'fatih/vim-go'

""""""""""""""""""""""
" Erlang/Elixir Plugins
Plugin 'jimenezrick/vimerl'
Plugin 'elixir-lang/vim-elixir'

""""""""""""""""""""""
" JS Plugins
Plugin 'vim-coffee-script'
Plugin 'moll/vim-node'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'marijnh/tern_for_vim'

""""""""""""""""""""""
" Auto Complete
Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
filetype on              " Recognize syntax by file extension.
filetype indent on       " Check for indent file.
filetype plugin on       " Allow plugins to be loaded by file type.
syntax on                " Syntax highlighting.

""""""""""""""""""""""}}}
" General {{{
""""""""""""""""""""""

set shell=bash

set guioptions=am        " No toolbar in the gui; must be first in .vimrc.
" encoding settings for gVim
set encoding=utf-8
set fileencoding=utf-8

set nocompatible         " No compatibility with vi.
set modelines=1

""""""""""""""""""""""
" Commands {{{

let mapleader=","       " leader is comma
inoremap jk <esc>       " jk is escape

" toggle gundo (for bad mistakes teehee*~)
nnoremap <leader>u :GundoToggle<CR>

nnoremap <leader>a :Ag	" open ag.vim

""""""""""""""""""""""}}}
" Errors {{{

set visualbell 
set t_vb=

""""""""""""""""""""""}}}
" Cartography {{{

" Make Q reformat text.
noremap Q gq

" Open the file under the cursor in a new tab.
noremap <Leader>ot <C-W>gf

" Toggle highlighting of the last search.
noremap <Leader>h :set hlsearch! hlsearch?<CR>

" Open a scratch buffer.
noremap <Leader>s :Scratch<CR>

" Use C-hjkl in to change windows
nnoremap <C-h> <C-w><Left>
nnoremap <C-j> <C-w><Down>
nnoremap <C-k> <C-w><Up>
nnoremap <C-l> <C-w><Right>


""""""""""""""""""""""}}}
" Searching {{{

set gdefault			" Assume :s uses /g.
set ignorecase			" Ignore case in regular expressions
set incsearch			" Immediately highlight search matches.
set hlsearch			" highlight matches
set smartcase           " Searches are case-sensitive if caps used.


""""""""""""""""""""""}}}
" Colors {{{

set background=dark		" dark background
colorscheme badwolf		" colorscheme ... this comment is so helpful
syntax enable			" enable syntax processing


""""""""""""""""""""""}}}
" Default Spacing {{{

set tabstop=3			" number of visual spaces per TAB
set softtabstop=3		" number of spaces in tab when editing
set shiftwidth=3        " >> and << shift 3 spaces.
set scrolloff=6         " Keep min of 6 lines above/below cursor.
set expandtab			" tabs are spaces
set backspace=2			" Allow <BS> to go past last insert.


""""""""""""""""""""""}}}
" Formatting settings {{{

" t: Auto-wrap text using textwidth. (default)
" c: Auto-wrap comments; insert comment leader. (default)
" q: Allow formatting of comments with "gq". (default)
" r: Insert comment leader after hitting <Enter>.
" o: Insert comment leader after hitting 'o' or 'O' in command mode.
" n: Auto-format lists, wrapping to text *after* the list bullet char.
" l: Don't auto-wrap if a line is already longer than textwidth.
set formatoptions+=ronl


""""""""""""""""""""""}}}
" UI Settings {{{

set number				" show line numbers
set ruler				" Display row, column and % of document.

set showcmd				" show command in bottom bar
set showmatch			" highlight matching [{()}]
set showmode			" Show current mode.

set cursorline			" highlight current line
set lazyredraw			" redraw only when we need to.
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>


""""""""""""""""""""""}}}
" Folding {{{

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=syntax   " fold based on syntax (override for visual languages)


""""""""""""""""""""""}}}
" Movement {{{

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move and by logical
nnoremap gj j
nnoremap gk k

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" highlight last inserted text
nnoremap gV `[v`]

""""""""""""""""""""""}}}
" Functions {{{

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
   " save last search & cursor position
   let l = line(".")
   let c = col(".")
   %s/\s\+$//e
   call cursor(l, c)
endfun

" Restore the cursor when we can.

function! RestoreCursor()
    if line("'\"") <= line("$")
        normal! g`"
        normal! zz
    endif
endfunction

" }}}


" From: https://gist.github.com/3882918
" Author: Marc Zych
nnoremap <silent> <C-o> :call FindFile()<CR>

function! FindFile()
   " Get the word under cursor.
   let cursorWord = expand("<cword>")
   " Get the current file name and keep only the extension.
   let currentFile = expand("%")
   let extPos = stridx(currentFile, ".")

   " Append an extension only if the current file has an extension.
   if extPos != -1
      let extension = strpart(currentFile, extPos)
   else
      let extension = ""
   endif

   " Construct the file name.
   let fileName = cursorWord.extension

   " Open the file in the current buffer.
   execute "find ".fileName
endfunction


""""""""""""""""""""""}}}
" Addon Specifics {{{
""""""""""""""""""""""

""""""""""""""""""""""
" CtrlP settings {{{

let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'


""""""""""""""""""""""}}}
" tmux settings {{{

" allows cursor change in tmux mode

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


""""""""""""""""""""""}}}
" Vundle settings {{{

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html

Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'luochen1990/rainbow'
Plugin 'wting/rust.vim'
Plugin 'fatih/vim-go'
" Erlang/Elixir Plugins
Plugin 'jimenezrick/vimerl'
Plugin 'elixir-lang/vim-elixir'
" JS Plugins
Plugin 'vim-coffee-script'
Plugin 'moll/vim-node'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'marijnh/tern_for_vim'
" Auto Complete
Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
filetype on              " Recognize syntax by file extension.
filetype indent on       " Check for indent file.
filetype plugin on       " Allow plugins to be loaded by file type.
syntax on                " Syntax highlighting.


" }}}


""""""""""""""""""""""}}}
" Autogroup {{{
""""""""""""""""""""""

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
	 autocmd BufWinEnter * call RestoreCursor()
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.ex :call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal list
    autocmd FileType java setlocal tabstop=4
    autocmd FileType java setlocal shiftwidth=4
    autocmd FileType java setlocal softtabstop=4
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType elixir setlocal tabstop=2
    autocmd FileType elixir setlocal shiftwidth=2
    autocmd FileType elixir setlocal softtabstop=2
    autocmd FileType elixir setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

""""""""""""""""""""""}}}

" vim:foldmethod=marker:foldlevel=1
