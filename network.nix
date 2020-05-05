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
  };
  networking.wireless.userControlled.enable = true;
  networking.nameservers=["8.8.8.8" "8.8.4.4"];

  networking.useDHCP = false;
  networking.interfaces.wlp107s0.useDHCP = true;
  
  networking.hosts = {
    "127.0.0.1" = ["happyproperty.vm"];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [4000 3000];
    allowPing = false;
  };
  services.openvpn.servers.client.config = openvpnConfig;
  services.openvpn.servers.client.autoStart = false;

}
