{ ... }:
{
  # This service just hangs, not sure what it does
  systemd.services.NetworkManager-wait-online.enable = false; 

  # alder lake panel self refresh is borked for dual screen
  boot.kernelParams = [ "i915.enable_psr=0" ];
}
