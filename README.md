# cfrtl.vim
**C**opy **F**rom **R**emote **T**o **L**ocal
Vim copy from ssh remote to loacl clipboard. It work with OSC52/PASTE64.

## Installation
Vim 8+ packages

If you use built-in package management; Just run this command in your terminal:
```
git clone https://github.com/laomafeima/cfrtl.vim ~/.vim/pack/vendor/start/cfrtl.vim
```

[vim-plug](https://github.com/junegunn/vim-plug)
```
Plug 'laomafeima/cfrtl.vim', { 'on': ['CopyLines', 'CopySelected'] }
```

[vim-plug](https://github.com/Shougo/dein.vim)
```
dein#add('laomafeima/cfrtl.vim')
```

## Usage

### :CopyLines
`:CopyLines` It will copy current line text to you clipboard through OSC52/PASTE64.
Type `9:` which display `:.,.+8`, then type `CopyLines`, click enter. The following 9 lines text will be copyed.

### :CopySelected
Copy selected text to you clipboard through OSC52/PASTE64.

### map to Y

Add following code to you `.vimrc` file, Map `Y` to use cfrtl.vim.
when you use vim on local, cfrtl.vim will auto use register `*`. when use ssh remote will through OSC52/PASTE64.
```
autocmd VimEnter * call SetYankMap()
function! SetYankMap()
    if getregtype("*") == ""
        vnoremap Y :CopySelected<cr>
        nnoremap Y :CopyLines<cr>
    else
        vnoremap Y "*y
        nnoremap Y "*yy
    endif
    nnoremap P "*p
endfunction

```


This project is developed on the basis of [greymd/oscyank.vim](https://github.com/greymd/oscyank.vim).
