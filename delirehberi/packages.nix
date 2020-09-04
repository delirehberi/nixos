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
      glibcLocales
      speedtest-cli
      slack
      solaar
      flameshot
      i3lock-fancy
  ];
}
