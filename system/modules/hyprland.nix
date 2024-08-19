{ pkgs, ... }:

{
  programs = {
    hyprland = {
        enable = true;
        xwayland.enable = true;
    };
    hyprlock.enable = true;
  };
  services.hypridle.enable = true;
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    systemPackages = with pkgs; [
      xdg-desktop-portal-hyprland
      hyprpaper
      kitty
      libnotify
      mako
      qt5.qtwayland
      qt6.qtwayland
      swayidle
      swaylock-effects
      wlogout
      wl-clipboard
      wofi
      waybar
    ];
  };
}
