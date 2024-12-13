{ pkgs, lib, ... }:
{
    imports = [
        ./plugins.nix
    ];

    home.packages = with pkgs; [
        rust-analyzer
        cargo
        rustc

        nixd

        ghc
        haskell-language-server

        gcc
    ];

    xdg = {
        configFile.nvim = {
            source = ./config;
            recursive = true;
        };
    };

    programs.neovim = {
        enable = true;
        defaultEditor = true;

        vimAlias = true;
        viAlias = true;

        extraPackages = with pkgs; [
            ripgrep
        ];

        extraConfig = ''
            :luafile ~/.config/nvim/lua/init.lua
        '';
    };
}
