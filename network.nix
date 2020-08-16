{config,lib,pkgs,...}:
let 
  openvpnConfig = builtins.readFile /home/delirehberi/emre2.ovpn;
in 
{
  networking.hostName = "home.emre.xyz"; 
  networking.wireless.enable = true;
  networking.wireless.networks = {
    "FiberHGW_TP7CA6_2.4GHz"= {
      psk = import ./wireless.secret.nix;
    };
    "delirehberiust"={
      psk = import ./wireless.delirehberiust.secret.nix;
    };
  };
  networking.wireless.userControlled.enable = true;
  networking.nameservers=["199.247.4.41"];

  networking.interfaces.wlp107s0.useDHCP = true;
  
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowPing = false;
  };
  services.openvpn.servers.client.config = openvpnConfig;
  services.openvpn.servers.client.autoStart = false;

  networking.hosts = {
    "127.0.0.1" = ["localhost" "dev.7cups.local" "devlite.7cups.local"];
  };

}
