# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./graphics.nix
      ./sound.nix
      ./tinc.nix
      ./direnv.nix
      ./nix.nix
      ./virtualbox.nix
      ./temporary.nix
      ./local_dovecot.nix
      ./lxd.nix
    ];
  nixpkgs.overlays = [ (import ./packages.nix ) ]; 



  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/5a48ec61-40db-462b-96b0-d7eb7608faee";
      preLVM = true;
    };
  };

  networking.hostName = "niks"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  networking.extraHosts = ''
  '';

  time.timeZone = "Europe/Amsterdam";

  # Urxvtd
  services.urxvtd.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser
                                pkgs.brgenml1lpr
                                pkgs.brgenml1cupswrapper ];
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # rtkit is optional but recommended
  security.rtkit.enable = true;

  security.pki.certificates = [ ''
    ''];

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    binutils
    borgbackup
    git
    htop
    killall
    mailutils 
    man-pages
    pciutils
    tinc
    wget
    vim_config
    fwupd-efi
    efibootmgr
    mesa
    vulkan-tools
    davfs2
  ];

  environment.profileRelativeSessionVariables = {
    EDITOR = [ "vim" ];
  };

  # (/run/current-system/configuration.nix).
  # system.copySystemConfiguration = true;

  system.stateVersion = "22.05"; # Did you read the comment?

  users.users.vikko = {
    isNormalUser = true;
    description = "Victor Azizi";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" ];
    packages = with pkgs; [ doq 
                            gnumake
                            git-lfs
                            libreoffice
                            xorg.xev
                            xorg.xdpyinfo
                            makedepf90 
                            volctl
                            xbindkeys
                            xorg.xmodmap
                            rxvt-unicode
                            pavucontrol
                            owncloud-client
                            oidc-agent
                            networkmanagerapplet
                            feh
                            blueman
                            bc
                            (python311.withPackages(ps: []))
                            sshfs-fuse
                            strace
                            thunderbird
                            unzip
                            imagemagick
                            firefox-esr
                            sshpass
                            gimp
                            conda
                            dig
                            ripgrep
                            tree
                            openssl
                            
                            # Remove when possible
                            google-chrome
                            nomachine-client
                            keepassxc
                            oath-toolkit
                            nvd
                            xfce.xfce4-terminal
                            vscodium
                            kubectl
                            tws
                            gnome.eog
    ];
  };  

  services.cron = {
    enable = true;
    mailto = "vikko";
    systemCronJobs = [
      "@hourly root rsync --delete -aH /home/vikko/.thunderbird/ /home/vikko/local_projects/mail_backup"
      "@hourly root /home/vikko/ownCloud/bin/_backup.sh"
    ];
  };
  services.postfix.enable = true;

  security.sudo.enable = true;
  security.sudo.extraConfig = ''
  vikko ALL= NOPASSWD: /home/vikko/ownCloud/bin/laptop_brightness.sh
  '';

  services.logind.extraConfig = ''
    HandlePowerKey=hibernate
  '';

  virtualisation.docker.enable = true;

  programs.steam.enable = true;

  services.fwupd.enable = true;

  # Very buggy, takes seconds, but DNS should take microseconds
  # Both of them, use the banhammer to fix DNS lookups
  services.nscd.enableNsncd = false;
  services.nscd.enable = false;
  system.nssModules = lib.mkForce [];

  nix.settings.auto-optimise-store = true;

  programs.xfconf.enable = true;

}
