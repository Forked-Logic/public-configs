{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/user-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";
 
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.gnome.gnome-keyring.enable = true;

  # Nvidia (and Driver) Hell
  services.xserver.videoDrivers = ["nouveau"];
  hardware = {
    nvidia.modesetting.enable = true;
    nvidia.open = true;
    nvidia.nvidiaSettings = true;
    graphics.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Install programs.
  programs = {
     firefox.enable = true;
     steam = {
       enable = true;
       remotePlay.openFirewall = true;
       dedicatedServer.openFirewall = true;
       gamescopeSession.enable = true;
     };
     gamemode.enable = true; # Steam
     hyprland.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
    kitty # Hyprland
    wget
    docker
    python3
    vscode
    protonup-qt # Steam
    discord
    wl-clipboard
    wlogout
    obs-studio    
    btop
    neofetch
    wofi # Hyprland
    xfce.thunar # Hyprland
  ];

  # OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;

  system.stateVersion = "24.11";
}
