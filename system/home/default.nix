{ pkgs, inputs, ... }:
{
  # Versão em que você começou a usar o Home Manager; não mude depois.
  home.stateVersion = "26.05";

  # SÓ pacotes (e, se precisar, systemd.user.services). Nada de programs.* nem
  # home.file: as configs vêm do bare repo, e o Home Manager se recusa a
  # sobrescrever arquivos que já existem.
  home.packages = with pkgs; [
    # editores e shell
    vis
    emacs-pgtk
    starship
    tree-sitter
    
    nil              # LSP do Nix

    # terminal e arquivos
    foot
    yazi

    # navegadores
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
      commandLineArgs = [ 
		"--ozone-platform-hint=auto" 
		"--enable-features=WebUIDarkMode"
	 ];
    })

    # rice inicial
    waybar
    mako
    rofi
    #eww

    # utilidades Wayland
    wl-clipboard
    grim
    slurp
    satty
    # swaybg
    awww
    brightnessctl

    # apps
    libreoffice
    #distrobox
    seahorse         # gerenciar o keyring (senha do keyring do Vivaldi)

    # CLI
    ripgrep
    fd
    fzf
    tree
    zoxide
    unzip
  ];

  # programs.obs-studio = {
  #   enable = true;
  #   plugins = with pkgs.obs-studio-plugins; [
  #     wlrobs                       # captura direta via wlr-screencopy
  #     obs-pipewire-audio-capture   # áudio por aplicativo
  #   ];
  # };

  programs.librewolf = {
    enable = true;
    settings = {
      "librewolf.webgl.prompt" = true;
      "identity.fxaccounts.enabled" = true;
    };
  };
}
