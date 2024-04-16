{ config, pkgs, virtualbox_pin, ... }:

{
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "vikko" ];
  nixpkgs.config.allowUnfree = true;

  virtualisation.lxd.enable = true;
  users.users.vikko.extraGroups = [ "lxd" ];
}
