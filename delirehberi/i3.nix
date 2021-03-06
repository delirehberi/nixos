{config, lib, pkgs, ...}:
let
  mod = "Mod4";
in {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        floating = {
          modifier = "Mod1";
        };
        focus = {
          mouseWarping = false;
          followMouse = false;
        };

          fonts = ["monospace 12"];
        modifier = mod;
        keybindings = lib.mkOptionDefault {
          "${mod}+d"= "exec ~/.rofi-trigger";
          "${mod}+Shift+d" = "exec rofi-web-search";
          "${mod}+Shift+b" = "exec rofi-bluetooth";
	      "${mod}+Return" = "exec alacritty";
          "control+Mod1+l" = "exec \"i3lock -i ~/Wallpapers/desktop.png\"";
          "${mod}+Shift+q" = "kill";
          "XF86AudioRaiseVolume"  = "exec --no-startup-id pactl set-sink-volume 0 +5% && pkill -RTMIN+10 i3blocks";
          "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume 0 -5% && pkill -RTMIN+10 i3blocks";
          "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute 0 toggle && pkill -RTMIN+10 i3blocks";
          "XF86AudioPlay" = "exec cmus-remote -p";
          "XF86AudioPause" = "exec cmus-remote -u";
          "XF86AudioNext" = "exec cmus-remote -n";
          "XF86AudioPrev" = "exec cmus-remote -r";
          "Print" = "exec flameshot gui";
        };
        gaps = {
          inner = 20;
          outer = 30;
          smartBorders = "on";
          #smartGaps =true;
        };
        bars = [{
          position = "bottom";
          fonts = ["monospace 12"];
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
          fonts = ["monospace 12"];
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
        workspace 1 output eDP-1
        workspace 2 output DP-1
        workspace 3 output DP-1
        workspace 4 output DP-1
        exec --no-startup-id "i3-msg 'workspace 1; append_layout ${./i3/workspace-1.json}'"
        exec --no-startup-id "i3-msg 'workspace 3; append_layout ${./i3/workspace-3.json}'"
        exec --no-startup-id "alacritty"
        exec --no-startup-id "alacritty"
        exec --no-startup-id "alacritty"
        exec --no-startup-id "slack"
        exec --no-startup-id "brave"
        '';
    };
  }; 
  programs.rofi.enable = true;
  home.sessionVariables.LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
}
