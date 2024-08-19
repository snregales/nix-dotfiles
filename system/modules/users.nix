{ pkgs, ... }:

{
  users.users = {
    # TODO: Add a guest users
    snregales = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Regales, Sharlon N.";
      extraGroups = [ 
        "wheel" 
        "qemu"
        "kvm"
        "libvirtd"
        "networkmanager"
      ]; 
      # TODO: Add your SSH public key(s) here, if you paln on using SSH to connect
      # openssh.authorizedKeys.keys = [];
    };
  };
}
