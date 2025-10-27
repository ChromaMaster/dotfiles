{
  lib,
  pkgs,
  ...
}:
{
  virtualisation = {
    # virtualbox = {
    #   host.enable = true;
    # };

    libvirtd = {
      enable = true;
      qemu = {
        # pkgs.qemu can emulate alien architectures (e.g. aarch64 on x86) pkgs.qemu_kvm saves disk space allowing to emulate only host architectures.
        package = pkgs.qemu_kvm;
        runAsRoot = true;
      };
    };
  };

  # users.extraGroups.vboxusers.members = [ "vlad" ];
  users.extraGroups.libvirtd.members = [ "vlad" ];
}
