" ---------------------------------------------------------------------------- "
"
"  vim.rc
"  Author: Matthias Thubauville
"
"  Thanks to Plug this .vimrc file is completly independent of any other files
"  It is enough to just ship this file!
"
"  https://github.com/junegunn/vim-plug
"
"  Make sure you have the following tools installed:
"  - git
"  - curl
"
" ---------------------------------------------------------------------------- "

" ---------------------------- First things first ---------------------------- "
" put this line first in ~/.vimrc
set nocompatible | filetype indent plugin on | syn on
" Change the <leader> key to more German-keyboard-friendly key
let mapleader=","
let maplocalleader="\\"

" ------------------------------ Plug setup ---------------------------------- "
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Themes
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
" Plugins
Plug 'AndrewRadev/linediff.vim' " Use :Linediff to diff lines marked before
Plug 'Lokaltog/vim-easymotion' " Easy motion, invoced by using 's'
Plug 'Raimondi/delimitMate' " Close brackets, quotes, etc
Plug 'airblade/vim-gitgutter' " Inline Git Diff
Plug 'bling/vim-airline' " Lightweight status line
Plug 'bronson/vim-trailing-whitespace' " Trailing Whitespaces
Plug 'conradirwin/vim-bracketed-paste' " Bracketed Paste
Plug 'ervandew/supertab' | Plug 'vim-scripts/tlib' " Tab completion for everything
Plug 'garbas/vim-snipmate' | Plug 'MarcWeber/vim-addon-mw-utils' " Snippets
Plug 'honza/vim-snippets' " Install a bunch of predefined snippets
Plug 'jceb/vim-orgmode' | Plug 'tpope/vim-speeddating' | Plug 'vim-scripts/utl.vim' | Plug 'tpope/vim-repeat' " Org Mode
Plug 'jlanzarotta/bufexplorer' " Buffer explorer
" The default mapping for toggling buffer explorer is <leader>bt
" open in vertical split: <leader>bv
" open in horizontal split: <leader>bs
Plug 'kshenoy/vim-signature' " Pluggin to toggle marks using 'm' and a mark letter
Plug 'mhinz/vim-startify' " Startify
Plug 'mileszs/ack.vim' " Ack Vim
Plug 'nathanaelkane/vim-indent-guides' " Optical help for intentation
" The default mapping for toggling indent guides is <Leader>ig
Plug 'rodjek/vim-puppet' " Puppet
Plug 'tomtom/tcomment_vim' " Quickly comment and uncomment lines
Plug 'tpope/vim-fugitive' " Vim git warpper, http://vimcasts.org/episodes/fugitive-vim-resolving-merge-conflicts-with-vimdiff/
Plug 'tpope/vim-vinegar' " Vinear
Plug 'vim-ruby/vim-ruby' " Vim Ruby
Plug 'vim-scripts/Align' " Align stuff
Plug 'vim-scripts/Gundo' " Graphical undo
Plug 'vim-scripts/LineJuggler' " LineJuggler
Plug 'vim-scripts/Mark--Karkat' " Allows to highlight multiple words simultaneously
Plug 'vim-scripts/ingo-library' " LineJuggler
Plug 'vim-scripts/visualrepeat' " LineJuggler

call plug#end()

" ---------------------------------------------------------------------------- "
" Replaced because there are better alternatives
" github:Lokaltog/vim-powerline " Replaced by vim-airline
" github:vim-scripts/multisearch.vim " Replaced by Mark--Karkat
" github:scrooloose/nerdtree " Replaced by vinegar

" FileLine: Causes errors when opening multiple files
" Allows to open files at a certain line using the :<linenumeber syntax>
" github:bogado/file-line

" Mercurial wrapper for vim
" ludovicchabant/vim-lawrencium

" Open files with ease
" kien/ctrlp.vim

" Optical helper for CTags
" majutsushi/tagbar

" Align stuff
" junegunn/vim-easy-align

" Omnicomplete but for C++
" vim-scripts/OmniCppComplete

" Review patch files direcly in vim
" junkblocker/patchreview-vim
" ---------------------------------------------------------------------------- "

