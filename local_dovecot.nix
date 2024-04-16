{ config, pkgs, ... }:

{
  # Get cron delivered right to your thunderbird, excellent
  services.dovecot2 = {
    enable = true;
    enablePAM = false;
    enablePop3 = false;
    extraConfig = ''
      listen = localhost
      passdb {
        driver = static
        args = nopassword
      }
      userdb {
        driver = static
        args = gid=users home=/home/%n uid=vikko
      }
    '';
    mailLocation = "maildir:/var/spool/mail/%u";
  };
}
