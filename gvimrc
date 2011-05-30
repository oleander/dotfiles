set guioptions-=T " hide toolbar
set lines=55 columns=100

colorscheme sunburst

" Removing scrollbar
set guifont=Monaco:h14
set gcr=n:blinkon0
set gcr=i:blinkon0
au InsertLeave * hi Cursor guibg=#9B1D0D
au InsertEnter * hi Cursor guibg=#BAF57C

set guioptions-=r
