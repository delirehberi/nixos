{config, lib, pkgs, builtins, ...}:

{
  programs.vim ={
    enable=true;
    settings = {
      mouse = "a";
      number = true;
      shiftwidth = 2;
      smartcase = true;
      tabstop = 2;

    };
    extraConfig = ''
        syntax on
        filetype plugin indent on
        set expandtab
        set autoindent
        set smartindent
        set paste
        colo molokai
        let mapleader = ","
    '';
    plugins = with pkgs; [vimPlugins.surround vimPlugins.vim-wakatime vimPlugins.vim-nix vimPlugins.molokai vimPlugins.nerdtree vimPlugins.emmet-vim vimPlugins.ctrlp ];
  };
}
