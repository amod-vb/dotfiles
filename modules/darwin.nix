{
  nixpkgs = {
    config.allowUnfree = true;
  };
  # Required for nix-darwin to work
  system.stateVersion = 1;

  users.users.amodkala = {
    name = "amodkala";
    home = "/Users/amodkala";
  };

  programs.zsh.enable = true;
}
