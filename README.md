# MyVimRC

* require `Git`

### Install
```
> cd $HOME
> git clone https://github.com/myvim/.vim
```
after clone, if windows
```
PowerShell> link $HOME\.vim\vimrc _vimrc
```
open vim, type:
```
:ExUpdate
```
to install plugins

### Common Functions

```
:ExUpdate             :     Load and Update Extends
:ExLoad               :     Load Extends
:Config               :     Edit vimrc
:RlConfig             :     Reload vimrc
:Tree                 :     Toggle File Explorer Tree
:ToggleMenu           :     Toggle GUI Vim Title/Menu

F5                    :     eq `:Tree`
F11                   :     eq `:ToggleMenu`
F12                   :     eq `:Config`
```
