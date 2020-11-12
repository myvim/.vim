let g:coc_global_extensions += ['coc-go']
function GoInstall()
  if !executable('gopls')
    echo 'Installing go-tools -> gopls..'
    silent exec "!go get golang.org/x/tools/gopls@latest"
    if executable('gopls')
      echo 'Install complete.'
    else
      echoerr 'Install Faild.'
    endif
  endif

  if !executable('goreturns')
    echo 'Installing go-tools -> goreturns..'
    silent exec "!go get github.com/sqs/goreturns"
    if executable('goreturns')
      echo 'Install complete.'
    else
      echoerr 'Install Faild.'
    endif
  endif

  if !executable('golangci-lint')
    echo 'Installing go-tools -> golangci-lint..'
    if has("win32") || has("win32unix")
      let tempfile=tempname().".ps1"
      silent exec "!powershell -NoProfile -Command chcp 65001;Invoke-WebRequest https://raw.githubusercontent.com/geekjam/Scripts/master/golangci-lint.ps1 -OutFile ".tempfile
      silent exec "!powershell -NoProfile -File ".tempfile
    else
      let tempfile=tempname().".sh"
      silent exec "!curl -L -o ".tempfile." https://raw.githubusercontent.com/geekjam/Scripts/master/golangci-lint.sh"
      silent exec "!sh ".tempfile
    endif
    if executable('golangci-lint')
      echo 'Install complete.'
    else
      echoerr 'Install Faild.'
    endif
  endif
endfunction

command! GoInstall :call GoInstall()

let g:go_fmt_command = "goimports"
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>
