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

command GoInstall :call GoInstall()

function CocConfig()
	let g:coc_global_extensions	= ['coc-json', 'coc-explorer', 'coc-diagnostic']

	" coc explorer
	let g:coc_explorer_global_presets={}
	let g:coc_explorer_global_presets['floating']={'position': 'floating','open-action-strategy': 'sourceWindow'}
	let g:coc_explorer_global_presets['simplify']={'file-child-template': '[git] [selection | clip | 1] [indent][icon | 1] [diagnosticError & 1] [filename omitCenter 1]'}
	autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
	nmap <Leader>ed :CocCommand explorer --preset simplify<CR>
	nmap <Leader>ef :CocCommand explorer --preset floating<CR>

	" coc user config
	let g:coc_user_config = {}
	" coclist explorer
	let g:coc_user_config['explorer.icon.enableNerdfont'] = v:true
	let g:coc_user_config['explorer.keyMappings'] = {"<cr>": ["expandable?", ["expanded?", "collapse", "expand"], "open"]}

	let g:coc_user_config['diagnostic-languageserver.filetypes'] = { 'go': "golangci-lint" }
	let g:coc_user_config['diagnostic-languageserver.formatters'] = { 'goreturns': { "command": "goreturns" } }
	let g:coc_user_config['diagnostic-languageserver.formatFiletypes'] = { 'go': "goreturns" }
	let g:coc_user_config['coc.preferences.formatOnSaveFiletypes'] = [ 'go' ]
	" coc languageserver golang
	let g:coc_user_config['languageserver'] = {'golang':{}}
	let g:coc_user_config['languageserver']['golang']={}
	let g:coc_user_config['languageserver']['golang']['command']='gopls'
	let g:coc_user_config['languageserver']['golang']['rootPatterns']=["go.mod", ".vim/", ".git/", ".hg/"]
	let g:coc_user_config['languageserver']['golang']['filetypes']=["go"]
	let g:coc_user_config['languageserver']['golang']['initializationOptions']={"completeUnimported": v:true}

	"TextEdit might fail if hidden is not set.
	set hidden
	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
	" delays and poor user experience.
	set updatetime=300
	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	set signcolumn=yes

	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()

	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
	" position. Coc only does snippet and additional edit on confirm.
	" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
	if exists('*complete_info')
		inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
	else
		inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	endif

	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)
	" Use D to show documentation in preview window.
	nnoremap <silent> D :call <SID>show_documentation()<CR>
	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction
	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')
	augroup mygroup
		autocmd!
		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Mappings using CoCList:
	" Show all diagnostics.
	nnoremap <silent> <Leader>el  :<C-u>CocList diagnostics<cr>
	" Manage extensions.
	nnoremap <silent> <Leader>ce  :<C-u>CocList extensions<cr>
	" Find symbol of current document.
	nnoremap <silent> <Leader>ff  :<C-u>CocList outline<cr>
endfunction

