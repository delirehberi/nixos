{config, lib, pkgs, ...}:
{
  programs.git = {
    enable = true;
    userName = "Emre YILMAZ";
    userEmail = "emreyilmaz@yandex.com";
    aliases = {
      co = "checkout";
      ci = "commit";
      cp = "commit -p";
      s = "status";
      st = "status";
      d = "diff";
      pr = "pull --rebase";
      l = "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
    };
  };
}
