{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    wpa_supplicant_pin.url = "github:nixos/nixpkgs/a7cc81913bb3cd1ef05ed0ece048b773e1839e51"; # works with eduroam, treasure it
    unstable_pkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # works with eduroam, treasure it
  };
  outputs = { self, nixpkgs, wpa_supplicant_pin, unstable_pkgs }: 
  let
    system = "x86_64-linux";
  in
  let
    #wpa_pkgs = wpa_supplicant_pin.legacyPackages.${system}.pkgs;
    pkgs = nixpkgs.legacyPackages.${system}.pkgs;
  in 
  let 
    my-overlay = final: prev: 
    let
      ignoringVulns = x: x // { meta = (x.meta // { knownVulnerabilities = []; }); };
      openssl_1_1 = prev.openssl_1_1.overrideAttrs ignoringVulns;
    in {
      wpa_supplicant = pkgs.wpa_supplicant.overrideAttrs ( old: rec {
          buildInputs = prev.lib.lists.remove pkgs.openssl old.buildInputs ++ [ openssl_1_1 ];
      });
      unstable = unstable_pkgs.legacyPackages.${prev.system};
    };
  in {
    nixosConfigurations.niks = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ({ config, pkgs, ... }: { nixpkgs.overlays = [ my-overlay ]; })
        ./configuration.nix 
      ];
    };
  };
}
