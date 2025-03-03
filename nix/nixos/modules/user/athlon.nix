{
  lib,
  pkgs,
  ...
}:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    athlon = {
      isNormalUser = true;
      description = "athlon";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [ ];
      shell = pkgs.zsh; # TODO: This should be moved to the zsh module once created
    };
  };
}
