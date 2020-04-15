{config, lib, pkgs, builtins, ...}:

{
  programs.neovim = {
    enable= true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      syntax on
      filetype plugin indent on
      set expandtab
      set autoindent
      set smartindent
      colo molokai
      let mapleader=","
      set cmdheight=2
      set updatetime=300
      set shortmess+=c
      set signcolumn=yes
      set bs=2
      set shiftwidth=2
      set cursorline
      set ruler
      set number

"e <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
      " Use `[g` and `]g` to navigate diagnostics
      nmap <silent> [g <Plug>(coc-diagnostic-prev)
      nmap <silent> ]g <Plug>(coc-diagnostic-next)

      " GoTo code navigation.
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      " nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)

      " Use K to show documentation in preview window.
      nnoremap <silent> K :call <SID>show_documentation()<CR>
      nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

      function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
        else
                call CocAction('doHover')
        endif
      endfunction

      " Highlight the symbol and its references when holding the cursor.
      autocmd CursorHold * silent call CocActionAsync('highlight')

      " nerdtree toggle with ctrl+n
      map <C-n> :NERDTreeToggle<CR>

      " move tabs
      nnoremap <C-Left> :tabprevious<CR>
      nnoremap <C-Right> :tabnext<CR>
      " Remap for do codeAction of selected region
      function! s:cocActionsOpenFromSelected(type) abort
      execute 'CocCommand actions.open ' . a:type
      endfunction
      xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
      nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
    '';
    plugins = with pkgs.vimPlugins; [surround  vim-nix molokai nerdtree emmet-vim ctrlp coc-nvim 	nerdtree-git-plugin  haskell-vim hoogle];
  };
}
