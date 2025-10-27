{
  lib,
  pkgs,
  ...
}:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    vlad = {
      isNormalUser = true;
      description = "Vlad";
      extraGroups = [
        "networkmanager"
        "wheel"
        "dialout"
      ];
      packages = with pkgs; [ ];
      shell = pkgs.zsh; # TODO: This should be moved to the zsh module once created
    };
  };
}
