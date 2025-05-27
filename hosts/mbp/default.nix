{
  config,
  system,
  pkgs,
  ...
}:
{

  imports = [
    ../../hosts
  ];

  nix = {
    distributedBuilds = true;
    extraOptions = ''
      builders-use-substitutes = true
      max-jobs = 0
      build-cores = 0
      keep-outputs = true
      keep-derivations = false
    '';
  };

  ids.gids.nixbld = 350;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  users.users.amodkala.home = "/Users/amodkala";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
