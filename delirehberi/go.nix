{config, lib, pkgs, ...}:

{
  programs.go = {
    enable = true;
    goPath = "go";
  };
}
