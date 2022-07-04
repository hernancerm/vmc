" vim:fileencoding=utf-8:foldmethod=marker:tw=80:comments+=\:"

" Basic settings {{{
" --------------

" Don't try to be Vi compatible.
set nocompatible

" Use unicode encoding.
set encoding=utf-8

" Disable swap files.
set noswapfile

" Show line numbers and jump numbers.
set number relativenumber

" Disable the annoying bell.
set belloff=all
set vb t_vb=

" Allow backspace to work before insert point.
set backspace=indent,eol,start

" Go to matching text while searching.
set incsearch
" Search case insensitive when search pattern only has lowercase letters. When
" an uppercase letter is put in the pattern, search case sensitive.
set ignorecase smartcase

" Provide context lines above and below cursor.
set scrolloff=2

" Insert spaces insteads of tabs.
set expandtab
" Amount of spaces to use to display and insert a tab character. Think of this
" setting as the 'size of the tab', either when it's expaned into spaces and
" when an actual tab character is placed.
set tabstop=2
" Preserve the indentin of the current line when creating new lines, and mind
" the syntax of the current language when deciding to perfom some auto
" indentation.  Notice that 'shiftwidth=0' makes auto indenting use the size
" defined by 'tabstop'.
set autoindent
set smartindent
set shiftwidth=0

" Create window splits in more comfortable positions.
set splitright splitbelow

" Use PowerShell as the shell.
set shell=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe

" Keep colorcolumn always one unit greater than textwidth.
set colorcolumn=+1

" Enable mouse interaction.
set mouse=a

" Soft wrap utility functions.
function! EnableSoftWrap()
  setlocal wrap linebreak
  nnoremap 0 g0
  nnoremap $ g$
  nnoremap g0 0
  nnoremap g$ $
  nnoremap j gj
  nnoremap k gk
endfunction
function! DisableSoftWrap()
  setlocal nowrap
  nnoremap 0 0
  nnoremap $ $
  nnoremap g0 g0
  nnoremap g$ g$
  nnoremap j j
  nnoremap k k
endfunction
function! ToggleSoftWrap()
  if &wrap
    call DisableSoftWrap()
    echo "Soft wrap OFF"
  else
    " Supposedly 'nolist' is required, but it's working fine without it.
    call EnableSoftWrap()
    echo "Soft wrap ON"
  endif
endfunction

" Execute an ex mode command on buffer first enter.
function! ExecCmdOnBufFirstEnter(command)
  if !exists('b:bufHasBeenEntered')
    let b:bufHasBeenEntered = 1
    execute a:command
  endif
endfunction

augroup BasicSettings
  au!
  " Default to no soft wrap on every new buffer.
  au BufEnter * call ExecCmdOnBufFirstEnter(":call DisableSoftWrap()")
augroup END

" }}}

" Basic remappings {{{
" ----------------

" Spacebar as mapleader.
nnoremap <Leader> <Nop>
let mapleader=" "

" By default, yank/paste/delete using the OS clipboard.
nnoremap y "+y
nnoremap Y "+Y
vnoremap y "+y
nnoremap p "+p
nnoremap P "+P
vnoremap p "+p
nnoremap d "+d
nnoremap D "+D
vnoremap d "+d
" Allow normal use of yank/paste/delete by prefixing space.
nnoremap <Leader>y y
nnoremap <Leader>Y Y
vnoremap <Leader>y y
nnoremap <Leader>p p
nnoremap <Leader>P P
vnoremap <Leader>p p
nnoremap <Leader>d d
nnoremap <Leader>D D
vnoremap <Leader>d d

" Enter block visual mode easily.
nnoremap Q <C-q>

" Use Y to yank up to the end of the line.
nnoremap Y yg_

" More comfortable scrolling.
nnoremap <C-u> 8<C-u>
nnoremap <C-d> 8<C-d>

" Move lines up or down.
vnoremap <C-k> :m '<-2<CR>gv
nnoremap <C-k> :m .-2<CR>
vnoremap <C-j> :m '>+1<CR>gv
nnoremap <C-j> :m .+1<CR>

function! InvokeCrNormalMode()
  " Buffers in which CR behaves normally.
  let l:normalCrBuffers = {
    \ '[Command Line]': '',
  \}
  if has_key(l:normalCrBuffers, bufname('%'))
    exe "normal! \<CR>"
  else
    exe "normal! v\<ESC>o\<ESC>gv\<ESC>"
  endif
endfunction

" Add empty line below/above cursor with Enter/<Leader>Enter
nnoremap <CR> :call InvokeCrNormalMode()<CR>
nnoremap <Leader><CR> v<ESC>O<ESC>gv<ESC>
vnoremap <CR> <ESC>'>o<ESC>gv
vnoremap <Leader><CR> <ESC>'<O<ESC>gv

" Delete current line without leaving normal mode.
nnoremap <BS> :s/.*//<CR>

" Break line at cursor position using <Leader>+s.
nnoremap <Leader>s i<CR><ESC>

" Select all contents in the file.
nnoremap <Leader>a ggVG

" Keep flags when repeating last substitution.
nnoremap & :&&<CR>

" More comfy scrolling through search matches.
nnoremap <silent> n mz`z:set hlsearch<CR>nzz
nnoremap <silent> N mz`z:set hlsearch<CR>Nzz

" Make asterisk load a search pattern rather than jump to next match.
nnoremap <silent> * mz`z"zyiw/\C\<<C-r>z\><CR>``:set hlsearch<CR>
vnoremap <silent> * mz`z"zy/<C-r>z<CR>``:set hlsearch<CR>

" Toggle soft wrap easily.
nnoremap <Leader>w <Cmd>call ToggleSoftWrap()<CR>

" Cancel search highlight (same as <C-l>).
nnoremap <silent> <Leader>k :set nohlsearch<CR>:redraw<CR>

" }}}

" GUI-only settings {{{
" -----------------
" Easily resize the guifont.

if has("gui_running")

  " GUI font and line spacing.
  set guifont=Iosevka\ NF:h10
  set linespace=4

  " Window initial size.
  set lines=25
  set columns=120

  " Remove toolbar and menubar.
  set guioptions-=T
  set guioptions-=m

  " Remove scroll bars.
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set guioptions-=b

  nnoremap <F9> :call FontSizeMinus()<CR>
  nnoremap <F10> :call FontSizePlus()<CR>
endif

" Credit goes to: https://vi.stackexchange.com/a/3104
if has("gui_gtk2")
  function! FontSizePlus ()
    let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole + 1
    let l:new_font_size = ' '.l:gf_size_whole
    let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
  endfunction
  function! FontSizeMinus ()
    let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole - 1
    let l:new_font_size = ' '.l:gf_size_whole
    let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
  endfunction
else
  function! FontSizePlus ()
    let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole + 1
    let l:new_font_size = ':h'.l:gf_size_whole
    let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
  endfunction
  function! FontSizeMinus ()
    let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole - 1
    let l:new_font_size = ':h'.l:gf_size_whole
    let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
  endfunction
endif

" }}}

" Colors & looks {{{
" --------------

" Enably syntax highlight.
syntax on

" Display line bleeding indicator on disabled soft wrap.
set list listchars=extends:>,precedes:<

" Set default color schemes.
if has("gui_running")
  " For the integrated gVim terminal, use 'darkblue'.
  colorscheme zellner
else
  " Best built-in color scheme for PowerShell.
  colorscheme industry
endif

" }}}

