{config, lib, pkgs, builtins, ...}:
let
  php-getter-setter = pkgs.vimUtils.buildVimPlugin {
    name="php-getter-setter";
    src=pkgs.fetchFromGitHub {
      owner="docteurklein";
      repo="php-getter-setter.vim";
      rev="e4eea8b3297ee9361d81475d5711af59a85cbdf9";
      sha256="1nmqyrd6bqnpqrhzyi69h4v61b179jwcmsz3zis31bj3sbrqfcmm";
    };
  };
in {
  programs.neovim = {
    enable= true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      let mapleader=","
      syntax on
      filetype plugin indent on
      set expandtab
      set autoindent
      set smartindent
      colo molokai
      set cmdheight=2
      set updatetime=300
      set shortmess+=c
      set signcolumn=yes
      set bs=2
      set shiftwidth=2
      set tabstop=2
      set cursorline
      set ruler
      set number
      set linebreak
      set showbreak=+++
      set spell
      set ignorecase
      set wrap
      set foldmethod=indent

      let g:loaded_matchparen=1

      "custom maps
      nmap <leader>w :w<cr>
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
    plugins = with pkgs.vimPlugins; [surround  vim-nix molokai nerdtree emmet-vim ctrlp coc-nvim 	nerdtree-git-plugin  haskell-vim hoogle vim-twig php-getter-setter ultisnips];
  };
}
