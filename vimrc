" based on http://github.com/jferris/config_files/blob/master/vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
set history=50 " keep 50 lines of command line history
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set incsearch " do incremental searching
" Clear search 
set nohlsearch

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" Switch wrap off for everything
set nowrap

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Set File type to 'text' for files ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text

  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC

  augroup END

else

  set autoindent " always set autoindenting on

endif " has("autocmd")

" if has("folding")
  " set foldenable
  " set foldmethod=syntax
  " set foldlevel=1
  " set foldnestmax=2
  " set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
" endif

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
set cindent
set smartindent
set autoindent
set shiftwidth=2
set cinkeys=0{,0},:,0#,!,!^F" Always display the status line
set laststatus=2

" , is the leader character
let mapleader = ","

" Edit the README_FOR_APP (makes :R commands work)
map <Leader>R :e doc/README_FOR_APP<CR>

" Leader shortcuts for Rails commands
map <Leader>m :Rmodel 
map <Leader>c :Rcontroller 
map <Leader>v :Rview 
map <Leader>u :Runittest 
map <Leader>f :Rfunctionaltest 
map <Leader>tm :RTmodel 
map <Leader>tc :RTcontroller 
map <Leader>tv :RTview 
map <Leader>tu :RTunittest 
map <Leader>tf :RTfunctionaltest 
map <Leader>sm :RSmodel 
map <Leader>sc :RScontroller 
map <Leader>sv :RSview 
map <Leader>su :RSunittest 
map <Leader>sf :RSfunctionaltest 

" Hide search highlighting


" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" Maps autocomplete to tab
imap <Tab> <C-N>

imap <C-L> <Space>=><Space>

" Display extra whitespace
" set list listchars=tab:»·,trail:·

" Edit routes
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif

" Color scheme
" colorscheme sunburst
" highlight NonText guibg=#060606
" highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" case only matters with mixed case expressions
set ignorecase
set smartcase

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;

let g:fuf_splitPathMatching=1

" Open URL
command -bar -nargs=1 OpenURL :!open <args>
function! OpenURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
    exec "!open \"" . s:uri . "\""
  else
    echo "No URI found in line."
  endif
endfunction
map <Leader>w :call OpenURL()<CR>

" Pathogen
" Needed on some linux distros.
" see http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype off
syntax on
filetype indent on

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.
"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
set dictionary="/usr/share/dict/words"

" Cache files should be saved to tmp
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Make new lines and tabs visible
set list
set listchars=tab:▸\ ,eol:¬

" Map tab in and out to Textmate's key combos
nmap <S-A-Tab> <<
nmap <A-Tab> >>
vmap <S-A-Tab> <gv
vmap <A-Tab> >gv

" Jump to the end and start of a line
nnoremap <S-Right> $
nnoremap <S-Left> ^

" Gist the current file
let g:gist_clip_command = "pbcopy"
nnoremap <Leader>g :Gist -p <Enter>
vnoremap <Leader>g :Gist -p <Enter>

" Removes current word
nnoremap <C-BS> bdw

" Moving down a line
vmap <Leader>z <Leader>c<Space>gv
" It should be possible to use Shift down arrow to select text
if has("gui_macvim")
  let macvim_hig_shift_movement = 1
endif

" Enter + CMD creates a new line and jumps to insert mode
nnoremap <D-Cr> o
inoremap <D-Cr> <ESC>o

" Spell checking
nmap <silent> <leader>s :set spell!<CR>
set spelllang=sv
nnoremap <leader>sv :set spelllang=sv<Cr>
nnoremap <leader>en :set spelllang=en_us<Cr>

" Peepopen
imap <D-t> <Esc><D-t>i

" Makes it possible to auto create tables
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" Autocompleted words should not be shown in a list
set completeopt-=menu

" There should be a file called .tags in the current directory
set tags=./tags;

" Jump to method def using ctags
map <Cr-a> <C-]>
set cscopetag

" vundle configuration
set rtp+=~/.dotfiles/vim/bundle/vundle/ 
call vundle#rc()
Bundle "gmarik/vundle"
Bundle "ShowMarks"
