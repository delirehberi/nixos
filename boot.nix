{config,lib, pkgs, ...}:

{
  boot.blacklistedKernelModules = ["hp_wmi"];
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.cleanTmpDir = true;
  boot.kernelModules = ["coretemp" "adm1021"];
}
