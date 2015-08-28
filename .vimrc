" ---------------------------------------------------------------------------- "
"
"  vim.rc
"  Author: Matthias Thubauville
"
"  Thanks the VAM (VIM addon manager) this .vimrc file is completly
"  independent of any other files - it is enough to just ship this file!
"
"  https://github.com/MarcWeber/vim-addon-manager
"
"  Make sure you have the following tools installed:
"  - git, hg
"  - curl, wget
"
" ---------------------------------------------------------------------------- "
" ---------------------------- First things first ---------------------------- "
" put this line first in ~/.vimrc
set nocompatible | filetype indent plugin on | syn on
" Change the <leader> key to more German-keyboard-friendly key
let mapleader=","

" ------------------------------- VAM setup ---------------------------------- "
" Makes VAM connect to github via https:// and not via git://
" To avoid trouble with proxies/firewalls blocking anything but http(s)
let g:vim_addon_manager = {'scms': {'git': {}}}
fun! MyGitCheckout(repository, targetDir)
  let a:repository.url = substitute(a:repository.url, '^git://github', 'https://github', '')
  return vam#utils#RunShell('git clone --depth=1 $.url $p', a:repository, a:targetDir)
endfun
let g:vim_addon_manager.scms.git.clone=['MyGitCheckout']

" Bootstrap VAM
fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " Force your ~/.vim/after directory to be last in &rtp always:
  " let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 https://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  silent call vam#ActivateAddons([], {})
endfun
silent call SetupVAM()

" Activating Plugins
let scripts = []
" Pluggin to toggle marks using 'm' and a mark letter
call add(scripts, {'name': 'github:kshenoy/vim-signature'})
" Allows to highlight multiple words simultaneously
call add(scripts, {'name': 'github:vim-scripts/Mark--Karkat'})
" Tab completion for everything
call add(scripts, {'name': 'github:ervandew/supertab.git'})
" Lightweight status line
call add(scripts, {'name': 'github:bling/vim-airline'})
" Quickly comment and uncomment lines
call add(scripts, {'name': 'github:tomtom/tcomment_vim'})
" Use :Linediff to diff lines marked before
call add(scripts, {'name': 'github:AndrewRadev/linediff.vim'})
" Align stuff
call add(scripts, {'name': 'github:vim-scripts/Align'})
" Easy motion, invoced by using 's'
call add(scripts, {'name': 'github:Lokaltog/vim-easymotion'})
" Graphical undo
call add(scripts, {'name': 'github:vim-scripts/Gundo'})
" Themes
call add(scripts, {'name': 'github:altercation/vim-colors-solarized'})
call add(scripts, {'name': 'github:morhetz/gruvbox'})
" Close brackets, quotes, etc
call add(scripts, {'name': 'github:Raimondi/delimitMate'})
" Vim git warpper
call add(scripts, {'name': 'github:tpope/vim-fugitive'})
" Toggle between relative and absolute numbers
call add(scripts, {'name': 'github:jeffkreeftmeijer/vim-numbertoggle'})
" Snippets
call add(scripts, {'name': 'github:garbas/vim-snipmate'})
" Install a bunch of predefined snippets
"  * Global snippets can be found in
"     $HOME/.vim/vim-addons/github-honza-vim-snippets/snippets/_.snippets
"  * The availability of a snippet in a file is dependent on the enabled syntax
"    You simpy run, set: syntax=html to enable the html syntax (and therefore the snippets)
"  * To create your own snippets store them in $HOME/.vim/snippets (see also h: SnipMate-snippets)
call add(scripts, {'name': 'github:honza/vim-snippets'})
" Optical help for intentation
" The default mapping for toggling indent guides is <Leader>ig
call add(scripts, {'name': 'github:nathanaelkane/vim-indent-guides'})
" Buffer explorer
" The default mapping for toggling buffer explorer is <leader>bt
" open in vertical split: <leader>bv
" open in horizontal split: <leader>bs
call add(scripts, {'name': 'github:jlanzarotta/bufexplorer'})
" FileLine
" Allows to open files at a certain line using the :<linenumeber syntax>
call add(scripts, {'name': 'github:bogado/file-line'})
" Bracketed Paste
" Reconizes input which pasted via terminal and enables paste mode
" automatically
call add(scripts, {'name': 'github:conradirwin/vim-bracketed-paste'})
" Puppet
call add(scripts, {'name': 'github:rodjek/vim-puppet.git'})
" Vinear
call add(scripts, {'name': 'github:tpope/vim-vinegar.git'})
" LineJuggler
call add(scripts, {'name': 'github:vim-scripts/LineJuggler.git'})
call add(scripts, {'name': 'github:vim-scripts/ingo-library.git'})
call add(scripts, {'name': 'github:vim-scripts/visualrepeat.git'})

" Replaced because there are better alternatives
" call add(scripts, {'name': 'github:Lokaltog/vim-powerline'}) " Replaced by vim-airline
" call add(scripts, {'name': 'github:vim-scripts/multisearch.vim'}) " Replaced by Mark--Karkat
" call add(scripts, {'name': 'github:scrooloose/nerdtree'}) " Replaced by vinegar

