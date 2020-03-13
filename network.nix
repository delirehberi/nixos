{config,lib,pkgs,...}:

{
  networking.hostName = "home.emre.xyz"; 
  networking.wireless.enable = true;
  networking.wireless.networks = {
    "FiberHGW_TP7CA6_2.4GHz"= {
      psk = import ./wireless.secret.nix;
    };
  };
  networking.wireless.userControlled.enable = true;

  networking.useDHCP = false;
  networking.interfaces.wlp107s0.useDHCP = true;
  networking.hosts = {
    "127.0.0.1" = ["happyproperty.vm"];
  };

}
