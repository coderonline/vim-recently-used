"=======================================================================================================================
" vim-recently-used
" Shows recently used files from the current directory in a location list
"=======================================================================================================================

" from the list of recent files: make absolute paths, filter out files not
" contained in cwd and finally filter out directories and non-files...
command! RecentlyUsed call setloclist(0, [])
    \  | :lopen
    \  | setlocal nospell
    \  | setlocal signcolumn=yes
    \  | setfiletype qf
    \  | call setloclist(0, [], 'r', {
    \  'title':'Recently used files in directory: '.getcwd(),
    \  'items':sort(map(filter(filter(map(copy(v:oldfiles[:100]),
    \                                    {_, p->fnamemodify(p,':p')}),
    \                                "fnamemodify(v:val, ':h') =~? \'" .
    \                                    getcwd()->fnamemodify(':p:h')->escape(' \')."\'"),
    \                         'filereadable(v:val)'),
    \                  {_, p->{'filename': p,
    \                          'module': printf("%s | %-*s ",
    \                                           strftime("%F %H:%M",
    \                                                    getftime(p)),
    \                                           winwidth(0) - wincol() - 22,
    \                                           fnamemodify(p, ':.')
    \                                          )}}),
    \              {a1, a2 -> a1.module < a2.module})
    \    })

" if we have Vim receiving input from a pipe, this VimEnter command would
" trigger an error. Also when calling Vim with other arguments. In both cases
" we know what we want and that is not the list with recently opened files.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter *
    \ if !exists("s:std_in") && empty(argv())
    \ |     execute ':RecentlyUsed"
    \ |     wincmd w'
    \ | endif
