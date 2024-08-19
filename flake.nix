{
  description = "snregales fork of gpskwlkr NixOS";

  inputs = {
    ###
    # Hardware configuration channels
    ###

    hardware.url = "github:NixOS/nixos-hardware/master";
    systems.url = "github:nix-systems/default-linux";

    ###
    # Nixpkgs
    ###

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
        url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
        url = "github:nix-community/lanzaboote/v0.3.0";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ###
    # Unstable
    ###

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland = {
      url = "git+https://github.com/hyprwm/hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprkeys = {
      url = "github:hyprland-community/hyprkeys";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, lanzaboote, hardware, ... } @inputs:
	let
    lib = nixpkgs.lib;
    # eachSystem = nixpkgs.lib.genAttrs(import inputs.systems);
    # pkgs = eachSystem (system: nixpkgs.legacyPackages.${system});
    # pkgs-unstable = eachSystem (system: nixpkgs-unstable.legacyPackages.${system});
    # formatter = eachSystem (system: inputs.alejandra.defaultPackage.${system});
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    formatter = inputs.alejandra.defaultPackage.${system};
	in {
		nixosConfigurations = {
      devnl = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/configuration.nix
          lanzaboote.nixosModules.lanzaboote
          { environment.systemPackages = [ formatter ]; }
        ];
        specialArgs = {
          inherit pkgs-unstable;
          inherit hardware;
        };
      };
    };

		homeConfigurations = {
			snregales = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [
          # inputs.hyprland.homeManagerModules.default
          # {
          #   wayland.windowManager.hyprland = {
          #     enable = true;
          #     systemd.enableXdgAutostart = true;
          #   };
          # }
          ./home
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
          inherit inputs;
        };
			};
		};
  };
}
