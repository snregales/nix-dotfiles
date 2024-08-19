{ pkgs, ... }: 

{

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    xdgOpenUsePortal = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  programs = {
    # hyprland = {
    #   enable = true;
    #   xwayland = {
    #     enable = true;
    #   };
    #   portalPackage = pkgs.xdg-desktop-portal-hyprland;
    # };
    

    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
	  };

    zsh.enable = true;
	  mtr.enable = true;
  };
}
