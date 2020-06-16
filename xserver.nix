{config, lib, pkgs, ...}:

{
  services.xserver = {
    synaptics.dev=''/dev/input/event11'';
    synaptics.enable = true; 
    synaptics.additionalOptions = ''
        Option "TapButton1" "1"
        Option "TapButton2" "3"
        Option "TapButton3" "2"
        Option "VertEdgeScroll" "on"
        Option "VertTwoFingerScroll" "on"
        Option "HorizEdgeScroll" "on"
        Option "HorizTwoFingerScroll" "on"
        Option "CircularScrolling" "on"
        Option "CircScrollTrigger" "2"
        Option "EmulateTwoFingerMinZ" "40"
        Option "EmulateTwoFingerMinW" "8"
        Option "CoastingSpeed" "0"
        Option "FingerLow" "30"
        Option "FingerHigh" "50"
        Option "MaxTapTime" "125"
      '';
    enable = true;
    layout = "tr";
    autorun = true;
    xautolock = {
      enable = true;
      locker = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
      enableNotifier = true;
      notifier = ''${pkgs.libnotify}/bin/notify-send "Locking in 10 seconds" '';
      time = 30;
    };
    windowManager.i3.enable=true;
  };

}
