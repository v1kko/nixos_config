{ config, pkgs, ... }:

{
  # Enable the Desktop Environment.
  services.xserver = {
    enable = true;
    # videoDrivers = ["intel"];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
      ];
    };
  };
  services.gnome.gnome-remote-desktop.enable = false;

  systemd.services."i3lock" = {
    enable = true;
    description = "i3lock on sleep";
    before = [ "sleep.target" ];
    path = [ pkgs.i3lock ];
    wantedBy = [ "sleep.target" ];
    serviceConfig = {
      Type="forking";
      User= "vikko";
      Environment= [
        "DISPLAY=:0"
        "XAUTHORITY=/run/user/1000/gdm/Xauthority"
      ];
      ExecStart="/usr/bin/env i3lock -c 000000 -f -t";
    };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
    ];
  };
}

