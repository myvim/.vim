# MyVimRC

* require `Git`

### Install

```
> cd $HOME
> git clone https://github.com/myvim/.vim
```
if in *Windows*, need put below text into vim home config file like ```$HOME/_vimrc```
```
:so $HOME/.vim/vimrc
```

### Install Portable

```
> cd $VIM
> git clone https://github.com/myvim/.vim
```
put below text into vim system config file
```
:so $VIM/.vim/vimrc
```

### Extends
command
```
:ExUpdate
```
to install/update extends

### Common Functions

```
:ExUpdate             :     Load and Update Extends
:ExLoad               :     Load Extends
:Config               :     Edit vimrc
:RlConfig             :     Reload vimrc
:Tree                 :     Toggle File Explorer Tree
:ToggleBg             :     Toggle Theme Light/Dark (or set env VIM_BG_DARK=1)
:ToggleMenu           :     Toggle GUI Vim Title/Menu

F5                    :     eq `:Tree`
F11                   :     eq `:ToggleMenu`
F10                   :     eq `:ToggleBg`
F12                   :     eq `:Config`
```
