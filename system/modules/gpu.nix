{ lib, pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
  no-offload = pkgs.writeShellScriptBin "no-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=0
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=
    export __GLX_VENDOR_LIBRARY_NAME=
    export __VK_LAYER_NV_optimus=
    exec "$@"
  '';
in {
  environment.systemPackages = [ nvidia-offload no-offload ];

  specialisation = {

    sync.configuration = {
      system.nixos.tags = [ "sync" ];

      hardware.nvidia = {
        modesetting.enable = true;
        prime = {
          offload.enable = lib.mkForce false;
          sync.enable = lib.mkForce true;
        };
        powerManagement = {
          enable = lib.mkForce false;
          finegrained = lib.mkForce false;
        };
      };

      boot = {
          kernelParams =
            [ "acpi_rev_override" "mem_sleep_default=deep" "nvidia-drm.modeset=1" ];
          # kernelPackages = pkgs.linuxPackages_5_4;
          # extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
        };

      services.xserver = {
        config = ''
          Section "Device"
              Identifier  "Intel Graphics"
              Driver      "intel"
              Option      "TearFree"        "true"
              Option      "SwapbuffersWait" "true"
              BusID       "PCI:0:2:0"
          EndSection

          Section "Device"
              Identifier "nvidia"
              Driver "nvidia"
              BusID "PCI:1:0:0"
              Option "AllowEmptyInitialConfiguration"
          EndSection
        '';
        screenSection = ''
          Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
          Option         "AllowIndirectGLXProtocol" "off"
          Option         "TripleBuffer" "on"
        '';
      };
    };

    reverse-prime.configuration = {
      system.nixos.tags = [ "reverse-prime" ];

      hardware.nvidia = {
        modesetting.enable = true;
        prime = {
          offload.enable = lib.mkForce false;
          sync.enable = lib.mkForce false;
        };
        powerManagement = {
          enable = lib.mkForce false;
          finegrained = lib.mkForce false;
        };
      };

      hardware.nvidia.prime.reverseSync.enable = true;

      services.xserver = {
        config = ''
          Section "Device"
              Identifier  "Intel Graphics"
              Driver      "intel"
              Option      "TearFree"        "true"
              Option      "SwapbuffersWait" "true"
              BusID       "PCI:0:2:0"
          EndSection
        '';
        screenSection = ''
          Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
          Option         "AllowIndirectGLXProtocol" "off"
          Option         "TripleBuffer" "on"
        '';
      };
    };
  };

}
