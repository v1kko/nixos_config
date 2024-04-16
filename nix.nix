{ config, lib, pkgs, ... }:
{
  nix = {
     package = pkgs.nixFlakes;
     extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
       "experimental-features = nix-command flakes";
  };
}
