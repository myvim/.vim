" <Setting>

set nocompatible
set nobackup
set noswapfile
set writebackup
set smartindent
set expandtab                                         "Tab=>Space
set tabstop=2                                         "tab width
set shiftwidth=2                                      "tab = 2 space
set smarttab                                          "backspace will delete shiftwidth space
set autochdir
set autoindent

" set list
set backspace=2                                       "BackSpace enable
set spelllang=en_GB.UTF-8                             "Spell Check
set nu                                                "Line Number"

" File Encoding
set encoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set fileformat=unix
set fileformats=unix,dos,mac

" Interface Configure
set laststatus=2                                      " Enable Status Message
set cmdheight=2
set cursorline

" set nowrap
set shortmess=atI                                     "remove welcome-page
set incsearch                                         "vim Realtime-match during search
set hlsearch                                          " HighLight Search result

syntax enable
syntax on

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

language messages zh_CN.utf-8

" <Config>

if has("gui_win32")
  set guifont=Consolas:h10
elseif has("gui_gtk2")
  set guifont=DejaVu\ Sans\ Mono\ 11
end

if has("gui_running")
  colorscheme zellner
else
  colorscheme morning
end

" <Key Mapping>

map <silent> <C-c> "+y<CR>
map! <silent> <C-c> <ESC><C-c>
map <silent> <D-c> <C-c>
map! <silent> <D-c> <ESC><D-c>

map <silent> <C-v> :set paste<CR>"+p<CR>:set nopaste<CR>
map! <silent> <C-v> <ESC><C-v>
map <silent> <D-v> <C-v>
map! <silent> <D-v> <ESC><D-v>

map <silent> <C-x> "+x<CR>
map! <silent> <C-x> <ESC><C-x>
map <silent> <D-x> <C-x>
map! <silent> <D-x> <ESC><D-x>

map <silent> <C-z> u
map! <silent> <C-z> <ESC><C-z>
map <silent> <D-z> <C-z>
map! <silent> <D-z> <ESC><D-z>

map <silent> <C-s> :w!<CR>
map! <silent> <C-s> <ESC><C-s>
map <silent> <D-s> <C-s>
map! <silent> <D-s> <ESC><D-s>

map <silent> <C-a> ggVG
map! <silent> <C-a> <ESC><C-a>
map <silent> <D-a> <C-a>
map! <silent> <D-a> <ESC><D-a>

let $vimrc_path = $MYVIMRC
let g:vim_cfg_dir = expand($HOME.'/.vim/')
if !filereadable($vimrc_path)
  if filereadable($VIM/vimrc)
    let $vimrc_path = $VIM/vimrc
    let g:vim_cfg_dir = expand($VIM.'/.vim/')
  elseif filereadable($VIM/_vimrc)
    let $vimrc_path = $VIM/_vimrc
    let g:vim_cfg_dir = expand($VIM.'/.vim/')
  end
end
command! Config :e $vimrc_path
command! RlConfig :so $vimrc_path

map <silent> <F12> <ESC>:Config<CR>
map! <silent> <F12> <ESC>:Config<CR>

" <Show/Hide Menu Toolbar RollLink>

func! HideMenu()
  set guioptions-=m
  set guioptions-=T
endf
func! ShowMenu()
  set guioptions+=m
  set guioptions+=T
endf
func! ToggleMenu()
  if &guioptions =~# 'm'
    call HideMenu()
  else
    call ShowMenu()
  end
endf
call HideMenu()
command! ToggleMenu call ToggleMenu()
map <silent> <F11> :ToggleMenu<CR>

" <Extends>

let g:plugged_path = expand(g:vim_cfg_dir.'plugged')
func! ExtendsLoad(needUpdate)
  let extends_manager = expand(g:plugged_path.'/vim-plug')
  let $extends_manager_file = extends_manager.'/plug.vim'
  if a:needUpdate && !filereadable($extends_manager_file)
    :execute "!git clone --depth=1 https://github.com/junegunn/vim-plug ".extends_manager
  end
  if filereadable($extends_manager_file)
    source $extends_manager_file

    try
      call OnInit(a:needUpdate)
    catch
    endtry
  end
endf

func! LoadRcs(path, filter)
  for $rc in split(globpath(a:path, a:filter), '\n')
    try
      source $rc
    catch
      echo 'load `'.$rc.'` failed'
    endtry
  endfor
endf

" Extends And Configs Write Here
func! OnInit(needUpdate)
  call plug#begin(g:plugged_path)

  Plug 'junegunn/vim-plug'

  Plug 'rakr/vim-one'
  Plug 'preservim/nerdcommenter'
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'Yggdroot/indentLine'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'terryma/vim-multiple-cursors'

  call LoadRcs(g:vim_cfg_dir.'configs', '*.plug')
  call LoadRcs(g:vim_cfg_dir.'configs.local', '*.plug')

  call plug#end()

  if a:needUpdate
    :PlugUpdate
  end

  set background=light
  colorscheme one

  command! Tree :NERDTreeToggle
  map <silent> <F5> <ESC>:Tree<CR>
  map! <silent> <F5> <F5>

  let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

  call LoadRcs(g:vim_cfg_dir.'configs', '*.vim')
  call LoadRcs(g:vim_cfg_dir.'configs.local', '*.vim')
endf

command! ExLoad call ExtendsLoad(0)
command! ExUpdate call ExtendsLoad(1)

" Load Extends Vim package on init
call ExtendsLoad(0)
