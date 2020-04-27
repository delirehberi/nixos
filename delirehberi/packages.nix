{config,lib,pkgs,...}:

{
  home.packages = with pkgs; [
      htop
      figlet
      php
      php73Packages.composer
      chromium
      nodejs-12_x
      yarn
      kerberos
      jq
      yad
      rofi
      glibcLocales
      speedtest-cli
      slack
      solaar
      spotify
      flameshot
  ];
}
