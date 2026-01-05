{ lib, ... }:
{
  programs.ssh = {
    extraConfig = ''
      Host nixbuild.vital.company
        Port 2222
        PubkeyAcceptedKeyTypes ssh-ed25519
        ServerAliveInterval 60
        IPQoS throughput
        IdentityFile ~/.ssh/id_nixbuild
    '';

    knownHosts = {
      nixbuild = {
        hostNames = [ "nixbuild.vital.company" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ+jBIzENqxs/p7dFEAIjG8e5TT+A9Gvhi1cKNdIJ9vW";
      };
    };
  };

  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "nixbuild.vital.company";
        system = "x86_64-linux";
        maxJobs = 64;
        speedFactor = 2;
        supportedFeatures = [ "benchmark" "big-parallel" ];
      }
      {
        hostName = "nixbuild.vital.company";
        system = "aarch64-linux";
        maxJobs = 64;
        speedFactor = 2;
        supportedFeatures = [ "benchmark" "big-parallel" ];
      }
    ];
    extraOptions = ''
      builders-use-substitutes = true
    '';
    settings.max-jobs = lib.mkDefault "auto";
  };
}
