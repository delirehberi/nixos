{config,lib,pkgs,...}:
let 
  openvpnConfig = builtins.readFile /home/delirehberi/emre2.ovpn;
in 
  {
    networking.domain = "emre.xyz";
  networking.hostName = "home"; 
  networking.wireless.enable = false;
  networking.wireless.networks = {
    "FiberHGW_TP7CA6_2.4GHz"= {
      psk = import ./wireless.secret.nix;
    };
  };
  networking.wireless.userControlled.enable = true;
  networking.interfaces.enp0s20.useDHCP=false;
  networking.nameservers=["8.8.8.8" "8.8.4.4"];

  networking.interfaces.wlp107s0.useDHCP = true;
  
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [22 8080 3000];
  };
  services.openvpn.servers.client.config = openvpnConfig;
  services.openvpn.servers.client.autoStart = false;
  services.sshd.enable = true;
  networking.hosts = {
    "127.0.0.1" = ["localhost" "dev.7cups.local" "devlite.7cups.local"];
  };

}
