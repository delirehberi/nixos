{config, lib,pkgs, ...}:

let
  rofiBluetooth = pkgs.writeScriptBin "rofi-bluetooth" (builtins.readFile ./rofi/rofi-bluetooth.sh);
  rofiWebSearch =  pkgs.writeScriptBin "rofi-web-search" (builtins.readFile ./rofi/web-search.sh);
in {
  home.packages = [
    rofiBluetooth
    rofiWebSearch
  ];
}