" Not yet tested
" Powerful commenter plugin
" call add(scripts, {'name': 'github:scrooloose/nerdcommenter'})

" Disabled on purpose - not needed atm
" Ag: The silver search - a even faster grep
" call add(scripts, {'name': 'github:rking/ag.vim'})
" Ack - a faster grep
" call add(scripts, {'name': 'github:mileszs/ack.vim'})
" Mercurial wrapper for vim
" call add(scripts, {'name': 'github:ludovicchabant/vim-lawrencium'})
" Open files with ease
" call add(scripts, {'name': 'github:kien/ctrlp.vim'})
" Optical helper for CTags
" call add(scripts, {'name': 'github:majutsushi/tagbar'})
" Align stuff
" call add(scripts, {'name': 'github:junegunn/vim-easy-align'})
" Omnicomplete but for C++
" call add(scripts, {'name': 'github:vim-scripts/OmniCppComplete'})
" Review patch files direcly in vim
" call add(scripts, {'name': 'github:junkblocker/patchreview-vim'})

" Install the plugins
silent call vam#Scripts(scripts, {'tag_regex': '.*'})
" ---------------------------------------------------------------------------- "

" -------------------------------- Plugin Settings --------------------------- "
" Number toggle
let g:NumberToggleTrigger="<F4>"

" Open Gundo
nnoremap <F5> :GundoToggle<CR>

" Nerdtree
" nmap <F6> :NERDTreeToggle<CR>

" Make split in fugitive always veritcal
set diffopt+=vertical

" Enter BufExplorer
nmap <F7> :BufExplorerVerticalSplit<CR>

" Open vimrc from anywhere
" nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <F9> :sp $MYVIMRC<CR>

" Toggle the Tagbar
"nmap <F8> :TagbarToggle<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1

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

"  MOST OF THIS IS NOT IN USE!
" Language tool
"let g:languagetool_jar='/opt/LanguageTool-2.4.1/languagetool-commandline.jar'

" Easy align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
"vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
"nmap <Leader>a <Plug>(EasyAlign)

" OmniCppComplete
" - required
"set nocp " non vi compatible mode
"filetype plugin on " enable plugins
" - optional
" auto close options when exiting insert mode
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"set completeopt=menu,menuone
" - config
" let OmniCpp_MayCompleteDot = 1      " autocomplete with .
" let OmniCpp_MayCompleteArrow = 1    " autocomplete with ->
" let OmniCpp_MayCompleteScope = 1    " autocomplete with ::
" let OmniCpp_SelectFirstItem = 2     " select first item (but don't insert)
" let OmniCpp_NamespaceSearch = 2     " search namespaces in this and included files
" let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window

" Ctags
" map <ctrl>+F12 to generate ctags for current folder:
" map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
" Make VIMs pwd the same as the directory of the file
"set autochdir
"tags
"set tags=./tags
"set tags+=../tags
"set tags+=../../tags
"set tags+=tags;
" add current directory's generated tags file to available tags
"set tags+=./tags
" Use CtrP with Ctags
"nnoremap <leader>. :CtrlPTag<cr>
" Ignores for CtrlP
"let g:ctrlp_custom_ignore = 'doxygen'

" Latex-Suite
"set grepprg=grep\ -nH\ $*
"let g:tex_flavor='latex'
"set iskeyword+=:
"let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
"let g:Tex_CompileRule_dvi = 'latex --interaction=nonstopmode -shell-escape $*'
"let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
"let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
"let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -shell-escape $*'
"map <Leader>c :update <CR>:silent call Tex_RunLaTeX()<CR>
"autocmd FileType tex :NoMatchParen " Avoid VIM becoming painfully slow
"au FileType tex setlocal nocursorline " Avoid VIM becoming painfully slow
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
set nu
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

" Toggle function to show unwanted whitespaces
let g:tws = 0
function! ToggleWS()
        if g:tws
                :match
                let g:tws = 0
        else
                :match ExtraWhitespace /\s\+$/
                let g:tws = 1
        endif
endfunction
" ---------------------------------------------------------------------------- "

" ------------------------------ Keybindings -------------------------------- "
" Make j and k move down/up through every line even if it is wrapped
" Hint: Use `gq` to format lines to fit 80 characters
nmap j gj
nmap k gk
" Map escape on ;; - Two semicolons are easy to type.
imap ;; <Esc>
" Insert new line above current line
nmap <F2> O<Esc>j
" Insert new line below current line
nmap <F3> o<Esc>k
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
" Toggle whitespace highlight
nmap <leader>w :call ToggleWS()<CR>
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
" Toggle diff mode
nmap <leader>d :windo set diff!<CR>
" Toggle line numbers
nmap <leader>l :setlocal number!<CR>
" Toggle paste mode
nmap <leader>p :set paste!<CR>
" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>
map <C-K> <C-W>k<C-W>
map <C-L> <C-W>l<C-W>
map <C-H> <C-W>h<C-W>
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
