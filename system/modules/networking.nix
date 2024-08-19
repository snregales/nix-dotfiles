{ ... }:

{
  networking = {
    hostName = "devnl";
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall.enable = false;
  };
}
