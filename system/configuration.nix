{ hardware, ... }:

{
  imports = [
    ./hardware-configuration.nix
    hardware.nixosModules.dell-xps-15-9500-nvidia
    ./modules
  ];

  system.stateVersion = "24.05";
}

