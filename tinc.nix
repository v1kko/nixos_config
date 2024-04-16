{config, pkgs, ...}:

{
  systemd.services."tinc@thevpn" = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    wants = [ "network.target" ];
    description = "Tinc net %i";
    path = [ pkgs.tinc pkgs.nettools ];
    serviceConfig = {
      Type = "simple";
      WorkingDirectory="/etc/tinc/%i";
      ExecStart="/usr/bin/env tincd -n %i -D";
      ExecReload="/usr/bin/env tincd -n %i -kHUP";
      KillMode="mixed";
      Restart="on-failure";
      RestartSec=5;
      TimeoutStopSec=5;
    };
  };
}
