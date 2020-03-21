{config, lib, pkgs, ...}:
let 
	wakatimeKey = builtins.readFile ./wakatimekey.secret.nix;
  spotifydPassword = builtins.readFile ./spotifydpassword.secret.nix;
  bashrc = (builtins.readFile ./bashrc);
  tmux = (builtins.readFile ./tmux);
in {
  home.file = {
    ".profile".text = bashrc;
    ".tmux.conf".text = tmux;
		".wakatime.cfg".text ="
			[settings]
			api_key = ${wakatimeKey}
		";
		".rofi-trigger" = {
			text = "
#!/bin/bash 
#        source ~/.profile
				${pkgs.rofi}/bin/rofi -combi-modi window,drun,run,ssh -theme solarized -font 'hack 10' -show combi -modi combi 
				";
			executable = true;
		};
		".screenlayout-ext.sh"= {
			text = "
#!/bin/bash
				xrandr --output eDP-1 --mode 2560x1440
				xrandr --output DP-1 --auto --primary --right-of eDP-1
				";
			executable = true;
		};
		".screenlayout-laptop.sh" = {
			text = "
#!/bin/bash
				xrandr --output DP-1 --off
				";
			executable = true;
		};
		".config/spotifyd" = {
			text = ''
--username 11129098368 --password ${spotifydPassword}  --device_name nixos
'';
		};
	};
}
