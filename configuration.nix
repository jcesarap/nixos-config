{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # You can explore manual installation later, via CLI, on a virtual machine on (working Nix) Linux - which runs fast... as mere satttjor with perfect praticality

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "America/Fortaleza";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "thinkpad";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.magn = {
    isNormalUser = true;
    description = "magn";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run: nix search wget
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    vscodium
    gh
    ranger
    jq
    util-linux
    linux
    linuxHeaders
    haveged
    dbus
    wget
    zsh
    timeshift
    kdePackages.sddm
    qt5.qtquickcontrols2
    qt5.qtgraphicaleffects
    qt5.qtsvg
    qt5.qtquickcontrols
    libsForQt5.plasma-framework
    xorg.xorgserver
    xorg.xinit
    xorg.xhost
    xorg.xev
    i3
    ly
    polybar
    dmenu
    i2c-tools
    xorg.xset
    xorg.xrandr
    arandr
    picom
    xorg.xbacklight
    clipnotify
    xclip
    parcellite
    clipmenu
    xdotool
    feh
    xf86_input_wacom
    xarchiver
    atool
    unzip
    audacity
    postgresql
    bc
    python3Packages.pip
    python3Packages.pylatexenc
    git
    github-cli
    gcc
    cmake
    automake
    nodejs
    ripgrep
    pandoc
    cargo
    bison
    rsync
    mediainfo
    meson
    python3
    json_c
    cairo
    glib
    go
    openssh
    ueberzugpp
    python3Packages.pyqt5
    ollama
    xorg.libX11
    xorg.libXrandr
    xorg.libXi
    xorg.libXcursor
    xorg.libXinerama
    iwd
    firewalld
    networkmanager
    yt-dlp
    brightnessctl
    xwayland
    wl-clipboard
    rofi
    rofi-calc
    dunst
    playerctl
    alsa-utils
    alsa-tools
    alsa-lib
    pipewire
    wireplumber
    pavucontrol
    thermald
    neofetch
    acpid
    powertop
    glances
    upower
    lm_sensors
    config.boot.kernelPackages.cpupower
    procps
    protonmail-bridge
    pass
    thunderbird
    blueman
    unzip
    htop
    w3m
    fzf
    findutils
    mlocate
    alacritty
    kitty
    keepassxc
    flameshot
    evince
    gnome-system-monitor
    id3v2
    gnome-disk-utility
    clamtk
    calibre
    gnome-boxes
    xfce.thunar
    android-tools
    lazygit
    micro
    neovim
    vlc
    mpv
    perlPackages.ImageExifTool
    socat
    mpv
    cmus
    speedcrunch
    zathura
    dropbox
    pywal
    i3lock-color
    whitesur-icon-theme
    zathura
    texlive.combined.scheme-full
    mesa
    vulkan-loader
    xorg.xf86videointel
    intel-media-driver
    intel-vaapi-driver
    xdg-utils
    xdg-desktop-portal-gtk
    xdg-user-dirs
    cups
    hplip
    system-config-printer
    fwupd
    iucode-tool
    lxappearance
    dict
    gvfs
    android-file-transfer
    power-profiles-daemon
    ncdu
    lxqt.lxqt-policykit
    imagemagick
    ffmpeg
    gst_all_1.gstreamer
    kdePackages.okular
    gnome-text-editor
    noto-fonts
    noto-fonts-emoji
    noto-fonts-extra
    liberation_ttf
    dejavu_fonts
    roboto
    ubuntu_font_family
    nerd-fonts.ubuntu-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    jetbrains-mono
  ];

  boot.kernelModules = [ "acpi_call" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    acpi_call
  ];

  # ======================= NVIDIA
  # 1. Enable OpenGL support system-wide.
  hardware.graphics.enable = true;

  # 2. Configure NVIDIA driver settings.
  hardware.nvidia = {
    # This enables Kernel Mode Setting (KMS).
    # It's required for a stable experience on Wayland and modern X11.
    modesetting.enable = true;

    # Use the open-source kernel modules. Set this to `false` to use
    # the standard proprietary driver instead.
    open = true;

    # Improves power management, especially for laptops.
    # It allows the GPU to enter lower power states when idle.
    powerManagement.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05";

}
