{ config, lib, pkgs, ... }:
let
  homeImports = [
    ./i3.nix
    ./files.nix
    ./packages.nix
    ./git.nix
    ./vscode.nix
    ./vim.nix
    ./go.nix
    ./spotifyd.nix
    ./scripts.nix
  ];
in {
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home.stateVersion = "19.09";

  imports = homeImports;
  
  programs.chromium.enable=true;
  
  programs.feh.enable = true;
  
  programs.firefox = {
    enable = true;
  };

}

