{ config, pkgs, ... }:
let 
  spotifydConfig = import /home/delirehberi/.config/spotifyd;
  openvpnConfig = builtins.readFile /home/delirehberi/emre.ovpn;
in 
  {
    imports =
      [ 
        ./hardware-configuration.nix
        ./xserver.nix
        ./boot.nix
        ./network.nix
      ];


      i18n = {
        consoleFont = "Lat2-Terminus16";
        consoleKeyMap = "trq";
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
  environment.systemPackages = with pkgs; [
    wget git cachix alacritty spotifyd playerctl gnome3.nautilus gnome3.sushi bashmount ntfs3g xclip lastpass-cli gnumake obs-studio lxqt.pavucontrol-qt shutter powerline-rs
  ];

  programs.tmux.enable = true;
  virtualisation.docker.enable = true;

  sound.enable = true;

  users.users.delirehberi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  nix ={
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://all-hies.cachix.org"
    ];
    trustedUsers = [ "root" "delirehberi" ];
    gc.automatic = true;
    optimise.automatic = true;
    autoOptimiseStore = true;
  };

  programs.vim.defaultEditor = true;
  programs.bash.interactiveShellInit = ''
   if command -v ${pkgs.tmux}/bin/tmux &> /dev/null && [ -z "$TMUX" ]; then
     ${pkgs.tmux}/bin/tmux new
   fi
  '';
  services.openvpn.servers.client.config = openvpnConfig;
  services.openvpn.servers.client.autoStart = true;
  system.stateVersion = "19.09"; # Did you read the comment?
}

