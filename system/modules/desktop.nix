{ pkgs, ... }:
{
  # O módulo do Mango já instala o básico de um ambiente Wayland funcional.
  # Se faltar algo (portal, polkit), acrescente aqui.
  programs.mango.enable = true;

  hardware.graphics.enable = true;   # Mesa (Intel) e base para o NVIDIA

  # Vivaldi (Chromium) em Wayland nativo
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Início do Mango pelo tty1 (o mesmo que você já usa hoje)
  environment.loginShellInit = ''
    [ "$(tty)" = /dev/tty1 ] && exec mango
  '';

  # Keyring (secret service) para o Vivaldi não pedir senha a cada início.
  # Ele é destravado pela senha digitada no login do tty: NÃO funciona com
  # services.getty.autologinUser (veja a resposta no chat).
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Programas de usuário ficam em ../home/default.nix.
}
