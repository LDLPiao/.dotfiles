{ ... }:
{
  imports = [ ./hardware-configuration.nix ];  # copie de /etc/nixos

  networking.hostName = "thinkpad";

  # --- COPIE DO SEU configuration.nix ATUAL ---------------------------------
  # 1) stateVersion: precisa ser o valor do seu sistema já instalado.
  #    O throw abaixo falha de propósito até você trocar pelo valor real.
  system.stateVersion = "26.05";

  # 2) bootloader (o que você já usa: systemd-boot, GRUB, Limine...)
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
}