" ---------------------------------------------------------------------------- "
"  F1-F12 Keys
"
" F1: Help
" F2:
" F3:
" F4:
" --
" F5: Number toggle
nnoremap <F5> :set relativenumber!<CR>
" F6: Open Gundo
nnoremap <F6> :GundoToggle<CR>
" F7: Enter BufExplorer
nmap <F7> :BufExplorerVerticalSplit<CR>
" F8: GitGutter
let g:gitgutter_enabled = 0
map <F8> :GitGutterToggle<CR>
" --
" F9:
" F10:
" F11:
" F12:
" ---------------------------------------------------------------------------- "

" -------------------------------- Plugin Settings --------------------------- "
" Remove trailing whitespaces
nmap <leader>w :FixWhitespace<CR>
vmap <leader>w :FixWhitespace<CR>

" Make split in fugitive always veritcal
set diffopt+=vertical

" Startify
let g:startify_bookmarks = [ {'vimrc': '~/.vimrc'}, {'bashrc': '~/.bashrc'} ]

" Airline
let g:airline#extensions#tabline#enabled = 1

" Vim Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Vim indent guide
let g:indent_guides_enable_on_vim_startup=1
" let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)
" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Snipmate
let g:snips_author = "Matthias Thubauville"
" ---------------------------------------------------------------------------- "

" ------------------------------- General Settings --------------------------- "
" Use the old regex engine, the new one seems to have trouble with ruby files
" set regexpengine=1
" Folder for backups
set backupdir=~/.vimbackup
if !isdirectory($HOME.'/.vimbackup')
  silent call mkdir ($HOME.'/.vimbackup', 'p')
endif
" Make arrow and other keys work
if !has('win32') && !has('win64')
        set term=$TERM
endif
" automatically enable mouse usage
"set mouse=a
scriptencoding utf-8
" allow for cursor beyond last character
set virtualedit=onemore
" Store a ton of history (default is 20)
set history=1000
" maximum number of changes that can be undone
set undolevels=1000
" only show 15 tabs
set tabpagemax=15
" display the current mode
"set showmode
" backspace for dummys
set backspace=indent,eol,start
" the /g flag on :s substitutions by default
set gdefault
"set list
" don't use tabs for indentation, but SPACES !!!
set expandtab
" use indents of 2 spaces
set shiftwidth=2
" an indentation every four columns
set tabstop=2
" let backspace delete indent
set softtabstop=2
" Autobackup on
set backup
" Disable Ex mode
nnoremap Q <nop>
" Source the vimrc file after saving it
" if has("autocmd")
"   autocmd bufwritepost .vimrc source $MYVIMRC
" endif
" Make diff ignore whitespaces
set diffopt+=iwhite
set diffexpr=""
" Equalize splits automatically when window is resized
autocmd VimResized * wincmd =
" ---------------------------------------------------------------------------- "

" ------------------------------- Interface Settings ------------------------ "
" do not enter linebreaks in newly written text
set textwidth=0
set wrapmargin=0
" wrap long lines
"set wrap
" wrap only at blank characters or !@*-+;:,./?
"set linebreak
" No extra spaces between rows
set linespace=0
" Line numbers on
set number
" show matching brackets/parenthesis
set showmatch
" find as you type search
set incsearch
" highlight search terms
set hlsearch
" windows can be 0 line high
set winminheight=0
" case insensitive search
set ignorecase
" case sensitive when uc present
set smartcase
" show list instead of just completing
set wildmenu
" command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full
" backspace and cursor keys wrap to
set whichwrap=b,s,h,l,<,>,[,]
" lines to scroll when cursor leaves screen
" minimum limes to keep above and below cursor
set scrolloff=3
" indent at the same level of the previous line
set autoindent
" Show vim-powerline
set laststatus=2
" ---------------------------------------------------------------------------- "

" --------------------------- Folding & Functions ---------------------------- "
" Fold Methods
" auto fold code
" set foldenable
" set foldmethod=manual
" set foldmethod=indent
" set foldmethod=syntax
" set foldmethod=marker
" Function to toggle the folding mode between syntax and manual
function! s:ToggleFold()
  if &foldmethod == 'manual'
    let &l:foldmethod = 'syntax'
  else
    let &l:foldmethod = 'manual'
  endif
  echo 'foldmethod is now ' . &l:foldmethod
