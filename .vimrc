"{{{Misc Settings

set nocompatible

" This shows what you are typing as a command.
set showcmd

" Folding Stuffs
set foldmethod=marker

" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

set autoindent

set expandtab
set smarttab

set shiftwidth=2
set softtabstop=2
set tabstop=2

" use gcc
compiler gcc

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Mouse should work all the way to the right side of the screen.
if !has('nvim')
  set ttymouse=sgr
endif

set backspace=2

" Line Numbers
set number

set ignorecase

set smartcase

set incsearch

set hlsearch

set nohidden

" Use system clipboard
set clipboard=unnamedplus

" Set off the other paren
highlight MatchParen ctermbg=4
" }}}

"{{{Look and Feel

set t_Co=256

"colorscheme elflord
colorscheme zenburn

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" Change the background color past column 80
let &colorcolumn=join(range(81,999),",")

" Change the Pmenu colors
highlight Pmenu ctermbg=blue gui=bold
highlight Pmenu ctermfg=black gui=bold
"highlight Pmenu ctermfg=2 ctermbg=3 guifg=#ffffff guibg=#0000ff

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" Allow Enter to be used to accept a completion suggestion
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']
"let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 0

" Enable for ANDROID
let g:ycm_python_interpreter_path='/usr/bin/python3'
let g:ycm_python_binary_path='/usr/bin/python3'
"let g:ycm_use_clangd=0

highlight ErrorMsg ctermbg=blue ctermfg=white
highlight SpellBad ctermbg=blue ctermfg=white
highlight YcmErrorSection ctermbg=blue ctermfg=white

" }}}

"{{{ Functions


"{{{Theme Rotating
let themeindex=0
function! RotateColorTheme()
   let y = -1
   while y == -1
      let colorstring = "inkpot#ron#blue#elflord#evening#koehler#murphy#pablo#desert#torte#"
      let x = match( colorstring, "#", g:themeindex )
      let y = match( colorstring, "#", x + 1 )
      let g:themeindex = x + 1
      if y == -1
         let g:themeindex = 0
      else
         let themestring = strpart(colorstring, x + 1, y - x - 1)
         return ":colorscheme ".themestring
      endif
   endwhile
endfunction
" }}}

"}}}

"{{{ Mappings

" Insert an actual tab character with shift-tab
inoremap <S-Tab> <C-V><Tab>

" Next Tab
nnoremap <silent> <C-Right> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" Format file
nnoremap <silent> <F4> :FormatCode<CR>

" ctags
set tags=./tags;/
nnoremap <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Rotate Color Scheme <F8>
nnoremap <silent> <F8> :execute RotateColorTheme()<CR>

" Remove all trailing whitespace (Alt-w)
nnoremap <silent> <C-K> :%s/\s\+$//g<CR>

" Remove DOS line endings
nnoremap <silent> <F11> :%s///g<CR>

" YouCompleteMe
nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>

nnoremap gb <C-o>

" Refresh YCM suggestions
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

" If there is a FixIt suggestion in the YCM error box, press F6 to do it.
nnoremap <F9> :YcmCompleter FixIt<CR>

" Paste Mode <F10>
set pastetoggle=<F10>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

nnoremap <silent> k gk
nnoremap <silent> j gj
" inoremap <silent> <Up> <Esc>gka
" inoremap <silent> <Down> <Esc>gja

nnoremap <silent> <Home> i <Esc>r
nnoremap <silent> <End> a <Esc>r

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" leader-f will toggle folds
" nnoremap <leader>f za

" Make it easier to delete without cutting
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

" Don't allow use of arrow keys
nmap <Up>    <nop>
nmap <Down>  <nop>
nmap <Left>  <nop>
nmap <Right> <nop>

imap <Up>    <nop>
imap <Down>  <nop>
imap <Left>  <nop>
imap <Right> <nop>

" Escape char will bring you back to edit mode in a terminal instance
" (:terminal)
tnoremap <Esc> <C-\><C-n>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Testing
set completeopt=longest,menuone,preview

"}}}

"{{{ More things

"======================"
" Vundle configuration "
"======================"

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
if isdirectory(expand('$HOME/.vim/bundle/Vundle.vim'))
  call vundle#begin()
  " Required
  " let Vundle manage Vundle, required
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'gmarik/vundle'
  " Install plugins that come from github.  Once Vundle is installed, these can be
  " Add maktaba and codefmt to the runtimepath.
  " (The latter must be installed before it can be used.)
  Plugin 'google/vim-maktaba'
  Plugin 'google/vim-codefmt'
  " Also add Glaive, which is used to configure codefmt's maktaba flags. See
  " `:help :Glaive` for usage.
  Plugin 'google/vim-glaive'
  " installed with :PluginInstall
  "Plugin 'scrooloose/nerdcommenter'
  "Plugin 'Valloric/MatchTagAlways'
  "Plugin 'vim-scripts/netrw.vim'
  "Plugin 'tpope/vim-sensible'
  "Plugin 'SirVer/ultisnips'
  Plugin 'Valloric/YouCompleteMe'
  " Provide many default snippets for a variety of snippets.
  " Uncomment and :PluginInstall to enable
  " Plugin 'honza/vim-snippets'
  call vundle#end()
  call glaive#Install()
  Glaive codefmt plugin[mappings]
else
  echomsg 'Vundle is not installed. You can install Vundle from'
      \ 'https://github.com/VundleVim/Vundle.vim'
endif

filetype plugin indent on

"===================="
" Some basic options "
"===================="

" Enable syntax highlighting
syntax on

" Uncomment if you want to map ; to : to cut down on chording
" nnoremap ; :

" Automatically change the working path to the path of the current file
autocmd BufNewFile,BufEnter * silent! lcd %:p:h

" Show line numbers
set number

" use » to mark Tabs and ° to mark trailing whitespace. This is a
" non-obtrusive way to mark these special characters.
"set list listchars=tab:»\
" ,trail:°


" Highlight the search term when you search for it.
set hlsearch

" By default, it looks up man pages for the word under the cursor, which isn't
" very useful, so we map it to something else.
nnoremap <s-k> <CR>

" Explicitly set the Leader to space. You can use '\' (the default),
" or anything else (some people like ';').
let mapleader=' '

" Wrap autocmds inside an augroup to protect against reloading this script.
" For more details, see:
" http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
augroup autoformat
  autocmd!
  " Autoformat go files on write.
  autocmd FileType go AutoFormatBuffer gofmt
  " Autoformat proto files on write.
  autocmd FileType proto AutoFormatBuffer clang-format
  " Autoformat c and c++ files on write.
  autocmd FileType c,cpp AutoFormatBuffer clang-format
  " Autoformat python with autopep8
  autocmd FileType python AutoFormatBuffer autopep8

augroup END

" }}}
