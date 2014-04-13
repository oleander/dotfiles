set guioptions-=T " hide toolbar
set lines=55 columns=100

" Removing scrollbar
set guifont=Monaco:h20
set gcr=n:blinkon0
set gcr=i:blinkon0
au InsertLeave * hi Cursor guibg=#9B1D0D
au InsertEnter * hi Cursor guibg=#BAF57C

set guioptions-=r

if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  imap <D-t> <Esc>:CtrlPMixed<CR>
  map <D-t> :CtrlPMixed<CR>
  :noremap <D-A-right> :tabnext<cr>
  :noremap <D-A-left> :tabprevious<cr> 
end