endfunction
" ---------------------------------------------------------------------------- "

" ------------------------------ Keybindings -------------------------------- "
" Allow saving of files as sudo with :w!! when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
" Make j and k move down/up through every line even if it is wrapped
" Hint: Use `gq` to format lines to fit 80 characters
nmap j gj
nmap k gk
" Map escape on ;; - Two semicolons are easy to type.
imap ;; <Esc>
" Make Y act like the other capital letters
nnoremap Y y$
" Play back macro in q with Q
nnoremap Q @q
" Opposite of Shift+j down
"nmap <leader>j i<CR><Esc>k$
" Opposite of Shift+j up
"nmap <leader>k i<CR><Esc>ddkP$
" Close the current buffer without closing the split
nmap <leader>t :Bclose<CR>
" QuickSave
nmap <leader>s :update<CR>
" Disable search highlighting
nmap <leader>q :nohlsearch<CR>
" Reselect visual selection after < and >
vmap > >gv
vmap < <gv
" Swap buffers
nmap <C-m> :e#<CR>
" Next buffer
nmap <C-n> :bnext<CR>
" previous buffer
nmap <C-b> :bprev<CR>
" ...and remove them
nmap <silent> <leader>W :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" Toggle the folding mode between syntax and manual
nmap <Leader>ff :call <SID>ToggleFold()<CR>
" Toggle Background Color
noremap <F10> :Invbg<CR>
" Toggle between line or column highlight
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
" Toggle line wraping
nmap <leader>N :set wrap!<CR>
" Toggle Scrollbind
nmap <leader>D :set scb!<CR>
" Toggle line numbers
nmap <leader>l :setlocal number!<CR>
" Toggle diff mode
nmap <leader>d :windo set diff!<CR>
" Toggle paste mode
nmap <leader>p :set paste!<CR>
" Redraw
nmap <C-L> :redraw!<CR>
" Saner command-line history
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>
" Saner behavior of n and N
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
" Quickly edit your macros
" nnoremap <leader>Q  :<c-u><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
" ---------------------------------------------------------------------------- "

" ------------------------------- Color Fun ---------------------------------- "
" Setup solarized
function! SetupSolarized()
  " Set coloring to 256
  set t_Co=256
  " Use the solarized color scheme
  colorscheme solarized
  let g:solarized_termcolors=256
  " low or normal or high
  let g:solarized_contrast="high"
  let g:solarized_visibility="high"
  " highlight current line
  set cursorline
  hi CursorLine term=bold cterm=bold ctermbg=darkgrey ctermfg=white guibg=darkgrey guifg=white
  hi CursorColumn term=bold cterm=bold ctermbg=darkgrey ctermfg=white guibg=darkgrey guifg=white
endfunction

" Setup gruvbox
function! SetupGruvbox()
  " Set coloring to 256
  set t_Co=256
  " Use the solarized color scheme
  colorscheme gruvbox
  " highlight current line
  set cursorline
  hi CursorLine term=bold cterm=bold ctermbg=darkgrey ctermfg=white guibg=darkgrey guifg=white
  hi CursorColumn term=bold cterm=bold ctermbg=darkgrey ctermfg=white guibg=darkgrey guifg=white
endfunction

" Setup light background
function! LightBG()
  " call SetupSolarized()
  call SetupGruvbox()
  set bg=light
  hi Normal guibg=white guifg=black
  " let g:airline_theme='solarized'
  let g:airline_theme='gruvbox'
endfunction

" Setup dark background
function! DarkBG()
  " call SetupSolarized()
  call SetupGruvbox()
  set bg=dark
  hi Normal guibg=black guifg=white
  let g:airline_theme='gruvbox'
endfunction

" Toggle Background Color
function! ReverseBackground()
  let Mysyn=&syntax
  if &bg=="light"
    call DarkBG()
  else
    call LightBG()
  endif
  AirlineRefresh
  IndentGuidesEnable
  syn on
  exe "set syntax=" . Mysyn
  " echo "now syntax is "&syntax
endfunction
command! Invbg call ReverseBackground()

" Default Color setting
call DarkBG()
" call LightBG()
" ---------------------------------------------------------------------------- "
