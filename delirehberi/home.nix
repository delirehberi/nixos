{ config, lib, pkgs, ... }:
let
  homeImports = [
    ./i3.nix
    ./files.nix
    ./git.nix
    ./vscode.nix
    ./vim.nix
    ./go.nix
    ./spotifyd.nix
  ];
in {
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home.stateVersion = "19.09";
  imports = homeImports;
  home.packages = with pkgs; [
      htop
      figlet
      php
      php73Packages.composer
      docker-compose
      chromium
      nodejs-12_x
      yarn
      kerberos
      jq
      yad
      xdotool
      font-awesome
      freetype
      rofi
      glibcLocales
      stack
      zlib
      speedtest-cli
      ncurses5
      slack
  ];
  programs.chromium.enable=true;
  programs.go.enable=true;
  programs.autorandr={
    enable = true;
  };
  programs.feh.enable = true;
  programs.firefox = {
    enable = true;
  };
}

