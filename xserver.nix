{config, lib, pkgs, ...}:

{
  services.xserver = {
    enable = true;
    layout = "tr";
    autorun = true;
    xautolock.enable = true;
    displayManager.lightdm = {
      enable = true;
      greeters.gtk = {
        theme.package = pkgs.zuki-themes;
        theme.name = "Zukitre";
      };
    };
  };

}
