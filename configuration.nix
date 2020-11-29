{ config, pkgs,lib,callPackage, ... }:
let 
  bahriyeApp = import /home/delirehberi/www/bahriye {inherit pkgs;};
in
  {
    imports =
      [ 
        ./hardware-configuration.nix
        ./packages.nix
        ./xserver.nix
        ./boot.nix
        ./network.nix
        <home-manager/nixos>
      ];
      environment.etc."docker/daemon.json"= {
        text=''{
          "dns": ["10.0.0.2", "8.8.8.8"]
          }'';
        };
      #console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
      console.font = "Lat2-Terminus11";
      console.keyMap = "trq";

      i18n={
        defaultLocale = "en_US.UTF-8";
      };

      time.timeZone = "Europe/Istanbul";

      services.blueman.enable = true;
      services.clamav.daemon.enable = true;
      services.clamav.updater.enable = true;

      fonts = {
        enableFontDir = true;
        enableGhostscriptFonts = true;
        fonts = with pkgs; [
          terminus_font
          source-code-pro
          ubuntu_font_family
          inconsolata
          fira-mono
          font-awesome-ttf
        ];
      };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  services.gnome3.gnome-keyring.enable=true;

  programs.tmux.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.virtualbox ={
    host = {
      enable = true;
    };
  };

  sound.enable = true;
  sound.mediaKeys.enable = true;

  users.users.delirehberi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  home-manager.users.delirehberi = import ./delirehberi/home.nix;

  nix ={
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://all-hies.cachix.org"
    ];
    trustedUsers = [ "root" "delirehberi" ];
    #gc.automatic = true;
    optimise.automatic = true;
    autoOptimiseStore = true;
  };

  programs.vim.defaultEditor = true;
  programs.bash.shellAliases = {
    cat="${pkgs.bat}/bin/bat";
  };
  programs.bash.interactiveShellInit = ''
   if command -v ${pkgs.tmux}/bin/tmux &> /dev/null && [ -z "$TMUX" ]; then
     ${pkgs.tmux}/bin/tmux new
   fi
  '';
  services.redshift = {
    enable = false;
    brightness =  {
      day = "1";
      night = "0.5";
    };
  };
  location = {
    # Ankara City
    latitude = 39.925533;
    longitude = 32.866287;
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      #"*/30 * * * * root speedtest --json > /home/delirehberi/speedtest-result/$(date|tr -d '\ +:-')\".st\""
    ];
  };
  systemd.user.services = {
    dunst = {
      script = "${pkgs.dunst}/bin/dunst";
    };
    bahriye = {
      enable = true;
      after  = ["network.target" "sound.target"];
      wantedBy = ["default.target"];
      script = "${bahriyeApp}/bin/bahriye";
      serviceConfig = {
        "Restart" = "always";
        "RestartSec"= 5;
      };
    };
  };
  system.stateVersion = "20.09"; # Did you read the comment?
}

