{ config, pkgs, ... }:
{

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "amod-vb";
      userEmail = "amod.kala@vitalbio.com";
    };

    neovim.package = pkgs.neovim;
  };

  home = {
    packages = [
      pkgs.claude-code
    ];
    stateVersion = "25.05";
  };
}
