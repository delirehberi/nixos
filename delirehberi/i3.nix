{config, lib, pkgs, ...}:
let
  mod = "Mod4";
in {
  home.packages = [
    pkgs.i3blocks
  ];
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        floating = {
          modifier = "Mod1";
        };
        modifier = mod;
        keybindings = lib.mkOptionDefault {
          "${mod}+d"= "exec ~/.rofi-trigger";
	        "${mod}+Return" = "exec alacritty";
          "control+Mod1+l" = "exec \"i3lock-fancy -p\"";
          "${mod}+Shift+q" = "kill";
          "XF86AudioRaiseVolume"  = "exec --no-startup-id pactl set-sink-volume 0 +5% && pkill -RTMIN+10 i3blocks";
          "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume 0 -5% && pkill -RTMIN+10 i3blocks";
          "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute 0 toggle && pkill -RTMIN+10 i3blocks";
#        "XF86AudioPlay" = "";
#        "XF86AudioPause" = "";
#        "XF86AudioNext" = "";
#        "XF86AudioPrev" = "";
        };
        fonts = [ "FontAwesome 10" "Terminus 10" ];
        gaps = {
          inner = 12;
          outer = 15;
          smartBorders = "on";
          smartGaps =true;
        };
        bars = [{
          fonts = [ "FontAwesome 10" "Terminus 10" ];
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3/i3status-rust-bottom.toml}";
          colors = {
            "separator"="#666666";
            "background"="#222222";
            "statusline"="#dddddd";
            "focusedWorkspace"= {background = "#0088CC"; border= "#0088CC"; text="#ffffff"; };
            "activeWorkspace"={background = "#333333"; border="#333333"; text="#ffffff";};
            "inactiveWorkspace"= {background = "#333333"; border="#333333"; text="#888888";};
            "urgentWorkspace" = {background ="#2f343a"; border="#900000"; text="#ffffff";};
          };
        }
        {
          fonts = [ "FontAwesome 10" "Terminus 10"];
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3/i3status-rust.toml}";
          workspaceButtons = false;
          colors = {
            "separator"="#666666";
            "background"="#222222";
            "statusline"="#dddddd";
            "focusedWorkspace"= {background = "#0088CC"; border= "#0088CC"; text="#ffffff"; };
            "activeWorkspace"={background = "#333333"; border="#333333"; text="#ffffff";};
            "inactiveWorkspace"= {background = "#333333"; border="#333333"; text="#888888";};
            "urgentWorkspace" = {background ="#2f343a"; border="#900000"; text="#ffffff";};
          };

        }
        ];
      };
      extraConfig = ''
        exec --no-startup-id "i3-msg 'workspace 1; append_layout ${./i3/workspace-1.json}'"
        exec --no-startup-id "i3-msg 'workspace 2; append_layout ${./i3/workspace-2.json}'"
        '';
    };
  }; 
  programs.rofi.enable = true;
  home.sessionVariables.LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
}
