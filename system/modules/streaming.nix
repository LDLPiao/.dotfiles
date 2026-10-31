{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs                       # captura direta via wlr-screencopy
      obs-pipewire-audio-capture   # áudio por aplicativo
    ];
  };
}