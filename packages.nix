self: super:
{
    doq = super.callPackage ./packages/doq.nix {};
    makedepf90 = super.callPackage ./packages/makedepf90.nix {};
    voms-clients = super.callPackage ./packages/voms-clients.nix {};
    xrootd = super.callPackage ./packages/xrootd.nix {};
    xrootd_new = super.callPackage ./packages/xrootd.nix {};
    vim_config = super.vim.overrideAttrs (old: {
      buildInputs = old.buildInputs ++ [ super.pkgs.xorg.libX11 super.pkgs.xorg.libXt];
      configureFlags = old.configureFlags ++ [ "--with-x" ];
    });
    #gfal2 = super.callPackage ./packages/gfal2.nix {};
    #gfal2-python = super.callPackage ./packages/gfal2-python.nix {};
    #gfal2-util = super.callPackage ./packages/gfal2-util.nix {};
    rucio-clients = super.callPackage ./packages/rucio-clients.nix {};
    tws = super.callPackage ./packages/tws.nix {};
    oidc-agent = super.callPackage ./packages/oidc-agent.nix {};
}
