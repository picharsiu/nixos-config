{

home.file.".config/waybar/config".text = ''

{
  "layer": "top", // Waybar at top layer
  // "mode": "overlay",
  // "position": "bottom", // Waybar position (top|bottom|left|right)
  // "position": "right",
  // "position": "left",
  // "output": "eDP-1",
  "height": 32, // Waybar height (to be removed for auto height)
  "margin-top": 0,
  "margin-left": 0,
  "margin-right": 0,
  "margin-bottom": 0,
  // "width": 300, // Waybar width
  "spacing": 4, // Gaps between modules (4px)
  // Choose the order of the modules
  "modules-left": [
    "sway/workspaces",
    // "wlr/taskbar",
    "sway/mode",
    "sway/window",
    "mpris"
  ],
  "modules-center": ["custom/notch"],
  "modules-right": [
    "tray",
    "cpu",
    "memory",
    "disk",
    "backlight",
    "pulseaudio",
    "network",
    "battery",
    "clock"
  ],
  // Modules configuration
  "sway/workspaces": {
    "format": "{name} {windows}",
    // "format-window-separator": " | ",
    "window-rewrite-default": "",
    "window-format": "{name}",
    "window-rewrite": {
      "title<.*youtube.*>": "",
      "class<wechat>": "",
      "class<firefox>": "",
      "class<firefox> title<.*github.*>": "",
      "class<firefox> title<.*apple.*music.*>": "",
      "class<firefox> title<.*spotify.*>": "",
      /* "kitty": "<span size='larger' rise='-700'></span>", */
      "kitty": "",
	  }
  },
  "custom/notch": {
    "format": "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "tooltip": false
  },
  "sway/window": {
    "format": "{}",
    "max-length": 60,
    "rewrite": {
      "(.*) — Mozilla Firefox": "$1",
      "(.*) - zsh": "> [$1]"
    }
  },
  "custom/logout": {
    "format": "⏻",
    "tooltip": false,
    "on-click": "niri msg action quit"
  },
  "wlr/taskbar": {
    // "all-outputs": true,
    // "format": "{icon} {title} {short_state}",
    "format": "{icon}",
    "tooltip-format": "{title} | {app_id}",
    "on-click": "activate",
    "on-click-middle": "close",
    "on-click-right": "fullscreen"
  },
  "keyboard-state": {
    "numlock": true,
    "capslock": true,
    "format": "{name} {icon}",
    "format-icons": {
      "locked": "",
      "unlocked": ""
    }
  },
  "sway/mode": {
    "format": "{}"
  },
  "sway/scratchpad": {
    "format": "{icon} {count}",
    "show-empty": false,
    "format-icons": [
      "",
      ""
    ],
    "tooltip": true,
    "tooltip-format": "{app}: {title}"
  },
  "mpd": {
    "format": "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ",
    "format-disconnected": "Disconnected ",
    "format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ",
    "unknown-tag": "N/A",
    "interval": 2,
    "consume-icons": {
      "on": " "
    },
    "random-icons": {
      "off": "<span color=\"#f53c3c\"></span> ",
      "on": " "
    },
    "repeat-icons": {
      "on": " "
    },
    "single-icons": {
      "on": "1 "
    },
    "state-icons": {
      "paused": "",
      "playing": ""
    },
    "tooltip-format": "MPD (connected)",
    "tooltip-format-disconnected": "MPD (disconnected)"
  },
  "idle_inhibitor": {
    "format": "{icon}",
    "format-icons": {
      "activated": "",
      "deactivated": ""
    }
  },
  "tray": {
    // "icon-size": 21,
    "spacing": 10
  },
  "clock": {
    "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
    "format": "{:%e %B %H:%M}"
  },
  "cpu": {
    "format": "{usage}% ",
    "tooltip": false,
  },
  "memory": {
    "format": "{}% <span size='smaller' rise='800'></span>",
    "on-click": "kitty --class tuibtop btop",
  },
  "disk": {
    "interval": 30,
    "format": "{percentage_free}% ",
    "tooltip-format": "{used} used out of {total} ({percentage_used}%)",
    "path": "/",
    "on-click": "kitty --hold --class tuifloat sh -c 'sudo nix-collect-garbage -d && nix-collect-garbage -d && sudo nix store optimise'",
  },
  "temperature": {
    // "thermal-zone": 2,
    // "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
    "critical-threshold": 80,
    // "format-critical": "{temperatureC}°C {icon}",
    "format": "{temperatureC}°C {icon}",
    "format-icons": [
      "",
      "",
      ""
    ]
  },
  "backlight": {
    // "device": "acpi_video1",
    // "format": "{percent}% {icon}",
    "format": "<span rise='700'>{percent}% <span size='120%' rise='-300'>{icon}</span></span>",
    // "format": "<span rise='-2000'><span rise='700'>{percent}%</span> <span size='120%' rise='0'>{icon}</span></span>",
    "format-icons": [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      ""
    ],
    "tooltip" : false,
    "on-scroll-up": "brightnessctl set 1%-",
    "on-scroll-down": "brightnessctl set 1%+"
  },
  "battery": {
    "states": {
      // "good": 95,
      "warning": 30,
      "critical": 15
    },
    "format": "{capacity}% {icon}",
    "format-charging": "{capacity}% ",
    "format-plugged": "{capacity}% ",
    "format-alt": "{time} {icon}",
    // "format-good": "", // An empty format will hide the module
    // "format-full": "",
    "format-icons": [
      "",
      "",
      "",
      "",
      ""
    ]
  },
  "battery#bat2": {
    "bat": "BAT2"
  },
  "network": {
    // "interface": "wlp2*", // (Optional) To force the use of this interface
    "format-wifi": "",
    "format-ethernet": "",
    "tooltip-format": "{ifname} via {gwaddr} ",
    "format-linked": "",
    "format-disconnected": "⚠",
    // "format-alt": "{ifname}: {ipaddr}/{cidr}",
    "on-click": "kitty --class tuifloat sudo nmtui"
  },
  "pulseaudio": {
    // "scroll-step": 1, // %, can be a float
    "format": "{volume}% {icon}",
    "format-bluetooth": "{volume}% {icon}",
    "format-bluetooth-muted": " {icon}",
    "format-muted": "",
    "format-source": "{volume}% ",
    "format-source-muted": "",
    "format-icons": {
      "headphone": "",
      "hands-free": "",
      "headset": "",
      "phone": "",
      "portable": "",
      "car": "",
      "default": [
        "",
        "",
        "",
        "",
        ""
      ]
    },
    "on-click": "kitty --class tuifloat bluetuith",
    "on-scroll-up": "amixer set Master 1%-",
    "on-scroll-down": "amixer set Master 1%+"
  },
  "mpris": {
    "format": "|   {player_icon}  {dynamic}",
    "format-paused": "|   {status_icon}  {dynamic}",
    "dynamic-order": ["title", "artist", "album"],
    // "interval": "1",
    "max-length": 200,
    // "dynamic-separator": "                           ",
    "player-icons": {
      // "default": "▶",
      "default": ""
    },
    "status-icons": {
      "paused": ""
    }
    // "ignored-players": ["firefox"]
  }
}

  '';
}
