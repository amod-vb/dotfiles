{ lib, ... }:
{
  programs = lib.genAttrs [ "git" "jujutsu" ] (_: {
    enable = true;
    settings.user = {
      email = "amod.kala@vitalbio.com";
      name = "Amod Kala";
    };
  });
}
