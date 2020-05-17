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
  vim-snippets = pkgs.vimUtils.buildVimPlugin {
    name="vim-snippets";
    src=pkgs.fetchFromGitHub {
      owner="honza";
      repo="vim-snippets";
      rev="5332d404e48d1f90f1dff52f0c8fa53161612b9d";
      sha256="15xg7diz5jav1m0dc8pjsl4rmy6x4a2aay43m8ks2zwb7vxwxh5s";
    };
  };
in {
  programs.neovim = {
    enable= true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set hidden
      set nobackup
      set nowritebackup
      set timeoutlen=1000 
      set ttimeoutlen=0

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
      set wildmenu
      set clipboard=unnamedplus
      set guioptions+=a

      autocmd InsertLeave * update

      let g:loaded_matchparen=1

      "custom maps
      nmap <leader>w :w<cr>
      nmap <leader>ga :!git add %<cr>
      nmap <silent> ? :nohl<cr>
      nnoremap gf :vertical wincmd f<CR>

      "tabs
      map <C-t><up> :tabr<cr>
      map <C-t><down> :tabl<cr>
      map <C-t><left> :tabp<cr>
      map <C-t><right> :tabn<cr>

      map <C-q> :bd<cr>

      set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
      set wildignore+=*.pdf,*.psd
      set wildignore+=node_modules/*,bower_components/*
      set wildignore+=var/cache/*,var/log/*


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


      " move tabs
      nnoremap <C-Left> :tabprevious<CR>
      nnoremap <C-Right> :tabnext<CR>
      " Remap for do codeAction of selected region
      function! s:cocActionsOpenFromSelected(type) abort
      execute 'CocCommand actions.open ' . a:type
      endfunction
      xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
      nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

      inoremap jj <Esc>

    '';
    plugins = with pkgs.vimPlugins; [surround  vim-nix molokai emmet-vim coc-nvim haskell-vim hoogle vim-twig php-getter-setter ultisnips vim-snippets];
  };
}
