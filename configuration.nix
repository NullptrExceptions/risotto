{ config, pkgs, ... }:

let
in {
    imports = [
        ./hardware-configuration.nix
    ];

    #Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    #Networking
    networking.hostName = "nixos"; # Define your hostname.
    networking.networkmanager.enable = true;

    #Locales
    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    #Users
    users.users.USER = {
        isNormalUser = true;
        description = "USER";
        extraGroups = [ "networkmanager" "wheel" "audio" ];
    };

    users.defaultUserShell = pkgs.zsh;

    #Programs
    nixpkgs.config = {
        allowUnfree = true;
        pulseaudio = true;
    };

    environment.systemPackages = with pkgs; [
        foot
        neofetch

        wbg
        tofi
        pamixer
        pavucontrol
        playerctl
        lxqt.lxqt-policykit
        wl-color-picker

        curl
        wget
        git
        libgcc
        gccgo
        python3
        gnumake
        
        discord

        libinput
        libdrm
        wayland
        wlroots
        libxkbcommon
        wayland-protocols
        pkg-config
        xorg.libxcb
        xorg.xcbutilwm
        xwayland
        pixman
        tllist
        fcft
    ];

    programs.zsh = {
        enable = true;
    };

    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };

    programs.firefox = {
        enable = true;
    };

    #Fonts
    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        noto-fonts-color-emoji
    ];

    #Virtualisation
    virtualisation.libvirtd = {
        enable = true;
    };
    programs.virt-manager = {
        enable = true;
    };

    #Security
    security.polkit = {
        enable = true;
    };

    #Nvidia
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    #Audio
    hardware.pulseaudio = {
        enable = true;
        support32Bit = true;
        package = pkgs.pulseaudioFull;
    };

    #Bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    #Don't change -- Nix internal stuff
    system.stateVersion = "23.11";
}
