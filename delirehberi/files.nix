{config, lib, pkgs, ...}:
let 
  bashrc = (builtins.readFile ./bashrc);
  tmux = (builtins.readFile ./tmux);
  gruvbox = (builtins.readFile ./vifm/gruvbox.vifm);
  vifmrc = (builtins.readFile ./vifm/vifmrc);
  comptonconf = (builtins.readFile ./compton.conf);
  sshconf = (builtins.readFile ./ssh.conf);
  dunstrc = (builtins.readFile ./dunstrc);
in {
  home.file = {
    ".config/compton.conf".text=comptonconf;
    ".config/dunst/dunstrc".text=dunstrc;
    ".profile".text = bashrc;
    ".tmux.conf".text = tmux;
    ".ssh/config".text = sshconf;
    ".vifm/vifmrc".text=vifmrc;
	  ".rofi-trigger" = {
			text = "
#!/bin/bash 
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
	};
}
