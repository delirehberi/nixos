{config,pkgs,lib, ...}:
let 
  password = builtins.readFile ./spotifydpassword.secret.nix;
  configFile = pkgs.writeText "spotifyd.conf" ''
    [global]
    username = 11129098368
    password = ${password}
    backend = pulseaudio
    device_name = nixos-home

    '';
in {
  home.packages = [pkgs.spotifyd];
  systemd.user.startServices = true;
  systemd.user.services.spotifyd = {
  Unit = {
      Description = "Spotify daemon";
      Documentation = "https://github.com/Spotifyd/spotifyd";
    };
  Install.WantedBy = [ "default.target" ];

  Service = {
      ExecStart = "${pkgs.spotifyd}/bin/spotifyd --no-daemon --config ${configFile}";
      Restarts  = "always";
      RestartSec = 12;
    };
  };
}
