{
  config,
  system,
  pkgs,
  ...
}:
{
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "amod" ];
    };
    # buildMachines = [
    #   {
    #     hostName = "nixbuild.vital.company";
    #     system = "x86_64-linux";
    #     maxJobs = 64;
    #     speedFactor = 2;
    #     supportedFeatures = [
    #       "benchmark"
    #       "big-parallel"
    #     ];
    #   }
    #   {
    #     hostName = "nixbuild.vital.company";
    #     system = "aarch64-linux";
    #     maxJobs = 64;
    #     speedFactor = 2;
    #     supportedFeatures = [
    #       "benchmark"
    #       "big-parallel"
    #     ];
    #   }
    # ];

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
  };
  services.tailscale.enable = true;
}
