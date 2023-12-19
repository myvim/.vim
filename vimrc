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

let $vim_home_dir = $HOME.'/.vim'
let $vim_sys_dir = $VIM.'/.vim'

let $vim_cfg_dir = $VIM_HOME
if !isdirectory($vim_cfg_dir) && isdirectory($vim_home_dir)
  let $vim_cfg_dir = $vim_home_dir
end
if !isdirectory($vim_cfg_dir) && isdirectory($vim_sys_dir)
  let $vim_cfg_dir = $vim_sys_dir
end
let $vimrc_path = $MYVIMRC
if !filereadable($vimrc_path)
  let $vimrc_path = $vim_cfg_dir.'/vimrc'
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

func! ToggleBg()
  if &bg == 'light'
    set bg=dark
  elseif &bg == 'dark'
    set bg=light
  end
endf
command! ToggleBg call ToggleBg()
map <silent> <F10> :ToggleBg<CR>

" <Extends>

let g:plugged_path = $vim_cfg_dir.'/plugged'
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
  for $rc in split(globpath(a:path, '**'), '\n')
    if !(matchend($rc, a:filter) == strlen($rc) && filereadable($rc))
      continue
    end
    try
      source $rc
    catch
      echo 'load `'.$rc.'` failed'
    endtry
  endfor
endf

func! LocalConfig()
  "vim-one true color support
  if (empty($TMUX))
    if (has("nvim"))
      "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
      let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
      set termguicolors
    endif
  endif

  if $VIM_BG_DARK != ''
    set bg=dark
  else
    set bg=light
  endif

  colorscheme one

  highlight Cursor guifg=white guibg=steelblue
  set guicursor=n-v-c:block-Cursor

  command! Tree :NERDTreeToggle
  map <silent> <F5> <ESC>:Tree<CR>
  map! <silent> <F5> <F5>

  let g:NERDTreeGitStatusIndicatorMapCustom = {
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
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}

  let $plug_reg = '.plug$'
  call LoadRcs($vim_cfg_dir.'/configs', $plug_reg)
  call LoadRcs($vim_cfg_dir.'/configs.local', $plug_reg)

  call plug#end()

  if a:needUpdate
    :PlugUpdate
  end

  call LocalConfig()

  let $vim_reg = '.vim$'
  call LoadRcs($vim_cfg_dir.'/configs', $vim_reg)
  call LoadRcs($vim_cfg_dir.'/configs.local', $vim_reg)
endf

command! ExLoad call ExtendsLoad(0)
command! ExUpdate call ExtendsLoad(1)

" Load Extends Vim package on init
call ExtendsLoad(0)
