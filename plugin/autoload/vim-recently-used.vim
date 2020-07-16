"=======================================================================================================================
" MAX_SPLASH:
" Shows recently used files from the current directory in a location list
"=======================================================================================================================

command RecentlyUsed call setloclist(0, [])
    \ | :lopen
    \ | setlocal nospell
    \ | setlocal signcolumn=yes
    \ | setfiletype qf
    \ | call setloclist(0, [], 'r', {
    \ 'title':'Recently used files in directory: '.getcwd(),
    \ 'items':sort(map(filter(filter(map(copy(v:oldfiles[:100]),
    \                                    {_, p->expand(p)}),
    \                                'v:val =~ "'.getcwd().'/"'),
    \                         'filereadable(v:val)'),
    \                  {_, p->{'filename': p,
    \                          'module': printf("%s | %-*s ",
    \                                           strftime("%F %H:%M",
    \                                                    getftime(p)),
    \                                           winwidth(0) - wincol() - 22,
    \                                           fnamemodify(p, ':.')
    \                                          )}}),
    \              {a1, a2 -> a1.module < a2.module})
    \ })

" autocmd VimEnter * call setloclist(0, filter(map(copy(v:oldfiles), {_, p->{'filename': expand(get(split(p, "'"), 0))}}), { val -> echo val}))
" from the list of recent files: make absolute paths, filter out files not
" contained in cwd and finally filter out directories and non-files...
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * 
    \ if !exists("s:std_in") && empty(argv())
    \ |     execute ':RecentlyUsed"
    \ |     wincmd w'
    \ | endif

" http://vimdoc.sourceforge.net/htmldoc/quickfix.html#:caddexpr
" for c in range(char2nr('a'), char2nr('z')) + range(char2nr('A'), char2nr('Z')) +  range(0,9) | let p = getpos("'".nr2char(c)) | if (p[1] > 0) | exec "sign define mark_".nr2char(c)." text=".nr2char(c)." linehl=linenr" | exec "sign place ".c." name=mark_".nr2char(c)." line=".p[1] | endif  | endfor
" for c in range(char2nr('a'), char2nr('z')) + range(char2nr('A'), char2nr('Z')) +  range(0,9) | let p = line("'".nr2char(c)) | if (p > 0) | exec "sign define mark_".nr2char(c)." text=".nr2char(c)." linehl=linenr" | exec "sign place ".c." name=mark_".nr2char(c)." line=".p | endif  | endfor 
" call sign_unplace('marks') | for c in range(char2nr('a'), char2nr('z')) + range(char2nr('A'), char2nr('Z')) +  range(0,9) | let p = line("'".nr2char(c)) | if (p > 0) | call sign_define("mark_".nr2char(c), { "text" : nr2char(c), "linehl": "linenr"}) | call sign_place(c, 'marks', "mark_".nr2char(c), '', {'lnum': p}) | endif  | endfor 
" call sign_unplace('marks') | for c in range(char2nr('a'), char2nr('z')) + range(char2nr('A'), char2nr('Z')) +  range(char2nr('0'), char2nr('9')) | let p = line("'".nr2char(c)) | if (p > 0) | call sign_define("mark_".nr2char(c), { "text" : nr2char(c), "texthl": "linenr"}) | call sign_place(c, 'marks', "mark_".nr2char(c), '', {'lnum': p}) | endif  | endfor 
