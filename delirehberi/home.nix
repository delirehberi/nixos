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
  home.stateVersion = "20.03";

  imports = homeImports;
  
  programs.chromium.enable=true;
  
  programs.feh.enable = true;
  
  programs.firefox = {
    enable = true;
  };
  home.keyboard.layout = "tr";
  xsession.pointerCursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 128;
  };
}

