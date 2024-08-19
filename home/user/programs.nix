{ inputs, ... }:
{
  programs = {
    firefox = {
      enable = true;

      profiles.snregales = {
          extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
              # bypass-paywalls-clean
              darkreader
              # facebook-container
              i-dont-care-about-cookies
              # proton-pass
              to-google-translate
              view-image
              ublock-origin
              youtube-shorts-block
          ];
      };
    };

    zellij = {
      enable = true;
      enableZshIntegration = true;
    };

    oh-my-posh = {
      enable = true;
      useTheme = "tokyonight_storm";
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = true;
      withPython3 = true;
    };

    lazygit.enable = true;
    home-manager.enable = true;
    bat.enable = true;
  };
}
