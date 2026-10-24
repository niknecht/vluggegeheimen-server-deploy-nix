{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  users.groups.share = {};

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "share" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKLu3yj2HCRbXd7ORs9AzLo/lRQkg2yUmj8e/1ivTLTs admin@file-server"
    ];
  };


  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentifical = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
