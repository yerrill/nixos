{ config, pkgs, lib, inputs, home-manager, ... }:
let
	cfg = config.hmhyprland;
in {
	imports = [

	];

	options = {
		myHello.enable = lib.mkEnableOption "Enable home-manager hyprland config";	
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [
			pkgs.hello
		];

		wayland.windowManager.hyprland.enable = true;
		wayland.windowManager.hyprland.settings = {
			monitor = [
				"HDMI-A-1,1920x1080@144,0x0,1"
				"DP-1,3840x2160@60,1920x0,2"
			];

			"$terminal" = "kitty";
			"$fileManager" = "dolphin";
			"$menu" = "wofi --show drun";

			env = [
				"XCURSOR_SIZE,24"
				"HYPRCURSOR_SIZE,24"
				# "LIBVA_DRIVER_NAME,nvidia"
				# "XDG_SESSION_TYPE,wayland"
				# "GBM_BACKEND,nvidia-drm"
				# "__GLX_VENDOR_LIBRARY_NAME,nvidia"
			];

			exec-once = [
				"swww init && swww img ~/Wallpapers"
				"nm-applet --indicator"
				"waybar"
				"dunst"
			];

			general = { 
				gaps_in = 5;
				gaps_out = 20;
				border_size = 2;

				# https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
				"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
				"col.inactive_border" = "rgba(595959aa)";

				# Set to true enable resizing windows by clicking and dragging on borders and gaps
				resize_on_border = false;
				# Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
				allow_tearing = false;

				layout = "dwindle";
			};

			# https://wiki.hyprland.org/Configuring/Variables/#animations
			animations = {
				enabled = true;

				# Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
				bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

				animation = [
					"windows, 1, 7, myBezier"
					"windowsOut, 1, 7, default, popin 80%"
					"border, 1, 10, default"
					"borderangle, 1, 8, default"
					"fade, 1, 7, default"
					"workspaces, 1, 6, default"
				];
			};

			# See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more

			dwindle = {
				pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
				preserve_split = true; # You probably want this
			};

			# See https://wiki.hyprland.org/Configuring/Master-Layout/ for more

			master = {
				new_status = "master";
			};

			# https://wiki.hyprland.org/Configuring/Variables/#misc

			misc = {
				force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
				disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
			};

			# https://wiki.hyprland.org/Configuring/Variables/#input
			
			input = {
				kb_layout = "us";
				# kb_variant = ;
				# kb_model = ;
				# kb_options = ;
				# kb_rules = ;
				# follow_mouse = 1 ;

				sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

				touchpad = {
					natural_scroll = false;
				};
			};

			# https://wiki.hyprland.org/Configuring/Variables/#gestures
			
			gestures = {
				workspace_swipe = false;
			};

			# Example per-device config
			# See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
			device = {
				name = "epic-mouse-v1";
				sensitivity = -0.5;
			};

			# See https://wiki.hyprland.org/Configuring/Keywords/
			"$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

			# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
			bind = [
				"$mainMod, Q, exec, $terminal"
				"$mainMod, C, killactive,"
				"$mainMod, M, exit,"
				"$mainMod, E, exec, $fileManager"
				"$mainMod, V, togglefloating,"
				"$mainMod, R, exec, $menu"
				# "$mainMod, P, pseudo," # dwindle
				"$mainMod, J, togglesplit," # dwindle

				# Move focus with mainMod + arrow keys
				"$mainMod, left, movefocus, l"
				"$mainMod, right, movefocus, r"
				"$mainMod, up, movefocus, u"
				"$mainMod, down, movefocus, d"

				# Switch workspaces with mainMod + [0-9]
				"$mainMod, 1, workspace, 1"
				"$mainMod, 2, workspace, 2"
				"$mainMod, 3, workspace, 3"
				"$mainMod, 4, workspace, 4"
				"$mainMod, 5, workspace, 5"
				"$mainMod, 6, workspace, 6"
				"$mainMod, 7, workspace, 7"
				"$mainMod, 8, workspace, 8"
				"$mainMod, 9, workspace, 9"
				"$mainMod, 0, workspace, 10"

				# Move active window to a workspace with mainMod + SHIFT + [0-9]
				"$mainMod SHIFT, 1, movetoworkspace, 1"
				"$mainMod SHIFT, 2, movetoworkspace, 2"
				"$mainMod SHIFT, 3, movetoworkspace, 3"
				"$mainMod SHIFT, 4, movetoworkspace, 4"
				"$mainMod SHIFT, 5, movetoworkspace, 5"
				"$mainMod SHIFT, 6, movetoworkspace, 6"
				"$mainMod SHIFT, 7, movetoworkspace, 7"
				"$mainMod SHIFT, 8, movetoworkspace, 8"
				"$mainMod SHIFT, 9, movetoworkspace, 9"
				"$mainMod SHIFT, 0, movetoworkspace, 10"

				# Example special workspace (scratchpad)
				"$mainMod, S, togglespecialworkspace, magic"
				"$mainMod SHIFT, S, movetoworkspace, special:magic"

				# Scroll through existing workspaces with mainMod + scroll
				"$mainMod, mouse_down, workspace, e+1"
				"$mainMod, mouse_up, workspace, e-1"

				"$mainMod, F, exec, rofi -show drun -show-icons"
				" , Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
			];

			# Move/resize windows with mainMod + LMB/RMB and dragging
			bindm = [
				"$mainMod, mouse:272, movewindow"
				"$mainMod, mouse:273, resizewindow"
			];

			# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
			# See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

			# Example windowrule v1
			# windowrule = float, ^(kitty)$

			# Example windowrule v2
			# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

			windowrulev2 = "suppressevent maximize, class:.*"; # You'll probably like this
		};

		home.pointerCursor = {
			gtk.enable = true;
			# x11.enable = true;
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Classic";
			size = 16;
		};

		gtk = {
			enable = true;

			theme = {
				package = pkgs.flat-remix-gtk;
				name = "Flat-Remix-GTK-Grey-Darkest";
			};

			iconTheme = {
				package = pkgs.adwaita-icon-theme;
				name = "Adwaita";
			};

			font = {
				name = "Sans";
				size = 11;
			};
		};
	};
}

