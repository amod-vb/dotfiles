{ pkgs, lib, ... }:
let
    wallpaper = ./Vermeer-view-of-delft.jpg;
in {
    home.packages = with pkgs; [
        xclip # clipboard
        maim # screenshot
    ];

    home.file.".xinitrc".text = ''
        feh --bg-fill ${wallpaper}
        picom &
        sxhkd &
        exec bspwm
    '';

    programs = {
        feh.enable = true;
        rofi.enable = true;
    };

    services = {
        picom = import ./picom.nix;
        sxhkd = import ./sxhkd.nix;
    };

    xsession.windowManager.bspwm = import ./bspwm.nix;
}
