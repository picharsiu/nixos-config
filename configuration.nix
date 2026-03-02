# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, system, apple-silicon, ... }:

let
  widevine-firefox = import ./pkgs/widevine-firefox/package.nix { inherit (pkgs) lib stdenv callPackage; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./keyboard.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # Specify path to peripheral firmware files.
  # hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  # Or disable extraction and management of them completely.
  # hardware.asahi.extractPeripheralFirmware = false;
  hardware.asahi = {
    enable = true;
    setupAsahiSound = true;
    peripheralFirmwareDirectory = ./firmware;
    # useExperimentalGPUDriver = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://192.168.31.251:7890/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  hardware.bluetooth.enable = true;
  # hardware.bluetooth.powerOnBoot = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      qt6Packages.fcitx5-chinese-addons
      fcitx5-fluent
    ];
  };

  # 启用 Flakes 特性以及配套的全新 nix 命令行工具
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # hardware.alsa.enable = true;
  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
    # enable = true;
    # wireplumber.enable = true;
    # alsa.enable = true;
    # pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.picharsiu = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    packages = with pkgs; [
      tree
    ];
  };

  programs.fish.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    wget
    git
    widevine-firefox
    wl-clipboard-rs
    clipse
    killall
    inputs.nvix.packages.${pkgs.stdenv.hostPlatform.system}.core
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    daed
    inputs.mango.packages.${pkgs.stdenv.hostPlatform.system}.default

  ];

  environment.variables = {
    EDITOR = "nvim";
    QT_IM_MODULE="fcitx";
    XMODIFIERS="@im=fcitx";
  };

  environment.sessionVariables.MOZ_GMP_PATH = [ "${widevine-firefox}/gmp-widevinecdm/system-installed" ];

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  # services.gnome.gnome-keyring.enable = true;

  security.polkit.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      brightnessctl
      alsa-utils
      fuzzel
      polkit_gnome
      dconf
      swaybg
      swayidle
      swaylock-effects
      grim # screenshot functionality
      slurp # screenshot functionality
      mako # notification system developed by swaywm maintainer
    ];
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/picharsiu/nixos-config"; # sets NH_OS_FLAKE variable for you
  };

  #services.v2raya.enable = true;
  systemd.services.daed = {
    after = [ "network-online.target" "docker.service" "systemd-sysctl.service" ];
    wants = [ "network-online.target" ];
    conflicts = [ "dae.service" ];
    serviceConfig = {
      Type = "simple";
      User = "root";
      LimitNPROC = 512;
      LimitNOFILE = 1048576;
      ExecStart = "${pkgs.daed}/bin/daed run -c /etc/daed/";
      Restart = "on-abnormal";
    };
    wantedBy = [ "multi-user.target" ];
  };

  services.gvfs.enable = true;

  services.upower.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --remember-session --time --user-menu --window-padding 2 --sessions ${pkgs.niri}/share/wayland-sessions:${pkgs.sway}/share/wayland-sessions:${inputs.mango.packages.${pkgs.stdenv.hostPlatform.system}.mango}/share/wayland-sessions";
        user = "greeter";
      };
      initial_session = {
        # command = "${pkgs.sway}/bin/sway";
        command = "${inputs.mango.packages.${pkgs.stdenv.hostPlatform.system}.mango}/bin/mango";
        user = "picharsiu";
      };
    };
  };

  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandleLidSwitch= "suspend";
    KillUserProcesses = false;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.openssh.enable = true;
  services.udisks2.enable = true;
  services.playerctld.enable = true;
  # services.v2raya.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  nix.settings = {
    # given the users in this list the right to specify additional substituters via:
    #    1. `nixConfig.substituters` in `flake.nix`
    #    2. command line args `--options substituters http://xxx`
    trusted-users = ["picharsiu"];

    substituters = [
      # cache mirror located in China
      # status: https://mirror.sjtu.edu.cn/
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      # status: https://mirrors.ustc.edu.cn/status/
      # "https://mirrors.ustc.edu.cn/nix-channels/store"

      "https://cache.nixos.org"
    ];

    trusted-public-keys = [
      # the default public key of cache.nixos.org, it's built-in, no need to add it here
      # "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  boot.loader.timeout = 0;
  boot.kernelParams = [ "appledrm.show_notch=1" ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}
