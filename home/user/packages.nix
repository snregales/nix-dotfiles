{ pkgs, pkgs-unstable, ... }:

{
  

  home.packages = [

    # Dev stuff
    pkgs.gcc
    pkgs.go
    pkgs.lua
    pkgs.nodejs_20
    pkgs.nodePackages.pnpm
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.pip
      python-pkgs.requests
    ]))
    pkgs.rustup
    pkgs.zig
    
    # Work stuff
    pkgs.obsidian
    pkgs.teams-for-linux
    pkgs.thunderbird
    pkgs.libreoffice-qt
    pkgs.hunspell
 
    # Bluetooth
    pkgs.blueberry

    # Social
    pkgs-unstable.vesktop

    # Utils
    pkgs.viewnior
    pkgs-unstable.hyprshot
    pkgs.catppuccin-cursors.macchiatoBlue
    pkgs.catppuccin-gtk
    pkgs.papirus-folders
    pkgs.tldr
    pkgs.kitty
  ];
}
