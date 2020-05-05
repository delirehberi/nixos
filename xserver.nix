{config, lib, pkgs, ...}:

{
  services.xserver = {
    enable = true;
    layout = "tr";
    autorun = true;
    xautolock = {
      enable = true;
      locker = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
      enableNotifier = true;
      notifier = ''${pkgs.libnotify}/bin/notify-send "Locking in 10 seconds" '';
      time = 5;
    };
    displayManager.lightdm = {
      enable = true;
      background = "/home/delirehberi/nixos/delirehberi/desktop.jpg";
      greeters.gtk = {
        theme.package = pkgs.zuki-themes;
        theme.name = "Zukitre";
      };
    };
  };

}
