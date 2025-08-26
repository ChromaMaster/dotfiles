{
  lib,
  pkgs,
  ...
}:
{
  virtualisation = {
    virtualbox = {
      host.enable = true;
    };
  };
}
