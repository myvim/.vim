function CocConfig()
	let g:coc_global_extensions	= ['coc-json', 'coc-explorer', 'coc-diagnostic']

	" coc explorer
	let g:coc_explorer_global_presets={}
	let g:coc_explorer_global_presets['floating']={'position': 'floating','open-action-strategy': 'sourceWindow'}
	let g:coc_explorer_global_presets['simplify']={'file-child-template': '[git] [selection | clip | 1] [indent][icon | 1] [diagnosticError & 1] [filename omitCenter 1]'}
	autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
	nmap <Leader>ed :CocCommand explorer --preset simplify<CR>
	nmap <Leader>ef :CocCommand explorer --preset floating<CR>

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

