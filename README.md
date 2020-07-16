# vim-recently-used

Here comes one of my most frequently used plugins!

This plugin shows a list of recently used files from the current directory when
starting Vim. There is also a simple command `:RecentlyUsed` available to
update the list after changing to another directory with `:cd`.

![screenshot](/screenshot.png)


## Installation

This should be sufficient:

    git clone https://git.entwicklerseite.de/vim-recently-used ~/.vim/pack/coderonline/start/

Or download the zip file and extract it under `~/.vim/pack/coderonline/start/`.

## Installation using plugin managers

### vim-plug

    Plug 'coderonline/vim-recently-used'

### dein.vim

    call dein#add('coderonline/vim-recently-used')


## Design goals

* Keep it really simple
* Make it a one liner

