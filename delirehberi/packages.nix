{config,lib,pkgs,...}:

{
  home.packages = with pkgs; [
      htop
      figlet
      php74
      php74Packages.composer
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
      i3lock-fancy
  ];
}
